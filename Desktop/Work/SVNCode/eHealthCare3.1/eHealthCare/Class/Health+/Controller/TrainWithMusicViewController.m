//
//  TrainWithMusicViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "TrainWithMusicViewController.h"
#import "MusicTrainChoseTopicView.h"
#import "BaseWeatherSceneView.h"
#import "CADisplayLineImageView.h"
#import "MusicTrainViewModel.h"

#import "WeatherSceneManager.h"
#import "SJMP3Player.h"
#import "XKMorningTimerView.h"
#import "XKMorningCircleView.h"
@interface TrainWithMusicViewController () <MusicTrainChoseTopicDelegate>
{
    CADisplayLineImageView *displayImageView;
    ///早安晚安动画视图
    BaseWeatherSceneView *sceneView;
    
    
    NSTimer *_timer;//倒计时
    
    int sunTime;//指定倒计时的时间
     NSTimer *autumnRainTimer;//倒计时
    float playerTimes;//播放的次数
    
    UIButton *backButton;
}
@property (strong, nonatomic)  UIButton *ringBtn;
@property (nonatomic,assign) int timeCount;
@property (nonatomic,assign) int touchCount;
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UILabel *titleLabel;///标题
@property (nonatomic, strong) UIButton *playOrPauseButton;

@property (nonatomic, strong) MusicTrainChoseTopicView *topicView;


/******************动画******************/
///秋高气爽的动画背景图
@property (nonatomic, strong) UIImageView *progressBGImageView;
///海上初日的背景图
@property (nonatomic, strong) UIImageView *cloudImageView;
///夜晚的动画
@property (nonatomic, strong) UIImageView *nightImageView;
/**
 进度条
 */
@property (nonatomic,strong)XKMorningCircleView *circleView;
/**
 闹钟试图
 */
@property (nonatomic,strong)XKMorningTimerView *topView;
@property (nonatomic, strong) SJMP3Player *player;
@end
@implementation TrainWithMusicViewController

#pragma mark life cycle
- (SJMP3Player *)player {
    if ( _player )
        return _player;
    _player = [SJMP3Player player];
    _player.delegate = self;
    _player.enableDBUG = YES;
    return _player;
}
-(XKMorningTimerView *)topView{
    
    if (!_topView) {
        
        _topView=[[[NSBundle mainBundle]loadNibNamed:@"XKMorningTimerView" owner:self options:nil]firstObject];
        
        _topView.x=0;
        
        _topView.y=0;
        
        _topView.width=KScreenWidth;
        
        _topView.height=KScreenHeight;
        
        _topView.delegate = self;
    }
    return _topView;
}

-(XKMorningCircleView *)circleView{
    
    if (!_circleView) {
        
        _circleView=[[[NSBundle mainBundle]loadNibNamed:@"XKMorningCircleView" owner:self options:nil]firstObject];
        
        _circleView.x=0;
        
        _circleView.y=100;
        
        _circleView.width=KScreenWidth;
        
        _circleView.height=KScreenHeight-100;
        
        _circleView.delegate = self;
    }
    return _circleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCADisplayLineImageView:self.model.BgImgUrl];
    [self createUI];
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([r currentReachabilityStatus] == ReachableViaWiFi) {
        //开始下载歌曲
    }
    if (self.player) {
        self.player = nil;
    }
    [self.player playWithURL:[NSURL URLWithString:self.model.MusicUrl]];/*@"http://192.168.1.6:8023//Upload//UploadMusic//20171102145642yangweiweiyixiao.mp3"*/ //@"http://img.xiekang.net/Upload/UploadMusic/20171121233033mouxiang.mp3"
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.player playWithURL:@"http://audio.cdn.lanwuzhe.com/Ofenbach+-+Katchi15267958245107aa1.mp3" minDuration:5];
//    });
   
//    self.player.audioPlayer.isPlaying = YES;
    [[NSUserDefaults standardUserDefaults]setObject:self.model.MusicUrl forKey:@"MusicUrl"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self updateUserBehaviorWithNetWorking];
    //加载数据
    [self loadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.touchCount = 1;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  self.touchCount = 1;
    [_player pause];
    [_timer invalidate];
    _timer = nil;
    
    if (autumnRainTimer) {
        [autumnRainTimer invalidate];
        autumnRainTimer = nil;
    }
}

#pragma mark UI
- (void)createUI
{
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MusicTrain_background_quiet"]];
    
    backView.userInteractionEnabled = YES;
    
    [self.view addSubview:backView];
    self.backView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = Kfont(20);
    titleLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.myTitle;
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.top.mas_equalTo((PublicY) - 42);
        make.height.mas_equalTo(40);
    }];
    self.titleLabel = titleLab;
    
    //返回按钮
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.top.mas_equalTo((PublicY) - 42);
        make.width.height.mas_equalTo(40);
    }];
    
    self.ringBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.ringBtn setBackgroundImage:[UIImage imageNamed:@"morningAndNighttitle"] forState:UIControlStateNormal];
    
    [self.ringBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ringBtn.frame = CGRectMake((KScreenWidth-67)/2.0, (KScreenHeight-67)/2.0, 67, 67);
    
    [self.view addSubview:self.ringBtn];
    
    
    
//    //播放暂停按钮
//    UIButton *playOrPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [playOrPauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
//    [playOrPauseButton addTarget:self action:@selector(playMusicOrPauseAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [backView addSubview:playOrPauseButton];
//    self.playOrPauseButton = playOrPauseButton;
//    
//    [playOrPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.mas_equalTo( - KHeight(60));
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(KWidth(65), KWidth(65)));
//    }];
    backButton.hidden = YES;
    self.ringBtn.hidden = YES;
    
    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
    [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(13)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(13)} isPopView:YES];
}
#pragma mark XKMorningTimerViewDelegate
- (IBAction)btnAction:(id)sender {
    [self.view addSubview:self.topView];
    
    self.titleLab.hidden = YES;
    backButton.hidden = YES;
    self.ringBtn.hidden = YES;
   
}

#pragma mark -SJMPp3Player

- (void)audioPlayer:(SJMP3Player *)player audioDownloadProgress:(CGFloat)progress {
    NSLog(@"audioDownloadProgress:%lf",progress);
    
}

- (void)audioPlayer:(SJMP3Player *)player currentTime:(NSTimeInterval)currentTime reachableTime:(NSTimeInterval)reachableTime totalTime:(NSTimeInterval)totalTime {
    playerTimes = (double)sunTime/totalTime;
    
    NSLog(@"totalTime--::::%lf---------------currentTime:%lf-------%lf",totalTime,currentTime * 1.0 / totalTime,self.circleView.progress);
    
    
    
}
- (void)audioPlayerDidFinishPlaying:(SJMP3Player *)player {
    NSLog(@"----22222-#####################---%d---%lf--------%lf",sunTime,player.audioPlayer.duration,playerTimes*player.audioPlayer.duration);
    if (_timeCount > 0 ) {
        
        [self.player resume];
    }
    
}
#pragma mark Action

- (void)loadData
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        

    [self.backView sd_setImageWithURL:[NSURL URLWithString:self.model.BgImgUrl] placeholderImage:[UIImage imageNamed:@"MusicTrain_background_quiet"]];

        
    self.titleLabel.text = self.model.EaseName;
        
//        [self startMusicPlayerWithURL:[NSURL URLWithString:@"http://img.xiekang.net/Upload/UploadMusic/20171121233033mouxiang.mp3"]];

            [self addAnimationAtMorningOrEverning];
  
    });
    
}
//播放或暂停
- (void)playMusicOrPauseAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
       
    }else
    {
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
       
    }
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark NetWorking
//上传用户行为
- (void)updateUserBehaviorWithNetWorking
{
    NSInteger behaviorType = 0;
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"MemName":[UserInfoTool getLoginInfo].Name,
                          @"Mobile":[UserInfoTool getLoginInfo].Mobile,
                          @"BehaviorType":@(self.model.MindfulnessType),
                          @"EaseID":@(self.model.EaseID)};

    [MusicTrainViewModel updateUseBehaviorWithParams:dic FinishedBlock:^(ResponseObject *response) {

        if (response.code == CodeTypeSucceed ) {

            NSLog(@"上传用户行为成功");

        }else{

            NSLog(@"上传用户行为失败");
        }
    }];
}

#pragma mark 早安和晚安的动画特效
- (void)addAnimationAtMorningOrEverning
{
    [displayImageView sd_setImageWithURL:[NSURL URLWithString:self.model.BgImgUrl] placeholderImage:[UIImage imageNamed:@"MusicTrain_background_quiet"]];

    if (sceneView) {
        [sceneView removeFromSuperview];
    }
    if (self.progressBGImageView ) {
        [self.progressBGImageView removeFromSuperview];

    }
    if (self.cloudImageView) {
        [self.cloudImageView removeFromSuperview];
    }

    if (self.nightImageView) {
        [self.nightImageView removeFromSuperview];
    }

    if ([self.model.EaseName isEqualToString:@"雪花飞舞"]||[self.model.EaseName isEqualToString:@"冬雪早晨"]) {

        sceneView = [[WeatherSceneManager sharedSceneManager] showWeatherSceneWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight) weatherType:HeavySnowScene imgName:@"snow"];
        [displayImageView addSubview:sceneView];
    }
    if ([self.model.EaseName isEqualToString:@"夜晚清凉"]) {

        self.progressBGImageView = [[WeatherSceneManager sharedSceneManager] showWeatherWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight) weatherType:300 imgName:@""];
        [self.view addSubview:_progressBGImageView];
    }
    if ([self.model.EaseName isEqualToString:@"秋天的雨"]) {

        sceneView = [[WeatherSceneManager sharedSceneManager] showWeatherSceneWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight) weatherType:HeavyRainScene imgName:@"rain"];
        [displayImageView addSubview:sceneView];
    }
    if ([self.model.EaseName isEqualToString:@"秋高气爽"]) {

        self.progressBGImageView = [[WeatherSceneManager sharedSceneManager] showWeatherWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight) weatherType:100 imgName:@""];
        [self.view addSubview:_progressBGImageView];


    }
    if ([self.model.EaseName isEqualToString:@"森林清晨"]) {
        self.progressBGImageView = [[WeatherSceneManager sharedSceneManager] showWeatherWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight) weatherType:301 imgName:@""];
        [self.view addSubview:_progressBGImageView];


    }
    if ([self.model.EaseName isEqualToString:@"海边漫步"]) {
        self.nightImageView = [[WeatherSceneManager sharedSceneManager] showWeatherWithFrame:CGRectMake(KWidth(174), KHeight(1.5), 208.5 , 200) weatherType:111 imgName:@"night_moon"];

        [displayImageView addSubview:_nightImageView];
    }
    if ([self.model.EaseName isEqualToString:@"海上日出"]) {

        self.cloudImageView = [[WeatherSceneManager sharedSceneManager] showWeatherWithFrame:CGRectMake( - KWidth(104), KHeight(80), 289.5 * 0.9 , 54 * 0.9) weatherType:222 imgName:@"cloudFloat"];
        [displayImageView addSubview:_cloudImageView];
    }
}

-(void)loadCADisplayLineImageView:(NSString *)imageName
{
    displayImageView = [[CADisplayLineImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight)];
    [self.view addSubview:displayImageView];

    [displayImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"MusicTrain_background_quiet"]];
}
/**
 点击取消按钮
 */
-(void)cancelSelectTime;
{
    
    self.ringBtn.hidden = NO;
    backButton.hidden = NO;
   
    [self.topView removeFromSuperview];
    
}
/**
 选择开始确定的时间
 
 @param time <#time description#>
 */
-(void)checkSelectTime:(int )time;
{
    self.ringBtn.hidden = YES;
    backButton.hidden = YES;
    self.titleLab.hidden = NO;
    [self.topView removeFromSuperview];
    [self.view addSubview:self.circleView];
    
    
    _timeCount = time;
    sunTime = time;
    int minutes = _timeCount / 60;
    int seconds = _timeCount%60;
    int hours;
    
    self.circleView.countTimeLab.font = [UIFont systemFontOfSize:62.f];
    NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
    if (sunTime>3600) {
        hours  = _timeCount / 3600;
        minutes = (_timeCount - (3600*hours)) / 60;
        seconds = _timeCount%60;
        strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes,seconds];
        self.circleView.countTimeLab.font = [UIFont systemFontOfSize:42.f];
    }
    self.circleView.countTimeLab.text = strTime;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tenTimeDone) userInfo:nil repeats:YES];
    
}

/**
 定时器数据
 */
-(void)tenTimeDone
{
    
    int minutes = _timeCount / 60;
    int seconds = _timeCount%60;
    int hours;
    _timeCount --;
    NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
    if (sunTime>3600) {
        hours  = _timeCount / 3600;
        minutes = (_timeCount - (3600*hours)) / 60;
        seconds = _timeCount%60;
        strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes,seconds];
    }
    self.circleView.countTimeLab.text = strTime;
    self.circleView.progress = (double)(sunTime-_timeCount)/(double)sunTime;
    
    if (_timeCount <= 0 ) {
        [self.player stop];
        self.circleView.countTimeLab.text = @"00:00";
        [_timer invalidate];
        _timer = nil;
        
        
        
    }
}

#pragma mark XKMorningCircleViewDelegate 代理
-(void)pauseAndBeginMusic:(BOOL)isPlay;
{
    if (isPlay) {
        [_player pause];
        backButton.hidden = NO;
        [_timer setFireDate:[NSDate distantFuture]];
      
        self.titleLab.hidden = NO;
        NSLog(@"---3333333--#####################------");
    }
    else
    {
        NSLog(@"--4444444---#####################------");
        [_timer setFireDate:[NSDate distantPast]];
        backButton.hidden = YES;
      
        self.titleLab.hidden = NO;
        [_player resume];
        
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ( self.touchCount == 1) {
        backButton.hidden = NO;
        self.ringBtn.hidden = NO;
        self.titleLab.hidden = NO;
        
        self.touchCount++ ;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
