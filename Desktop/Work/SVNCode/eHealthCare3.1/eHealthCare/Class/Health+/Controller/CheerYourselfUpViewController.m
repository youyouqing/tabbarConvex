//
//  CheerYourselfUpViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "CheerYourselfUpViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "CheerUpPrepareView.h"
#import "POVoiceHUD.h"

#import "CheerYourselfUpModel.h"

#import "CheerYourselfUpViewModel.h"


#define BUFFER_COUNT 15

@interface CheerYourselfUpViewController () <CheerYourselPrepareViewDelegate,POVoiceHUDDelegate>
{
    AVAudioSession *audioSession;
    AUGraph auGraph;
    AudioUnit remoteIOUnit;
    AUNode remoteIONode;
    AURenderCallbackStruct inputProc;
    BOOL isMute;
}

@property(nonatomic,assign) AudioStreamBasicDescription streamFormat;

@property (nonatomic, strong) POVoiceHUD *voiceHud;

//描述标签
@property (nonatomic, strong) UILabel *markLab;
//长按按钮
@property (nonatomic, strong) UIImageView *longPressBtn;


/**
 准备视图属性
 */
@property (nonatomic,strong) CheerUpPrepareView *prepareView;

/**
 文案数组
 */
@property (nonatomic,strong) NSMutableArray *dataArray;

/**当前页面*/
@property (nonatomic,assign) NSInteger cunrrentIndex;

/**表示总的页数*/
@property (nonatomic,assign) NSInteger totalPageCount;

/**长按按钮*/
@property (nonatomic, strong) UIButton *longBtn;

@end

@implementation CheerYourselfUpViewController

static OSStatus    PerformThru(
                               void                        *inRefCon,
                               AudioUnitRenderActionFlags     *ioActionFlags,
                               const AudioTimeStamp         *inTimeStamp,
                               UInt32                         inBusNumber,
                               UInt32                         inNumberFrames,
                               AudioBufferList             *ioData)
{
    CheerYourselfUpViewController *THIS=(__bridge CheerYourselfUpViewController*)inRefCon;
    
    OSStatus renderErr = AudioUnitRender(THIS->remoteIOUnit, ioActionFlags,
                                         inTimeStamp, 1, inNumberFrames, ioData);
    
    if (THIS->isMute == YES){
        //Clear two channel mData
        for (UInt32 i=0; i < ioData->mNumberBuffers; i++)
        {
            memset(ioData->mBuffers[i].mData, 0, ioData->mBuffers[i].mDataByteSize);
        }
    }
    
    if (renderErr < 0) {
        return renderErr;
    }
    
    
    return noErr;
}

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    [self initRemoteIO];
    self.markLab.hidden = YES;
    self.longPressBtn.hidden = YES;
    self.totalPageCount = 0;
    
    [self.view addSubview:self.prepareView];
    [self.prepareView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset( - KHeight(20));
        make.left.mas_equalTo(KScreenWidth / 2 - KWidth(150));
        make.size.mas_equalTo(CGSizeMake(KWidth(300), KHeight(350)));
        
    }];
    
    isMute = NO;
    
    self.voiceHud = [[POVoiceHUD alloc] initWithParentView:self.view];
    self.voiceHud.title = @"Speak Now";
    self.voiceHud.backgroundColor = [UIColor clearColor];
    [self.voiceHud setDelegate:self];
    [self.view addSubview:self.voiceHud];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self startWave];
    //    });
    self.voiceHud.hidden = YES;
    self.cunrrentIndex = 0;//初始化当前页数为一
    
    self.longBtn.enabled = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)dealloc
{
    [self.voiceHud cancelRecording];
    CheckError(AUGraphRemoveNode(auGraph, remoteIONode), "奔溃");
    AUGraphClearConnections(auGraph);
    CheckError(AUGraphStop(auGraph), "奔溃");
    audioSession = nil;
    CheckError(AUGraphClose(auGraph), "奔溃");
    auGraph = nil;
    remoteIOUnit = nil;
    [self.voiceHud removeFromSuperview];
}
#pragma mark UI
- (void)createUI
{
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CheerUp_background_fighting"]];
    
    backView.userInteractionEnabled = YES;
    
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    //长按按钮
    UIButton *longTouchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [longTouchButton setImage:[UIImage imageNamed:@"CheerYourselfUp_press"] forState:UIControlStateNormal];
    [longTouchButton addTarget:self action:@selector(longtapStart:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:longTouchButton];
    [longTouchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(- KHeight(30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(123), KWidth(123)));
    }];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.top.mas_equalTo((PublicY) - 42);
        make.width.height.mas_equalTo(40);
    }];
}


#pragma mark Action
- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 长按开始
 */
- (void)longtapStart:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"长按开始");
    //加载数据数据
    [self loadData];
    self.voiceHud.hidden = NO;
}

/**
 长按开始
 */
- (void)clickLongStart:(id)sender
{
    NSLog(@"长按开始");
    if (self.cunrrentIndex > self.totalPageCount) {
        return;
    }else{
        //加载数据数据
        [self loadData];
    }
    self.voiceHud.hidden = NO;
}

@synthesize streamFormat;

#pragma mark private
-(void)loadData{
    self.cunrrentIndex ++;
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"PageIndex":@(self.cunrrentIndex),
                          @"PageSize":@1};
    
    [CheerYourselfUpViewModel getListenMyselfListWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            //广告信息
            self.dataArray =  (NSMutableArray *)[CheerYourselfUpModel mj_objectArrayWithKeyValuesArray:response.Result];
            if (self.dataArray.count > 0) {
                
                CheerYourselfUpModel *model = self.dataArray[0];
                self.markLab.text = model.Content;
                
            }else{
                
                ShowErrorStatus(response.msg);
            }
        }
    }];
}

- (void)initRemoteIO
{
    audioSession = [AVAudioSession sharedInstance];
    
    NSError *error;
    // set Category for Play and Record
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [audioSession setPreferredSampleRate:(double)44100.0 error:&error];
    //init RemoteIO
    CheckError (NewAUGraph(&auGraph),"couldn't NewAUGraph");
    CheckError(AUGraphOpen(auGraph),"couldn't AUGraphOpen");
    //
    AudioComponentDescription componentDesc;
    componentDesc.componentType = kAudioUnitType_Output;
    componentDesc.componentSubType = kAudioUnitSubType_RemoteIO;
    componentDesc.componentManufacturer = kAudioUnitManufacturer_Apple;
    componentDesc.componentFlags = 0;
    componentDesc.componentFlagsMask = 0;
    //
    CheckError (AUGraphAddNode(auGraph,&componentDesc,&remoteIONode),"couldn't add remote io node");
    CheckError(AUGraphNodeInfo(auGraph,remoteIONode,NULL,&remoteIOUnit),"couldn't get remote io unit from node");
    
    //set BUS
    UInt32 oneFlag = 1;
    UInt32 busZero = 0;
    CheckError(AudioUnitSetProperty(remoteIOUnit,
                                    kAudioOutputUnitProperty_EnableIO,
                                    kAudioUnitScope_Output,
                                    busZero,
                                    &oneFlag,
                                    sizeof(oneFlag)),"couldn't kAudioOutputUnitProperty_EnableIO with kAudioUnitScope_Output");
    //
    UInt32 busOne = 1;
    CheckError(AudioUnitSetProperty(remoteIOUnit,
                                    kAudioOutputUnitProperty_EnableIO,
                                    kAudioUnitScope_Input,
                                    busOne,
                                    &oneFlag,
                                    sizeof(oneFlag)),"couldn't kAudioOutputUnitProperty_EnableIO with kAudioUnitScope_Input");
    
    AudioStreamBasicDescription effectDataFormat;
    UInt32 propSize = sizeof(effectDataFormat);
    CheckError(AudioUnitGetProperty(remoteIOUnit,
                                    kAudioUnitProperty_StreamFormat,
                                    kAudioUnitScope_Output,
                                    0,
                                    &effectDataFormat,
                                    &propSize),"couldn't get kAudioUnitProperty_StreamFormat with kAudioUnitScope_Output");
    
    CheckError(AudioUnitSetProperty(remoteIOUnit,
                                    kAudioUnitProperty_StreamFormat,
                                    kAudioUnitScope_Output,
                                    1,
                                    &effectDataFormat,
                                    propSize),"couldn't set kAudioUnitProperty_StreamFormat with kAudioUnitScope_Output");
    
    CheckError(AudioUnitSetProperty(remoteIOUnit,
                                    kAudioUnitProperty_StreamFormat,
                                    kAudioUnitScope_Input,
                                    0,
                                    &effectDataFormat,
                                    propSize),"couldn't set kAudioUnitProperty_StreamFormat with kAudioUnitScope_Input");
    
    
    inputProc.inputProc = PerformThru;
    inputProc.inputProcRefCon = (__bridge void *)(self);
    CheckError(AUGraphSetNodeInputCallback(auGraph, remoteIONode, 0, &inputProc),"Error setting io output callback");
    //
    CheckError(AUGraphInitialize(auGraph),"couldn't AUGraphInitialize" );
    CheckError(AUGraphUpdate(auGraph, NULL),"couldn't AUGraphUpdate" );
    CheckError(AUGraphStart(auGraph),"couldn't AUGraphStart");
    //
    CAShow(auGraph);
    
    
}

//
static void CheckError(OSStatus error, const char *operation)
{
    if (error == noErr) return;
    
    char str[20];
    // see if it appears to be a 4-char-code
    *(UInt32 *)(str + 1) = CFSwapInt32HostToBig(error);
    if (isprint(str[1]) && isprint(str[2]) && isprint(str[3]) && isprint(str[4])) {
        str[0] = str[5] = '\'';
        str[6] = '\0';
    } else
        // no, format it as an integer
        sprintf(str, "%d", (int)error);
    
    fprintf(stderr, "Error: %s (%s)\n", operation, str);
    
    exit(1);
}

- (void)startWave {
    [self.voiceHud startForFilePath:[NSString stringWithFormat:@"%@/Documents/MySound.caf", NSHomeDirectory()]];
}

#pragma mark - POVoiceHUD Delegate

- (void)POVoiceHUD:(POVoiceHUD *)voiceHUD voiceRecorded:(NSString *)recordPath length:(float)recordLength {
    NSLog(@"Sound recorded with file %@ for %.2f seconds", [recordPath lastPathComponent], recordLength);
}

- (void)voiceRecordCancelledByUser:(POVoiceHUD *)voiceHUD {
    NSLog(@"Voice recording cancelled for HUD: %@", voiceHUD);
}

#pragma mark CheerYourselPrepareView delegate
- (void)prepare
{//弹窗协议方法
    self.markLab.hidden = NO;
    self.longPressBtn.hidden = NO;
    self.voiceHud.hidden = NO;
    self.longBtn.enabled = YES;
}

#pragma mark lazy load
- (CheerUpPrepareView *)prepareView{
    if (!_prepareView) {
        _prepareView = [[CheerUpPrepareView alloc]initWithFrame:CGRectZero];
        _prepareView.backgroundColor = [UIColor whiteColor];
        _prepareView.delegate = self;
    }
    return _prepareView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end