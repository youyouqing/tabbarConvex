//
//  CheckResultViewController.m
//  NewEquipmentCheck
//
//  Created by xiekang on 2017/8/16.
//  Copyright © 2017年 ZM. All rights reserved.
//检测结果过渡页面

#import "CheckResultViewController.h"
#import "CheckHeaderResultView.h"
#import "XKXKCheckResultWeightTableViewCell.h"
#import "XKCheckResultWeightTwoTableViewCell.h"
#import "XKCheckResultView.h"
#import "XKSingleCheckMultipleCommonResultCell.h"
#import "QingNiuSDK.h"
#import "QingNiuDevice.h"
#import "QingNiuUser.h"
#import "XKBackButton.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "XKSingleCheckMultipleCommonResultHeadView.h"
#import "XKSingleCheckMultipleCommonPresResultHeadView.h"
#import "XKSingleCheckMultipleCommonResultFootView.h"
#import "ExchinereportModel.h"
#import "MSBluetoothManager.h"
#import "BLEManager.h"
#import "TTCDeviceInfo.h"
#import "XKCheckResultSugarTopView.h"
#import "XKCheckHeaderCommonResultView.h"
#import "XKDectingViewController.h"
#import "XKValidationAndAddScoreTools.h"
//#import "XKCheckResultViewController.h"
#import "XKCheckResultCommonViewController.h"
#import "CRCreativeSDK.h"
#import "XKSearchToolView.h"
@interface CheckResultViewController ()
{
    
    UIButton *leftBackBtn;
    
    
    UIButton *centerBtn;//血糖顶部按钮
    BOOL isOpenSelectView;
    
    NSTimer *_timer;//倒计时测量中转圈
    
    
    NSMutableArray *foundPorts;//脉搏波血氧
    
    NSInteger qinNiuTag;//标记青牛体脂秤链接状态
    UIButton *_scanButton;//体脂秤
    NSMutableArray *_allScanDevice;
    NSMutableArray *_deviceData;
    NSDictionary *_deviceDataDic;
    BOOL _scanFlag;
    QingNiuWeightUnit _qingNiuWeightUnit;
    
    
    
    
    CBPeripheral* cb123;//爱奥乐
    BLEManager* _bleManager;
    
    //  爱奥乐
    NSMutableArray* _deviceArray;
    NSTimer* _scanTimer;
    NSInteger* _scnaID;
    
    NSInteger a;
    NSTimer* _connectTimer;//关闭爱奥乐定时器连接数据
    
    UILabel *centerNameLab;//居中显示title
    
    NSTimer *BLEManagerAiAoleTimer;
}

@property (nonatomic,strong) UIButton *shareBtn;//分享按钮
@property (nonatomic,strong) NSArray *totalArray;
@property (nonatomic,strong) MSBluetoothManager *toothM;
/**
 跳转一次
 */
@property (nonatomic,assign)NSInteger jumpCountIndex;
@property (nonatomic,assign)NSInteger PressjumpCountIndex;
@property (nonatomic, strong) ExchinereportModel *exModel;//单项检测页模型数据
@property (nonatomic, strong) NSArray *exDataArr;//多项检测页数据数组
/**
 随机  餐前2小时    餐后
 */
@property (nonatomic, strong)XKCheckResultSugarTopView *SugarTopView;
/**
 蓝牙工具
 */
@property (nonatomic,strong)BluetoothConnectionTool *bc;
@property (nonatomic,assign)NSInteger connectionStatus;
@property (nonatomic,copy)NSString *centerTopName;
@property(strong,nonatomic)CBCentralManager* CM;
@property (weak, nonatomic) IBOutlet UITableView *tab;
/**
 体重结果页区头
 */
@property(strong,nonatomic)XKCheckResultView *checkHeader;


/**
 血氧结果页区头
 */
@property(strong,nonatomic)CheckHeaderResultView *checkHeaderResultView;


/**
 结果页区头
 */
@property(strong,nonatomic)XKCheckHeaderCommonResultView *checkHeaderCommonResultView;

@property(strong,nonatomic)XKSingleCheckMultipleCommonResultHeadView *headHyperliView ;

/**
 
 */
@property(strong,nonatomic)XKSingleCheckMultipleCommonPresResultHeadView  *headPresureView;

/**
 区尾
 */
@property(strong,nonatomic)XKSingleCheckMultipleCommonResultFootView *botoomView;

/**
 收缩图
 */
@property(strong,nonatomic)XKSearchToolView *searchEquipView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@end

@implementation CheckResultViewController
-(XKSearchToolView *)searchEquipView
{
    if (!_searchEquipView) {
        _searchEquipView = [[NSBundle mainBundle]loadNibNamed:@"XKSearchToolView" owner:self options:nil].firstObject;
        _searchEquipView.x = 0;
        _searchEquipView.y = 0;
        _searchEquipView.width = KScreenWidth;
        _searchEquipView.height = KScreenHeight;
        _searchEquipView.delegate = self;
    }
    return _searchEquipView;
}
-(XKCheckResultSugarTopView *)SugarTopView
{
    if (!_SugarTopView) {
        _SugarTopView = [[[NSBundle mainBundle] loadNibNamed:@"XKCheckResultSugarTopView" owner:self options:nil] lastObject];
        _SugarTopView.frame = CGRectMake(0, leftBackBtn.frame.origin.y, KScreenWidth, KScreenHeight - leftBackBtn.frame.origin.y);
        _SugarTopView.clipsToBounds = YES;
        _SugarTopView.alpha = 0;
        _SugarTopView.delegate = self;
    }
    return _SugarTopView;
}
-(XKSingleCheckMultipleCommonPresResultHeadView *)headPresureView
{
    if (!_headPresureView) {
        _headPresureView = [[[NSBundle mainBundle]loadNibNamed:@"XKSingleCheckMultipleCommonPresResultHeadView" owner:self options:nil]firstObject];
        _headPresureView.delegate = self;
    }
    
    return _headPresureView;
}
-(XKSingleCheckMultipleCommonResultHeadView *)headHyperliView
{
    if (!_headHyperliView) {
        _headHyperliView = [[[NSBundle mainBundle]loadNibNamed:@"XKSingleCheckMultipleCommonResultHeadView" owner:self options:nil]firstObject];
        _headHyperliView.delegate = self;
    }
    
    return _headHyperliView;
}
-(CheckHeaderResultView *)checkHeaderResultView
{
    if (!_checkHeaderResultView) {
        _checkHeaderResultView = [[[NSBundle mainBundle]loadNibNamed:@"CheckHeaderResultView" owner:self options:nil]firstObject];
        _checkHeaderResultView.delegate = self;
    }
    return _checkHeaderResultView;
}
-(XKCheckHeaderCommonResultView *)checkHeaderCommonResultView
{
    if (!_checkHeaderCommonResultView) {
        _checkHeaderCommonResultView =  [[[NSBundle mainBundle]loadNibNamed:@"XKCheckHeaderCommonResultView" owner:self options:nil]firstObject];
        _checkHeaderCommonResultView.delegate = self;
    }
    return _checkHeaderCommonResultView;
    
}
-(XKCheckResultView *)checkHeader
{
    if (!_checkHeader) {
        _checkHeader = [[[NSBundle mainBundle]loadNibNamed:@"XKCheckResultView" owner:self options:nil]firstObject];
        _checkHeader.delegate = self;
    }
    
    return _checkHeader;
}
-(XKSingleCheckMultipleCommonResultFootView *)botoomView
{
    if (!_botoomView) {
        _botoomView = [[[NSBundle mainBundle]loadNibNamed:@"XKSingleCheckMultipleCommonResultFootView" owner:self options:nil]firstObject];
        //        _botoomView.delegate = self;
    }
    
    return _botoomView;
}
#pragma mark  视图加载 //一般来说如果该ViewController是测量界面，那么在该方法里面就调用扫描方法
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.jumpCountIndex = 1;
    self.PressjumpCountIndex = 1;
    [self backImageAction];
    self.topCons.constant = (PublicY);
    self.tab.estimatedSectionHeaderHeight = 250;
    self.tab.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tab.estimatedRowHeight = 77;
    self.tab.rowHeight = UITableViewAutomaticDimension;
    [self.tab registerNib:[UINib nibWithNibName:@"XKXKCheckResultWeightTableViewCell" bundle:nil] forCellReuseIdentifier:@"XKXKCheckResultWeightTableViewCell"];
    
    [self.tab registerNib:[UINib nibWithNibName:@"XKCheckResultWeightTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"XKCheckResultWeightTwoTableViewCell"];
    
    [self.tab registerNib:[UINib nibWithNibName:@"XKSingleCheckMultipleCommonResultCell" bundle:nil] forCellReuseIdentifier:@"XKSingleCheckMultipleCommonResultCell"];
    
    
    [self isManualOrDect];//手动还是自动检测
#ifdef __IPHONE_11_0
    if ([self.tab respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        self.tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
#endif
    
}

-(void)loadSearchView
{
    
    self.searchEquipView.alpha = 0.0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.searchEquipView];
    self.searchEquipView.alpha = 1.0;
    if (self.DectStyle<=5) {
        NSInteger CRCreativeSDK  = [[NSUserDefaults standardUserDefaults] integerForKey:@"CRCreativeSDKF"];
        
        if (CRCreativeSDK == 2) {
            self.searchEquipView.alpha = 0.0;
            [self.bc beginAutoTest];
        }
        self.searchEquipView.style = 2;
        
    }
    else
        self.searchEquipView.style = 5;
    
    
}

-(void)isManualOrDect{
    self.recAiAoleDataStr = @"";
    if (self.isOtherDect == YES) {
        
        [self loadData:nil];
        
    }else
    {
        
        [self.tab reloadData];
        
        
        
        if (self.DectStyle == XKDetectBloodSugarStyle||self.DectStyle == XKMutilPCBloodSugarStyle) {
            
            [self creatUI];
            centerNameLab.hidden = YES;
        }
        
        if (self.DectStyle<=5) {
            
            
            NSString *blueToothNameToolsN = nil;
            
            if (self.DectStyle == XKMutilPCBloodPressurStyle) {
                self.dectingNameImage = @"icon_pc300_bp_one";
                blueToothNameToolsN = @"pressure";
            }
            if (self.DectStyle == XKMutilPCBloodSugarStyle) {
                self.dectingNameImage = @"icon_pc300_GLU";
            }
            if (self.DectStyle == XKMutilPCTemperatureStyle) {
                self.dectingNameImage = @"icon_pc300_heat";
            }
            if (self.DectStyle == XKMutilPCBloodOxygenStyle) {
                self.dectingNameImage = @"icon_pc300_oxygen";
            }
            if (self.DectStyle == XKMutilPCNormalStyle) {
                self.dectingNameImage = @"icon_pulse rate";
                blueToothNameToolsN = @"blueRate";
            }
            self.bc=[BluetoothConnectionTool sharedInstanceTool];
            
            
            self.bc.delegate = self;
            //            self.bc.conntiontTool = 2;
            self.bc.adVpersincalName = blueToothNameToolsN;
            
        }
        //        else//单项设备添加   连接设备      PC300多项添加搜索连接设备
        //        {
        //
        //
        //
        //        }
        if (!(self.DectStyle == 2||self.DectStyle == 8)) {
            [self loadSearchView];
        }
        if (self.DectStyle == XKDetectWeightStyle) {
            
            
            _allScanDevice = [NSMutableArray array];
            _deviceData = [NSMutableArray array];
            qinNiuTag = 1;
            [self scanBle:qinNiuTag];
            
            _qingNiuWeightUnit = QingNiuRegisterWeightUnitKg;
            //设置测量单位
            [QingNiuSDK setWeightUnit:_qingNiuWeightUnit];
            
            [QingNiuSDK getCurrentWeightUnit:^(QingNiuWeightUnit qingNiuWeightUnit) {
                _qingNiuWeightUnit = qingNiuWeightUnit;
                
            }];
            
            
        }
        
        
        if ([self.BluetoothName isEqualToString:@"HTD02"]||[self.BluetoothName isEqualToString:@"HC-08"]||[self.BluetoothName containsString:@"CardioChek"])
        {////血脂
            //卡迪拉克血脂
            self.toothM = [MSBluetoothManager shareInstance];
            self.toothM.adVpersincalName = self.BluetoothName;
            self.toothM.conntiontTool = YES;
            
            self.toothM.delegate = self;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.toothM startScan];
            });
            
            if ([self.BluetoothName isEqualToString:@"HTD02"]) {
                self.dectingNameImage = @"icon_heat_two";
            }
            if ([self.BluetoothName isEqualToString:@"HC-08"]) {
                self.dectingNameImage = @"icon_heat_one";
            }
            if ([self.BluetoothName containsString:@"CardioChek"]) {
                self.dectingNameImage = @"icon_bloodfat_two";
            }
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleStartconnected:)
                                                         name:kNotificationConnected
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleStartconnectedFail:)
                                                         name:kNotificationconnectedFail
                                                       object:nil];
            
            
        }
        else if ([self.BluetoothName isEqualToString:@"iGate"])
        {
            
            // 艾康血脂
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            Boolean useCustomerUUID128 = [defaults boolForKey:@"switchUseUUID128"];
            NSString *serviceUUIDStr=@"1812";
            serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
            if(useCustomerUUID128)
            {
                serviceUUIDStr=[defaults stringForKey:@"customerUuid128"];
                if(serviceUUIDStr==nil)
                    serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
                else
                {
                    CFUUIDRef tmpUUID0=CFUUIDCreateFromString(kCFAllocatorDefault, (__bridge CFStringRef)serviceUUIDStr);
                    CFStringRef aCFString=CFUUIDCreateString(kCFAllocatorDefault,tmpUUID0);
                    if(kCFCompareEqualTo!=CFStringCompare(aCFString,(__bridge CFStringRef)serviceUUIDStr,0))
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:serviceUUIDStr message:@"The UUID128 in settings is not correct, default C14D2C0A-401F-B7A9-841F-E2E93B80F631 is used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        [alert show];
                        serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
                    }
                    CFRelease(tmpUUID0);
                    CFRelease(aCFString);
                }
            }
            
            iGate = [[CiGate alloc] initWithDelegate:self autoConnectFlag:TRUE serviceUuidStr:serviceUUIDStr];
            self.recDataStr=@"";
            _rxFormat=0;
            if ([self.BluetoothName isEqualToString:@"iGate"]) {
                self.dectingNameImage = @"icon_bloodfat_one";
            }
            
            
        } else if ([self.BluetoothName hasPrefix:@"RBP"]||[self.BluetoothName hasPrefix:@"BP"]){//脉搏波血压  [temp hasPrefix:@"RBP"] || [temp hasPrefix:@"BP"] RBP1708040566
            
            //开始测量成功
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleStartMeasureUsingRGKTSphygmomanometerSucceed:)
                                                         name:StartMeasureUsingRGKTSphygmomanometerSucceed
                                                       object:nil];
            //开始测量失败
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleStartMeasureUsingRGKTSphygmomanometerFailed:)
                                                         name:StartMeasureUsingRGKTSphygmomanometerFailed
                                                       object:nil];
            
            
            //接收到测量结果
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleReceivedRGKTSphygmomanometerMeasureResult:)
                                                         name:ReceivedRGKTSphygmomanometerMeasureResult
                                                       object:nil];
            
            //收到实时测量数据
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleReceivedRGKTSphygmomanometerMeasureData:)
                                                         name:ReceivedRGKTSphygmomanometerMeasureData
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(handleBluetoothDidPowerLow:)
                                                         name:BluetoothDidPowerLow
                                                       object:nil];
            
            
            maibobo = [LanYaSDK shareInstance];
            maibobo.isConnectedEquipt = 2;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [maibobo startScan];
                
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [maibobo connectToRGKTSphygmomanometer];
            });
            
            
            
            
            
            
            self.dectingNameImage = @"icon_bp_one";
            
            
            
            
        }
        
        else if ([self.BluetoothName isEqualToString:@"Bioland-BGM"]) {
            
            
            self.dectingNameImage = @"icon_glu_two";
            
            
            
            
        } // [self createData];//爱奥乐
        else if ([self.BluetoothName isEqualToString:@"Bioland-BPM"]) {
            [self createData];//爱奥乐
            self.dectingNameImage = @"icon_bp_one";
            
            
        }
        else if ([self.BluetoothName isEqualToString:@"POD"]) {
            
            
            self.bc=[BluetoothConnectionTool sharedInstanceTool];
            
            self.bc.adVpersincalName = @"POD";
            
            self.bc.delegate = self;
            
            self.connectionStatus = 1;
            self.bc.conntiontTool = 3;
            [self.bc scanDevice];
            
            self.dectingNameImage = @"icon_bloodoxygenResult";
            
        }
        
        [self.headHyperliView startAnimation];
        
        [self.headPresureView startAnimation];
        
        [self.checkHeaderResultView TouchCircleAndHide];
        [self.checkHeaderCommonResultView TouchCircleAndHide];
        [self.checkHeader TouchCircleAndHide];
        
        
        self.headHyperliView.OnceAgainBtn.hidden = YES;
        
        self.headPresureView.againBtn.hidden = YES;
        
        
        self.checkHeaderResultView.againBtn.hidden = YES;
        
        self.checkHeaderCommonResultView.againBtn.hidden = YES;
        
        self.checkHeader.againBtn.hidden = YES;
    }
    
    self.botoomView.bottomDectImage.image = [UIImage imageNamed:self.dectingNameImage];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    [self.SugarTopView closeAllView];
    
    
    self.checkHeaderResultView = nil;
    self.jumpCountIndex = 1;
    self.PressjumpCountIndex = 1;
    [_timer invalidate];
    _timer = nil;
    
    if (self.DectStyle == XKDetectWeightStyle)
    {
        
        
        if (_allScanDevice.count>0) {
            [QingNiuSDK stopBleScan];
            QingNiuDevice *qingNiuDevice = _allScanDevice[0];
            [QingNiuSDK cancelConnect:qingNiuDevice disconnectFailBlock:^(QingNiuDeviceDisconnectState qingNiuDeviceDisconnectState) {
                NSLog(@"青牛体脂秤取消链接失败");
            } disconnectSuccessBlock:^(QingNiuDeviceDisconnectState qingNiuDeviceDisconnectState) {
                NSLog(@"青牛体脂秤取消链接成功");
            }];
        }
        
    }
    
    if ([self.BluetoothName containsString:@"Bioland-B"]) {
        if (BLEManagerAiAoleTimer) {
            [BLEManagerAiAoleTimer invalidate];
            BLEManagerAiAoleTimer = nil;
        }
        
        
    }
    else if ([self.BluetoothName hasPrefix:@"RBP"]||[self.BluetoothName hasPrefix:@"BP"])
//        if ([self.BluetoothName isEqualToString:@"RBP1708040566"])
    {
        
        NSLog(@"--------maibobo断开连接");
        [maibobo stopScan];//停止扫描就开始断开链接
        //        [maibobo disconnectDevice:];
        
    }
    else if ([self.BluetoothName isEqualToString:@"iGate"])
    {
        
        [iGate stopSearch];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        Boolean useCustomerUUID128 = [defaults boolForKey:@"switchUseUUID128"];
        NSString *serviceUUIDStr=@"1812";
        serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
        if(useCustomerUUID128)
        {
            serviceUUIDStr=[defaults stringForKey:@"customerUuid128"];
            if(serviceUUIDStr==nil)
                serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
            else
            {
                CFUUIDRef tmpUUID0=CFUUIDCreateFromString(kCFAllocatorDefault, (__bridge CFStringRef)serviceUUIDStr);
                CFStringRef aCFString=CFUUIDCreateString(kCFAllocatorDefault,tmpUUID0);
                if(kCFCompareEqualTo!=CFStringCompare(aCFString,(__bridge CFStringRef)serviceUUIDStr,0))
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:serviceUUIDStr message:@"The UUID128 in settings is not correct, default C14D2C0A-401F-B7A9-841F-E2E93B80F631 is used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];
                    serviceUUIDStr=@"C14D2C0A-401F-B7A9-841F-E2E93B80F631";
                }
                [iGate disconnectDevice:tmpUUID0];
                CFRelease(tmpUUID0);
                CFRelease(aCFString);
            }
        }
        
    }
    else  if ([self.BluetoothName isEqualToString:@"HTD02"]||[self.BluetoothName isEqualToString:@"HC-08"]||[self.BluetoothName containsString:@"CardioChek"])
    {
        
        [self.toothM stopScan];
        [self.toothM cancelConnect];
        
        
    }else  if ([self.BluetoothName containsString:@"POD"])
    {
        
        
        // [self.bc PoddisconnectDevice];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    
    
}
#pragma mark   爱奥乐
/**停止搜索*/
- (void)stopScan {
    [_bleManager manualStopScanDevice];
    
}
- (void)centerManagerStateChange:(CBManagerState)state;
{
    
    NSLog(@"_________******************____");
    //    if (state == 5) {
    [_bleManager scanDeviceTime:10];
    //    }
    
}
/**搜索设备*/
- (void)scan {
    NSLog(@"-扫描一次");
    //     [self performSelector:@selector(settingScanButton) withObject:nil afterDelay:10.0f];
    [_bleManager scanDeviceTime:10];
}

- (void)createData {
    _bleManager = [BLEManager defaultManager];
    _bleManager.isEncryption = NO;
    _bleManager.delegate = self;
    _deviceArray = [[NSMutableArray alloc] init];
    //     [self performSelector:@selector(scan) withObject:nil afterDelay:5.f];
    BLEManagerAiAoleTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scan) userInfo:nil repeats:YES];
    
}

- (void)clickSendData:(CBPeripheral *)peripheral {
    _bleManager.isEncryption = NO;
    NSString* string = @"";
    if ([self.BluetoothName isEqualToString:@"Bioland-BGM"]) {
        string = @"5A0A031005020F213BEB";
    }
    else if ([self.BluetoothName isEqualToString:@"Bioland-BPM"])
    {
        string = @"5A0A011005020F213BE9";
        
    }
    //@"5A0A031005020F213BEB";//_dataTextField.text;5A0A011005020F213BE9  5A0A031005020F213BEB血糖
    if (string.length == 0) {
        return;
    }
    if (string.length % 2 != 0 ) {
        string = [NSString stringWithFormat:@"%@0",string];
    }
    
    [_bleManager sendDataToDevice1:string device:peripheral];
    
    
    
}

#pragma mark - BLeManager Delegate爱奥乐设备
- (void)scanDeviceRefrash:(NSMutableArray *)array {
    NSLog(@"--------array%@",array);
    [_deviceArray removeAllObjects];
    BOOL connectStaus = NO;
    for (TTCDeviceInfo* info in array) {
        
        
        //得到想要连接的设备
        if ([info.localName containsString:self.BluetoothName]) {//BLE#0x44A6E5077A74
            
            [BLEManagerAiAoleTimer invalidate];
            BLEManagerAiAoleTimer = nil;
            connectStaus = YES;
            //停止扫描
            [_bleManager manualStopScanDevice];
            //开始连接
            [_bleManager startAutoConnect:@[info.cb]];
        }
        
    }
    
}

- (void)connectDeviceSuccess:(CBPeripheral *)device error:(NSError *)error {
    
    self.searchEquipView.style = 4;
    //连接成功后,停止自动连接,然后可以进行数据交互
    [_bleManager stopAutoConnect];
    //发送数据的时候最好有一个延迟,下面是发送数据的例子,因为如果刚连接上马上发数据,可能有底层模块收不到数据的问题
    [self performSelector:@selector(clickSendData:) withObject:device afterDelay:0.2f];
    
    
}

- (void)didDisconnectDevice:(CBPeripheral *)device error:(NSError *)error {
    NSLog(@"----------断开连接-----");
    
    
}

- (void)receiveDeviceDataSuccess_1:(NSData *)data device:(CBPeripheral *)device {
    //    NSLog(@"receiveDeviceDataSuccess_1:%@",data);/*receiveDeviceDataSuccess_1:<550c0311 091c0a35 00680041>*/
    Byte* byte = (Byte*)[data bytes];
    NSString* string = @"";
    for (int i = 0; i < data.length; i++) {
        NSString* string1 = [NSString stringWithFormat:@"%X",byte[i]];
        if (string1.length == 1) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"0%@",string1]];
        } else {
            string = [string stringByAppendingString:string1];
        }
        
        
    }
    
    
    
    if ([self.BluetoothName isEqualToString:@"Bioland-BPM"]){
        if (string.length<20) {
            
            self.recAiAoleDataStr=[self.recAiAoleDataStr stringByAppendingFormat:@"%@",string];
            
            NSLog(@"***********-------%@-", self.recAiAoleDataStr);
            if ([self.recAiAoleDataStr containsString:@"550802"]) {
                NSString *hahah = self.recAiAoleDataStr;
                
                hahah = [hahah stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSArray * arr11 = [hahah componentsSeparatedByString:@"550802"];
                
                
                NSMutableArray *result_arr = [NSMutableArray array];
                NSString *tempDta =  arr11[arr11.count-1];
                if (tempDta.length < 10) {//10-->取的是低13位开始+4长度
                    //            continue;
                }else
                {
                    
                    NSLog(@"\n\n\n=============================*******%@\n\n\n",tempDta);
                    
                    //            NSData* xmlData = [tempDta dataUsingEncoding:NSUTF8StringEncoding];
                    //             NSLog(@"\n\n\n========================xmlData=====*******%@\n\n\n",xmlData);
                    //            char *pData = (char *)[xmlData bytes];
                    //            int packageStart = (*pData++ + 256) % 256;
                    //            int responseStart = (*pData++ + 256) % 256;
                    //            NSLog(@"\n\n\n============%d==5555555=====%d==========\n\n\n",packageStart,responseStart);
                    //            NSMutableString* hexString = [NSMutableString string];
                    //             Byte* byte1 = (Byte*)[xmlData bytes];
                    //            unsigned char *cdata = (unsigned char*)byte1;
                    //            int length = *pData++;
                    //            for (int i=0; i < length; i++)
                    //            {
                    //                [hexString appendFormat:@"%02x", *cdata++];
                    //            }
                    //            NSLog(@"\n\n\n============================hexString=%@\n\n\n",hexString);
                    NSString * strA = [tempDta substringWithRange:NSMakeRange(4, 2)];
                    NSString * strB = [tempDta substringWithRange:NSMakeRange(6, 2)];
                    NSLog(@"\n\n\n============%@=======%@==========\n\n\n",strA,strB);
                    unsigned long valueA = strtoul([strA UTF8String],0,16);
                    unsigned long valueB = strtoul([strB UTF8String],0,16);
                    
                    int a =((int)(valueB&0xff))*256 +((int)(valueA&0xff));
                    int b = ((int)(valueA&0xff));
                    int c = ((int)(valueA&0xff))+256;
                    [self.headPresureView.activiTwo stopAnimating];
                    [self.headPresureView.activiTwo setHidesWhenStopped:YES];
                    if (a>=0) {
                        [self.headPresureView.dataTwoBtn setTitle:[NSString stringWithFormat:@"%d",b]  forState:UIControlStateNormal];
                        
                    }else
                    {
                        
                        //                        NSString *temp =  [[self numberHexString:[tempDta substringWithRange:NSMakeRange(8, 2)]] stringValue];
                        
                        [self.headPresureView.dataTwoBtn setTitle:[NSString stringWithFormat:@"%d",c]  forState:UIControlStateNormal];
                        
                    }
                    
                    
                    
                }
                
                
            }
            
        }
        
    }
    
    
    // receiveDeviceDataSuccess_1:<550e0311 0a1e0e15 0190006c 4b0c>
    
    if (string.length>20) {
        if ([self.BluetoothName isEqualToString:@"Bioland-BGM"]) {
            NSString *tempData = [string substringWithRange:NSMakeRange(16, 4)];
            NSNumber *a1 =  [self numberHexString:tempData];
            //            NSLog(@"asd:%@---%lf",tempData,[a1 doubleValue]/18.0);
            self.manualText = [NSString stringWithFormat:@"%.1lf",[a1 doubleValue]/18.0];
            
            if (self.BloodSugarType == 0) {
                self.BloodSugarType = 1;
            }
            [_bleManager sendDataToDevice1:@"5A0A031005020F213BEB" device:device];
            
        }
        else if ([self.BluetoothName isEqualToString:@"Bioland-BPM"])//015d
        {
            
            NSString *tempData = [string substringWithRange:NSMakeRange(18, 2)];
            NSNumber *a =  [self numberHexString:tempData];
            
            
            NSString *tempTwoData = [string substringWithRange:NSMakeRange(20, 4)];
            NSNumber *b =  [self numberHexString:tempTwoData];
            
            
            NSString *tempThreeData = [string substringWithRange:NSMakeRange(24, 2)];
            NSNumber *c =  [self numberHexString:tempThreeData];
            
            //            NSLog(@"asd:%@---%d-----%d---%d",tempData,a ,b,c);
            self.manualText = [NSString stringWithFormat:@"%@",a];
            
            self.manualTwoText = [NSString stringWithFormat:@"%@",b];
            
            self.manualThreeText = [NSString stringWithFormat:@"%i",[c intValue]];
            
            
            [_bleManager performSelector:@selector(disconnectDevice:) withObject:device afterDelay:0.1f];
        }
        
        if (![NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"XKCheckResultCommonViewController"]) {
            
            
            
            [self loadData:nil];
        }
        
        
    }
    
    
    
}
-(void)receiveDeviceDataSuccess_3:(NSData *)data device:(CBPeripheral *)device;
{
    
    NSLog(@"receiveDeviceDataSuccess_3:%@",data);
    
    
    
    
}
// 16进制转10进制
- (NSNumber *)numberHexString:(NSString *)aHexString
{
    // 为空,直接返回.
    if (nil == aHexString)
    {
        return nil;
    }
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    return hexNumber;
    
}
#pragma mark   青牛体秤
- (void)receiewBleData:(NSMutableDictionary *)deviceData andState:(QingNiuDeviceConnectState)qingNiuDeviceConnectState{
    if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateConnectedSuccess) {
        [self scanBle:2];
        
        self.searchEquipView.style = 4;
        NSLog(@"连接成功%@",deviceData);
    }
    else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateIsWeighting) {
        NSLog(@"实时体重：%@",deviceData[@"weight"]);
        self.checkHeader.weightLab.text = [NSString stringWithFormat:@"%@",deviceData[@"weight"]];
        
        self.checkHeader.weightKgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"weight"] ];
        self.checkHeader.BMIKgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"bmi"] ];
        self.checkHeader.BMILab.text = [NSString stringWithFormat:@"BMI：%@",deviceData[@"bmi"]];
        self.checkHeader.sLvLab.text = [NSString stringWithFormat:@"脂肪率：%@",deviceData[@"bodyfat"] ];
    }else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateWeightOver){
        NSLog(@"测量完毕：%@",deviceData);
        NSString *fat_free_weight = deviceData[@"fat_free_weight"];
        
        NSString *score = deviceData[@"score"];
        Dateformat *dat = [[Dateformat alloc]init];
        ;
        self.checkHeader.weightLab.text = [NSString stringWithFormat:@"%@",deviceData[@"weight"]];
        
        self.checkHeader.weightKgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"weight"] ];
        self.checkHeader.BMIKgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"bmi"] ];
        self.checkHeader.BMILab.text = [NSString stringWithFormat:@"BMI：%@",deviceData[@"bmi"]];
        self.checkHeader.sLvLab.text = [NSString stringWithFormat:@"脂肪率：%@",deviceData[@"bodyfat"] ];
        
        self.checkHeader.slvkgLab.text = [NSString stringWithFormat:@"%@",deviceData[@"bodyfat"] ];
        
        self.checkHeader.fatLabOne.text= deviceData[@"visfat"] == [NSNull null]?@"0":deviceData[@"visfat"];
        self.checkHeader.fatLabTwo.text= [deviceData[@"water"] isEqual:[NSNull null]]?@"0":deviceData[@"water"];
        self.checkHeader.fatLabThree.text= [deviceData[@"sinew"] isEqual:[NSNull null]]?@"0":deviceData[@"sinew"];
        self.checkHeader.fatLabFour.text= [deviceData[@"subfat"] isEqual:[NSNull null]]?@"0":deviceData[@"subfat"];
        
        self.checkHeader.fatLabFive.text= [fat_free_weight length]<=0?@"0":deviceData[@"fat_free_weight"];
        self.checkHeader.fatLabSix.text= [deviceData[@"muscle"] isEqual:[NSNull null]]?@"--":deviceData[@"muscle"];
        self.checkHeader.fatLabSeven.text= [deviceData[@"bone"] isEqual:[NSNull null]]?@"--":deviceData[@"bone"];
        self.checkHeader.fatLabEight.text= [deviceData[@"protein"] isEqual:[NSNull null]]?@"--":deviceData[@"protein"];
        self.checkHeader.fatLabNine.text= [deviceData[@"bmr"] isEqual:[NSNull null]]?@"--":deviceData[@"bmr"];
        self.checkHeader.fatLabTen.text= [deviceData[@"bodyage"] isEqual:[NSNull null]]?@"--":deviceData[@"bodyage"];
        self.checkHeader.fatLabTwel.text= [score length]<=0?@"0":deviceData[@"score"];
        self.checkHeader.fatLabElev.text= deviceData[@"body_shape"] ==[NSNull null]?@"--":deviceData[@"body_shape"];
        
        self.manualText = self.checkHeader.weightLab.text;
        
        NSString *dateString = [dat AlltimeConvertSp:[NSString stringWithFormat:@"%@",deviceData[@"measure_time"]]];
        NSLog(@"dateString::::%@:::%@",deviceData[@"measure_time"],dateString);
        
        UserInfoModel *model = [UserInfoTool getLoginInfo];
        
        NSDictionary *t = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.checkHeader.fatLabOne.text,
                           @"FatLevel",
                           self.checkHeader.BMIKgLab.text,
                           @"BMI",
                           self.checkHeader.slvkgLab.text,
                           @"FatRate",
                           self.checkHeader.fatLabTwo.text,
                           @"WaterMass",
                           self.checkHeader.fatLabThree.text,
                           @"MuscleMass",@(model.Height),
                           @"Hight", self.checkHeader.weightLab.text,
                           @"Weight",self.checkHeader.fatLabFour.text,
                           @"SubcutaneousFatRate",
                           self.checkHeader.fatLabSix.text,
                           @"SkeletalMuscleRate",
                           self.checkHeader.fatLabFive.text,
                           @"LeanWeight",
                           self.checkHeader.fatLabEight.text,
                           @"Proteins",
                           self.checkHeader.fatLabNine.text,
                           @"Metabolism",
                           self.checkHeader.fatLabSeven.text,
                           @"BoneMass",
                           [dat timeConvertSp:deviceData[@"measure_time"]],
                           @"TestTime",
                           self.checkHeader.fatLabTwel.text,
                           @"Score",
                           self.checkHeader.fatLabElev.text,
                           @"BodyType",
                           self.checkHeader.fatLabTen.text,
                           @"BodyAge",nil];
        
        
        [self loadData:t];
        /*eHealthCare[8921:2276712] 测量完毕：{（FatLevel：内脏脂肪等级，BMI：脂肪率，FatRate：体脂肪率，WaterMass：身体水分量，MuscleMass：肌肉质量，Hight：身高，Weight：体重，SubcutaneousFatRate：收下脂肪率，SkeletalMuscleRate：骨骼肌率，LeanWeight：去脂体重，Proteins：蛋白质，Metabolism：基础代谢，BoneMass：骨量，TestTime:检测时间，
         Score：身体评分，BodyType：身体类型，
         eHealthCare[3666:823973] 测量完毕：{
         visfat : 3,
         sinew : 32.8,
         weight : 46.70,
         user_id : 不,
         weight_unit : kg,
         resistance_second : ,
         score : ,
         resistance : ,
         measure_time : 2017-11-08 15:15:08,
         protein : 17.7,
         bmi : 19.9,
         fat_free_weight : ,
         bmr : 1124.0,
         subfat : 23.9,
         muscle : 43.6,
         bone : 2.1,
         bodyage : 21,
         water : 51.3,
         bodyfat : 25.3,
         body_shape : 4
         }
         
         }*/
        
    }else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateIsGettingSavedData){
        NSLog(@"正在获取存储数据：%@",deviceData);
    }else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateGetSavedDataOver){
        
        NSLog(@"存储数据接收完毕：%@",deviceData);
    }else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateDisConnected) {
        /*
         1、如果用户需要连续测量，那么就在这里开启一个定时器启动扫描，该方法是在轻牛app里面采用的方式
         [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scanBleAgain) userInfo:nil repeats:NO];
         2、如果确保qingNiuDevice对象没有改变，那么可以直接调用connectDevice:方法
         */
        NSLog(@"自动断开连接%@",deviceData);
        
        
    }
    if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateIsWeighting || qingNiuDeviceConnectState == QingNiuDeviceConnectStateWeightOver || qingNiuDeviceConnectState == QingNiuDeviceConnectStateIsGettingSavedData) {
        
        [_timer invalidate];
        _timer = nil;
        
        //        [self getShowDeviceData:deviceData];
        _scanFlag = NO;
        [self.tab reloadData];
    }
}


- (void)scanDevice:(QingNiuDevice *)qingNiuDevice{
    if (qingNiuDevice.deviceState == QingNiuDeviceStatePoweredOff) {
        NSLog(@"关机");
        
        
        
    }else {
        NSLog(@"开机");
    }
    NSLog(@"%@",qingNiuDevice);
    if (_allScanDevice.count == 0) {
        [_allScanDevice addObject:qingNiuDevice];
    }else {
        for (int i = 0; i<_allScanDevice.count; i++) {
            QingNiuDevice *savedDevice = _allScanDevice[i];
            if ([savedDevice.macAddress isEqualToString:qingNiuDevice.macAddress]) {
                
                
                
                break;
            }else if (i == _allScanDevice.count - 1){
                [_allScanDevice addObject:qingNiuDevice];
                break;
            }
        }
    }
    _scanFlag = YES;
    
    [self getAllQiuNiuData];
    [self.tab reloadData];
}

- (NSString *)getBodyShapeDescriptionWithBodyShape:(NSString *)bodyShape
{
    NSString *bodyShapeDescription = @"";
    
    self.checkHeader.scoreLab.textColor = [UIColor whiteColor];
    
    if ([bodyShape intValue] == 1) {
        bodyShapeDescription = @"隐形肥胖型";
        self.checkHeader.scoreLab.textColor = [UIColor colorWithHexString:@"FF7342"];
    }else if ([bodyShape intValue] == 2) {
        bodyShapeDescription = @"运动不足型";
        self.checkHeader.scoreLab.textColor = [UIColor colorWithHexString:@"FF7342"];
    }else if ([bodyShape intValue] == 3) {
        bodyShapeDescription = @"偏瘦型";
        self.checkHeader.scoreLab.textColor = [UIColor colorWithHexString:@"F3C331"];
    }else if ([bodyShape intValue] == 4) {
        bodyShapeDescription = @"标准型";
    }else if ([bodyShape intValue] == 5) {
        bodyShapeDescription = @"偏瘦肌肉型";
    }else if ([bodyShape intValue] == 6) {
        bodyShapeDescription = @"肥胖型";
        self.checkHeader.scoreLab.textColor = [UIColor colorWithHexString:@"FF7342"];
    }else if ([bodyShape intValue] == 7) {
        bodyShapeDescription = @"偏胖型";
        self.checkHeader.scoreLab.textColor = [UIColor colorWithHexString:@"FF7342"];
    }else if ([bodyShape intValue] == 8) {
        bodyShapeDescription = @"标准肌肉型";
    }else if ([bodyShape intValue] == 9) {
        bodyShapeDescription = @"非常肌肉型";
    }
    /*你的体重*/
    // self.checkHeader.scoreLab.text = [NSString stringWithFormat:@"%@",bodyShapeDescription];
    
    
    
    return bodyShapeDescription;
}

#pragma mark 再次扫描秤
- (void)scanBleAgain
{
    [self scanBle:qinNiuTag];
}
#pragma mark 扫描
- (void)scanBle:(NSInteger )tag
{
    
    // self.searchEquipView.style = 4;
    
    if (tag == 1) {
        
        qinNiuTag = 2;
        [_allScanDevice removeAllObjects];
        
        __weak CheckResultViewController *weekSelf = self;
        [QingNiuSDK startBleScan:nil scanSuccessBlock:^(QingNiuDevice *qingNiuDevice) {
            [weekSelf scanDevice:qingNiuDevice];
        } scanFailBlock:^(QingNiuScanDeviceFail qingNiuScanDeviceFail) {
            NSLog(@"121212%ld",(long)qingNiuScanDeviceFail);
            if (qingNiuScanDeviceFail == QingNiuScanDeviceFailValidationFailure) {
                
                [QingNiuSDK registerApp:@"szxkwlkjyxgs2017061521" registerAppBlock:^(QingNiuRegisterAppState qingNiuRegisterAppState) {
                    NSLog(@"%ld",(long)qingNiuRegisterAppState);
                }];
                
                //                [QingNiuSDK registerApp:@"szxkwlkjyxgs2017061521" andReleaseModeFlag:true registerAppBlock:^(QingNiuRegisterAppState qingNiuRegisterAppState) {
                //                    NSLog(@"%ld",(long)qingNiuRegisterAppState);
                //                }];
            }
        }];
    }else {//申明：在实际开发过程当中，如果扫描到设备就连接的话，停止扫描方法可不调用，因为连接方法会停止扫描
        qinNiuTag = 1;
        [QingNiuSDK stopBleScan];
        [_allScanDevice removeAllObjects];
        
        
    }
}
#pragma mark 切换用户登录的时候，请调用该方法清除缓存(在轻牛app里面是不需要调用该方法的，因为切换用户会清楚所有数据)
- (void)clearCache
{
    [QingNiuSDK clearCache];
}



/*
 轻牛app不调用该方法，直接等自动断开，除非工程中有中断连接的需求才调用该方法
 */
#pragma mark 断开连接
- (void)disconnect
{
    //_qingNiuDevice：连接的设备
    //    [QingNiuSDK cancelConnect:_qingNiuDevice disconnectFailBlock:^(QingNiuDeviceDisconnectState qingNiuDeviceDisconnectState) {
    //        NSLog(@"%ld",(long)qingNiuDeviceDisconnectState);
    //    } disconnectSuccessBlock:^(QingNiuDeviceDisconnectState qingNiuDeviceDisconnectState) {
    //        NSLog(@"%ld",(long)qingNiuDeviceDisconnectState);
    //    }];
}

#pragma mark - 以下两个方法是某个别公司的特殊要求，可不理会
#pragma mark 快速连接
- (void)simpleGetData
{
    QingNiuUser *user = [[QingNiuUser alloc] initUserWithUserId:@"pyf" andHeight:176 andGender:1 andBirthday:@"1992-01-10"];
    
    //    [QingNiuSDK simpleGetData:user scanFailBlock:^(QingNiuScanDeviceFail qingNiuScanDeviceFail) {
    //        NSLog(@"%ld",(long)qingNiuScanDeviceFail);
    //    } connectSuccessBlock:^(NSMutableDictionary *deviceData, QingNiuDeviceConnectState qingNiuDeviceConnectState) {
    //        if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateIsWeighting) {
    //            NSLog(@"实时体重：%@",deviceData[@"weight"]);
    //        }else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateWeightOver){
    //            NSLog(@"完成：%@",deviceData);
    //        }
    //    } connectFailBlock:^(QingNiuDeviceConnectState qingNiuDeviceConnectState) {
    //        NSLog(@"%ld",(long)qingNiuDeviceConnectState);
    //    }];
    
    
    [QingNiuSDK simpleGetData:user scanFailBlock:^(QingNiuScanDeviceFail qingNiuScanDeviceFail) {
        NSLog(@"%ld",(long)qingNiuScanDeviceFail);
    } onLowPowerBlock:^{
        
    } connectSuccessBlock:^(NSMutableDictionary *deviceData, QingNiuDeviceConnectState qingNiuDeviceConnectState) {
        if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateIsWeighting) {
            NSLog(@"实时体重：%@",deviceData[@"weight"]);
        }else if (qingNiuDeviceConnectState == QingNiuDeviceConnectStateWeightOver){
            NSLog(@"完成：%@",deviceData);
        }
        
    } connectFailBlock:^(QingNiuDeviceConnectState qingNiuDeviceConnectState) {
        NSLog(@"%ld",(long)qingNiuDeviceConnectState);
        
    }];
}


-(void)getAllQiuNiuData{
    
    
    if (_scanFlag) {
        QingNiuDevice *qingNiuDevice = _allScanDevice[0];
        if (qingNiuDevice.deviceState == QingNiuDeviceStatePoweredOff) {
            NSLog(@"秤处于关机状态");
            
        }
        //轻牛测试账号
        
        //  0nv  1男     SexID   SexID 0、男  1、女  -1、未知
        //        self.manualText = [UserInfoTool getLoginInfo].SexID == 1? [NSString stringWithFormat:@"%d",0]:[NSString stringWithFormat:@"%d",1];
        Dateformat *date = [[Dateformat alloc]init];
        
        UserInfoModel *model = [UserInfoTool getLoginInfo];
        //转成时间戳
        NSString *timeSp =  [date SptimeConvertDate:[UserInfoTool getLoginInfo].Birthday];
        NSLog(@"uuuuu= %@",timeSp);
        QingNiuUser *user = [[QingNiuUser alloc] init];
        user.userId = model.Mobile;
        user.height =  model.Height;//163;//
        user.gender = model.SexID== 1? 0:1;
        
        
        user.birthday = timeSp;//[UserInfoTool getLoginInfo].Birthday;
        __weak CheckResultViewController *weekSelf = self;
        
        
        [QingNiuSDK connectDevice:qingNiuDevice user:user onLowPowerBlock:^{
            
        } connectSuccessBlock:^(NSMutableDictionary *deviceData, QingNiuDeviceConnectState qingNiuDeviceConnectState) {
            NSLog(@"连接OK");
            self.searchEquipView.style = 4;
            [weekSelf receiewBleData:deviceData andState:qingNiuDeviceConnectState];
        } connectFailBlock:^(QingNiuDeviceConnectState qingNiuDeviceConnectState) {
            NSLog(@"连接失败----%ld",(long)qingNiuDeviceConnectState);
        }];
    }
    
    
    
}



#pragma mark    脉搏波血压
#pragma mark 搜索蓝牙设备 显示蓝牙名称
- (void)handleBluetoothDidRefreshDevicesList:(NSNotification *)notification
{
    //    [self.BlueTableView reloadData];
}
#pragma mark 连接蓝牙显示
//- (void)handleBluetoothDidConnectToDevice:(NSNotification *)notification
//{
//    CBPeripheral *connectedPeripheral = [maibobo connectedPeripheral];
//    NSLog(@"handleBluetoothDidConnectToDevice:%@",connectedPeripheral);
//    if (connectedPeripheral) {
//       [maibobo connectToRGKTSphygmomanometer];//连接
//    }
//
//
//
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [maibobo startMeasureUsingRGKTSphygmomanometer];
////    });
//}

#pragma mark   MSBluetooth
-(void)handleStartconnected:(NSNotification *)notification
{
    
    self.searchEquipView.style = 4;
    
}
-(void)handleStartconnectedFail:(NSNotification *)notification
{
    
    self.searchEquipView.style = 3;
    [self popViewController];
    
}

#pragma mark 自动测量 开始测量
#pragma mark 连接血压计失败
- (void)handleConnectToRGKTSphygmomanometerFailed:(NSNotification *)notification
{
    NSLog(@"连接血压计失败");
    [self popViewController];
}
#pragma mark 开始失败
- (void)handleStartMeasureUsingRGKTSphygmomanometerFailed:(NSNotification *)notification
{
    NSLog(@"开始失败");
    self.searchEquipView.style = 3;
    
}
#pragma mark 开始测量成功
- (void)handleStartMeasureUsingRGKTSphygmomanometerSucceed:(NSNotification *)notification
{
    self.searchEquipView.style = 4;
}

#pragma mark 蓝牙断开连接
- (void)handleBluetoothDidDisConnectToDevice:(NSNotification *)notification
{
    NSLog(@"蓝牙断开连接");
}
#pragma mark 收到实时测量数据
- (void)handleReceivedRGKTSphygmomanometerMeasureData:(NSNotification *)notification
{
    NSLog(@"handleReceivedRGKTSphygmomanometerMeasureData:%@", [notification.object description] );
    
    [self.headPresureView.activiTwo stopAnimating];
    [self.headPresureView.activiTwo setHidesWhenStopped:YES];
    [self.headPresureView.dataTwoBtn setTitle:[notification.object description]  forState:UIControlStateNormal];
    
}
-(void)handleBluetoothDidPowerLow:(NSNotification *)notification
{
    
    int  powerStr = [notification.object intValue];
    if (powerStr<3600) {
        ShowErrorStatus(@"电量过低,请先充电再使用该设备");
    }
    
    
    NSLog(@"电量过低请先充电使用----%@",notification.object);
    
    
    
}
#pragma mark 测量结果
- (void)handleReceivedRGKTSphygmomanometerMeasureResult:(NSNotification *)notification
{
    
    
    NSDictionary *tempDic =  notification.object;
    NSDictionary *dic = tempDic[@"object"];/*handleReceivedRGKTSphygmomanometerMeasureResult:{
                                            object =     {
                                            differencePressure = 29;
                                            heartAtriumShake = 0;
                                            heartRate = 81;
                                            heartRateIrregular = 0;
                                            highPressure = 94;
                                            isHealth = 0;
                                            lowPressure = 65;
                                            };
                                            type = 10;
                                            }*/
    
    NSLog(@"handleReceivedRGKTSphygmomanometerMeasureResult:%@",dic);
    [self.headPresureView.dataOneBtn setTitle:dic[@"highPressure"] forState:UIControlStateNormal];
    [self.headPresureView.dataTwoBtn setTitle:dic[@"lowPressure"] forState:UIControlStateNormal];
    [self.headPresureView.dataThreeBtn setTitle:dic[@"heartRate"] forState:UIControlStateNormal];
    
    self.manualText = dic[@"highPressure"];
    
    self.manualTwoText =dic[@"lowPressure"] ;
    self.manualThreeText = dic[@"heartRate"] ;
    
    [self loadData:nil];
    
    //    [maibobo stopMeasureUsingRGKTSphygmomanometer];
    
}

#pragma mark   艾康检测 CiGateDelegate methods
/*
 Invoked whenever the central manager's state is updated.
 */
- (void)iGateDidUpdateState:(CiGateState)iGateState
{
    [self setState:iGateState];
    NSString *state = @"";
    switch(iGateState)
    {
        case CiGateStateInit:
            state=@"Init";
            
            break;
        case CiGateStateIdle:
            state=@"Idle";
            
            break;
        case CiGateStatePoweredOff:
            state=@"Bluetooth power off";
            
            break;
        case CiGateStateUnknown:
            state=@"Bluetooth unknown";
            break;
        case CiGateStateUnsupported:
            state=@"BLE not supported";
            break;
        case CiGateStateSearching:
            state=@"Searching";
            
            
            break;
        case CiGateStateConnecting:
            if([iGate getConnectDevName])
                state=[@"Connecting " stringByAppendingString:[iGate getConnectDevName]];
            else
                state=@"Connecting iGate";
            
            break;
        case CiGateStateConnected:
            if([iGate getConnectDevName])
                state=[@"Connected " stringByAppendingString:[iGate getConnectDevName]];
            else
                state=@"Connected iGate";
            self.searchEquipView.style = 4;
            break;
        case CiGateStateBonded:
            
            self.searchEquipView.style = 4;
            if([iGate getConnectDevName])
                state=[@"Bonded " stringByAppendingString:[iGate getConnectDevName]];
            break;
    }
    NSLog(@"iGate %@, State %@",iGate,state);
}

- (void)iGateDidReceivedData:(NSData *)data
{
    /* need to delegate function */
    NSLog(@"input report received %@",data);
    NSData * updatedValue = data;
    //int aSize=[updatedValue length];
    uint8_t* dataPointer = (uint8_t*)[updatedValue bytes];
    NSString *empthyEndStr =  [NSString stringWithFormat:@"%s",dataPointer];
    NSLog(@"empthyEndStr：%@",empthyEndStr);
    switch (_rxFormat)
    {
        case 0:
            self.recDataStr=[self.recDataStr stringByAppendingFormat:@"%s",dataPointer];
            NSLog(@"iGate 艾康：%@",[self.recDataStr stringByAppendingFormat:@"%s",dataPointer]);
            
            /*2016-01-03(Y-M-D) 12:24
             
             ID: b01
             
             CHOL: 3.29mmol/L  0
             
             HDL: 0.75mmol/L  1
             
             TRIG: 0.78mmol/L   2
             
             CHOL/HDL:4.4  3
             
             LDL:2.20mmol/L   4  */
            break;
        case 1:
            //[self.rxDisplaySw setTitle:@"Display RX Hex" forState:UIControlStateNormal];
            for(integer_t aIndex=0;aIndex<[updatedValue length];aIndex++)
            {
                self.recDataStr=[self.recDataStr stringByAppendingFormat:@" %02X",dataPointer[aIndex]];
                NSLog(@"iGate 艾康：2 %@",[self.recDataStr stringByAppendingFormat:@" %02X",dataPointer[aIndex]]);
            }
            
            break;
        case 2:
            break;
    }
    _totalBytesRead+=[data length];
    //    NSString *recStrendStr = self.recDataStr
    
    //2.匹配字符串
    NSString *string = @"";
    NSRange range = [self.recDataStr rangeOfString:@"\r\n\r\n\r\n"];//匹配得到的下标
    
    if (range.length>0) {
        NSLog(@"rang:%@",NSStringFromRange(range));
        string = [self.recDataStr substringWithRange:range];//截取范围内的字符串
        NSLog(@"截取的值为：%@",string);
        //    }
        //    if ([empthyEndStr isEqualToString:@"\r\n\r\n\r\n"] ||[empthyEndStr isEqualToString:@"\n\r\n\r\n\r"]){//data.equals("0A0D0A0D0A")||hexstring.equals("0D0A0D0A0D0A") <0d0a0d0a 0d0a>  <0a0d0a0d 0a>
        NSLog(@"111%@",self.recDataStr);
        
        if ([self.recDataStr containsString:@"CHOL:"]) {//胆固醇
            
            
            NSArray *resultArr =  [self BreakCharacterWithString:self.recDataStr];
            
            self.manualText = resultArr[0];
            self.manualTwoText = resultArr[2];
            self.manualThreeText = resultArr[1];
            self.manualFourText = resultArr[4];
            
            [self loadData:nil];
        }
        
        
    }
    
    NSLog(@"_totalBytesRead:%@",[NSString stringWithFormat:@"RX: %d", _totalBytesRead]);
}
//截取字符串
-(NSArray *)BreakCharacterWithString:(NSString *)string{
    
    
    NSString *hahah = string;// @"VER:2.25\r\nCHOL:3.81mmol/L\r  \nASD:2.96\r\nPH:2.29mmol/L\r\nHLH:2.22mmol/L\r\nHLH:";
    hahah = [hahah stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray * arr11 = [hahah componentsSeparatedByString:@"\r"];
    
    
    NSMutableArray *result_arr = [NSMutableArray array];
    BOOL flag = false;
    for(NSString *str11  in  arr11){
        NSLog(@"aikang%@",str11);
        if ([str11 containsString:@"CHOL:"]) {
            flag = true;
        }
        if (!flag) {
            continue;
        }
        NSString *res_str = str11;
        NSLog(@"res_str%@",res_str);
        if ([str11 containsString:@"mmol/L"]) {
            res_str = [str11 stringByReplacingOccurrencesOfString:@"mmol/L" withString:@""];
        }
        res_str = [[res_str componentsSeparatedByString:@":"]lastObject];
        
        if ([res_str containsString:@">"]) {
            res_str = [res_str stringByReplacingOccurrencesOfString:@">" withString:@""];
        }
        if ([res_str containsString:@"<"]) {
            res_str = [res_str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        }
        [result_arr addObject:res_str];
        NSLog(@"res_str%@",res_str);
    }
    
    
    
    NSLog(@"resulitArr%@",result_arr);
    return result_arr;
    
    
}



- (void)iGateDidFoundDevice:(CFUUIDRef)devUUID name:(NSString *)devName RSSI:(NSNumber *)RSSI
{
    NSLog(@"found a iGate device: %@",devName);
    [iGate connectDevice:devUUID deviceName:devName];
}

- (void)iGateDidUpdateConnectDevRSSI:(NSNumber *)rssi error:(NSError *)error
{
    NSLog(@"rssi updated");
    if(error==nil)
    {
        NSLog(@"rssi updated %@",rssi);
        self.recDataStr=[self.recDataStr stringByAppendingFormat:@"%@",rssi];
        //        self.recData.text=self.recDataStr;
        //         NSLog(@"new rx %@",self.recDataStr);
    }
}

- (void)iGateDidRetrieveBatteryLevel:(UInt8)levelInPercentage
{
    NSLog(@"iGateDidRetrieveBatteryLevel %d",levelInPercentage);
    self.recDataStr=[self.recDataStr stringByAppendingFormat:@"\nBattery level is %d",levelInPercentage];
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSString *message = nil;
    switch (central.state) {
        case 1:{
            message = @"该设备不支持蓝牙功能,请检查系统设置";
            
            [self showAlertMessage:@"该设备不支持蓝牙功能,请检查系统设置"];
            
        }
            break;
        case 2:{
            message = @"该设备蓝牙未授权,请检查系统设置";
            
            [self showAlertMessage:@"该设备蓝牙未授权,请检查系统设置"];
        }
            break;
        case 3:{
            message = @"该设备蓝牙未授权,请检查系统设置";
            [self showAlertMessage:@"该设备蓝牙未授权,请检查系统设置"];
        }
            
            break;
        case 4:{
            message = @"该设备尚未打开蓝牙,请在设置中打开";
            [self showAlertMessage:@"该设备尚未打开蓝牙,请在设置中打开"];
        }
            break;
        case 5:{
            
            message = @"蓝牙已经成功开启,请稍后再试";
            
            
        }
            
            break;
        default:
            break;
    }
    if(message!=nil&&message.length!=0)
    {
        NSLog(@"message == %@",message);
    }
}

-(void)showAlertMessage:(NSString *)markMsg{
    
    UIAlertController *actionalert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:markMsg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acitonOne = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *acitonTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionalert addAction:acitonOne];
    
    [actionalert addAction:acitonTwo];
    
    [self presentViewController:actionalert animated:YES completion:nil];
    [self popViewController];
}

-(void)backImageAction{
    
    //    leftBackBtn = [XKBackButton backBtn:@"back"];
    //
    //    [self.view addSubview:leftBackBtn];
    //
    //
    //
    //    [leftBackBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    centerNameLab = [[UILabel alloc]init];
    centerNameLab.frame = CGRectMake((KScreenWidth-100)/2.0, ((PublicY)-40)-2, 100, 40);
    
    centerNameLab.textColor = [UIColor whiteColor];
    
    
    centerNameLab.hidden = NO;
    centerNameLab.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    centerNameLab.textAlignment = NSTextAlignmentCenter;
    _centerTopName = centerNameLab.text;
    [self.view addSubview:centerNameLab];
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle ) {
        
        centerNameLab.text = @"血压检测";
        
    }
    if (self.DectStyle == XKMutilPCBloodSugarStyle ||self.DectStyle == XKDetectBloodSugarStyle) {
        
        
        centerNameLab.text = @"血糖检测";
    }
    if (self.DectStyle == XKMutilPCTemperatureStyle ||self.DectStyle ==  XKDetectBloodTemperatureStyle) {
        
        centerNameLab.text = @"体温检测";
    }
    if (self.DectStyle == XKMutilPCBloodOxygenStyle ||self.DectStyle == XKDetectBloodOxygenStyle) {
        
        
        centerNameLab.text = @"血氧检测";
    }
    if (self.DectStyle == XKMutilPCNormalStyle ) {
        
        centerNameLab.text = @"脉率检测";
    }
    if (self.DectStyle == XKDetectHemoglobinStyle ) {
        centerNameLab.text = @"血红蛋白检测";
        
        
    }
    if (self.DectStyle == XKDetectWeightStyle ) {
        
        
        centerNameLab.text = @"";//体重检测
        
        
    }
    if (self.DectStyle == XKDetectDyslipidemiaStyle ) {
        
        centerNameLab.text = @"血脂检测";
        
    }
    
    
    
}
-(void)creatUI
{
    
    
    centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.frame = CGRectMake( (KScreenWidth-100)/2.0, ((PublicY)-40)-2, 100, 40);
    [centerBtn setTitle:@"空腹血糖" forState:UIControlStateNormal];
    [centerBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
    centerBtn.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    [centerBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    centerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);
    centerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    centerBtn.hidden = NO;
    [self.view addSubview: centerBtn];
    self.BloodSugarType = 1;
    [self change];
}
-(void)change
{
    NSLog(@"选择血糖");
    //    [self.view addSubview:self.SugarTopView];
    isOpenSelectView = !isOpenSelectView;
    if (isOpenSelectView) {
        [centerBtn setImage:[UIImage imageNamed:@"pullup"] forState:UIControlStateNormal];
        [self.SugarTopView openAllView];
    }else{
        [centerBtn setImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
        [self.SugarTopView closeAllView];
        
    }
    
}
-(void)selectIndex:(NSInteger)indexs andName:(NSString *)str andIsCloseView:(BOOL)ret;
{
    if (ret) {
        [self change];
    }
    if (indexs == 1) {
        
        [centerBtn setTitle:@"空腹血糖" forState:UIControlStateNormal];
    }else if (indexs == 2){
        
        [centerBtn setTitle:@"餐后2小时" forState:UIControlStateNormal];
    }else if (indexs == 3){
        
        [centerBtn setTitle:@"随机血糖" forState:UIControlStateNormal];
    }
    
    self.BloodSugarType = (int)indexs;
    NSLog(@"self.BloodSugarType%d",self.BloodSugarType);
    
    [self loadSearchView];
    [self createData];//搜索并连接爱奥乐血糖数据
    
}
-(void)clickBtn:(UIButton *)btn{
    [self popViewController];
    
}

#pragma mark   UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle||self.DectStyle == XKDetectWeightStyle) {
        
        return self.exDataArr.count;
    }
    
    else
    {
        if (self.exModel.ExStatus == 0) {//是否异常(0是1否)
            
            return self.exModel.SuggestList.count;
        }
        return 0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellid = @"XKSingleCheckMultipleCommonResultCell";
    XKSingleCheckMultipleCommonResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle||self.DectStyle == XKDetectWeightStyle) {
        ExchinereportModel *mod  = self.exDataArr[indexPath.row];
        //        if (mod.ExStatus == 0) {
        //             //是否异常(0是1否)
        //            cell.model = mod.SuggestList[0];
        cell.statusModel = mod;
        //        }
        //        else
        //            cell.model = nil;
        
    }
    else
    {
        if (self.exModel.ExStatus == 0) {
            cell.statusModel = self.exModel;
            cell.model = self.exModel.SuggestList[0];
        }
        
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle) {
    //        ExchinereportModel *mod  = self.exDataArr[indexPath.row];
    //        if (mod.ExStatus == 1) {//是否异常(0是1否)
    //            return 0;
    //        }else
    //            return UITableViewAutomaticDimension;
    //
    //    }
    //    else
    //    {
    //        if (self.exModel.ExStatus == 1) {
    //            return 0;
    //        }else
    return UITableViewAutomaticDimension;
    
    //    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (self.DectStyle == XKMutilPCBloodPressurStyle ||self.DectStyle == XKDetectBloodPressureStyle)  {
        
        return 308;
    }
    else if (self.DectStyle == XKDetectWeightStyle)
    {
        
        return 664;//  return 311;
    }
    else if (self.DectStyle == XKDetectDyslipidemiaStyle)
    {
        
        return 345;
    }
    else  if (self.DectStyle == XKMutilPCBloodOxygenStyle ||self.DectStyle == XKDetectBloodOxygenStyle)  {
        
        return 437;
    }
    return 385;
    
}

//表格组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.DectStyle == XKMutilPCBloodPressurStyle ||self.DectStyle == XKDetectBloodPressureStyle) {
        return self.headPresureView;
    }
    else  if (self.DectStyle == XKDetectDyslipidemiaStyle ) {
        return self.headHyperliView;
        
    }
    else if (self.DectStyle == XKDetectWeightStyle)
    {
        
        
        return self.checkHeader;
    }
    else if(self.DectStyle == XKDetectBloodOxygenStyle||self.DectStyle == XKMutilPCBloodOxygenStyle)
    {
        return  self.checkHeaderResultView;
        
    }
    else
        return self.checkHeaderCommonResultView;
    
}

//表格组尾部视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle ||self.DectStyle == XKDetectWeightStyle) {
        for (ExchinereportModel *exModel in self.exDataArr) {
            if (exModel.ExStatus == 0) {////是否异常(0是1否)
                return nil;
            }
        }
        return self.botoomView;
        
    }
    else  if (self.exModel) {////是否异常(0是1否)
        if (self.exModel.ExStatus == 1) {////是否异常(0是1否)
            return self.botoomView;
        }
        else // if (self.exModel.ExStatus == 0) {//self.exModel.SuggestList.count>0
        {  return nil;
        }
        //        return self.botoomView;
    }
    return self.botoomView;
}
//配置组底部视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    
    if (self.DectStyle == XKMutilPCBloodPressurStyle||self.DectStyle == XKDetectBloodPressureStyle||self.DectStyle == XKDetectDyslipidemiaStyle||self.DectStyle == XKDetectWeightStyle) {
        
        for (ExchinereportModel *exModel in self.exDataArr) {
            if (exModel.ExStatus == 0) {////是否异常(0是1否)
                return 0;
            }
        }
        return 300;
    }
    else  if (self.exModel) {////是否异常(0是1否)
        if (self.exModel.ExStatus == 1) {////是否异常(0是1否)
            return 300;
        }
        else // if (self.exModel.ExStatus == 0) {//self.exModel.SuggestList.count>0
        {  return 0;
        }
        //        return self.botoomView;
    }
    return 300;
    
    
}
//#pragma mark   上传数据接口
//-(NSString*)dictionaryToJson:(NSDictionary *)dic
//
//{
//
//    NSError *parseError = nil;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//}
#pragma mark   上传数据接口
-(void)loadData:(NSDictionary *)diction{
    
    if (self.isOtherDect == NO) {
        [self.checkHeaderResultView StopCircleAninmationAndHide];
        [self.checkHeaderCommonResultView StopCircleAninmationAndHide];
        [self.checkHeader StopCircleAninmationAndHide];
    }
    
    NSLog(@"center:%@",centerNameLab.text);
    centerBtn.hidden = YES;
    if (centerBtn.hidden) {
        centerNameLab.text = @"血糖检测";
        
    }
    centerNameLab.hidden = NO;
    self.shareBtn.hidden = NO;
    
    [self.headHyperliView stopAninmayion];
    
    [self.headPresureView stopAninmayion];
    
    //    [CRCreativeSDK sharedInstance].delegate = nil;
    
    if (self.jumpCountIndex == 1) {
        self.jumpCountIndex ++;
        XKCheckResultCommonViewController *check = [[XKCheckResultCommonViewController alloc]initWithType:pageTypeNoNavigation];
        check.diction = diction;
        //    check.temportySum = temportySum;
        //    check.temporaryDic = temporaryDic;
        check.DectStyle = self.DectStyle;
        check.manualText = self.manualText;
        check.manualTwoText = self.manualTwoText;
        check.manualThreeText = self.manualThreeText;
        check.manualFourText = self.manualFourText;
        check.BloodSugarType = self.BloodSugarType;
        [self.navigationController pushViewController:check animated:YES];
    }
    
    
    
}

#pragma mark   PC300血压  血样   各种设备检测

/**
 体温
 
 @param dict <#dict description#>
 */
-(void)temperatureSend:(NSDictionary *)dict;
{
    NSLog(@"-体温-%@",dict);
    self.checkHeaderCommonResultView.dataLab.text = [NSString stringWithFormat:@"%@",dict[@"temperature"] ];
    
    self.manualText = self.checkHeaderCommonResultView.dataLab.text;
    [self loadData:nil];
    
    
}

/**
 血压
 
 @param dict <#dict description#>
 */
-(void)resultSend:(NSDictionary *)dict;
{
    NSLog(@"--血压结果%@",dict);
    
    /*value1 = 83;心率
     value2 = 86;
     value3 = 116;收缩压
     value4 = 72;舒张压
     value5 = 1;
     value6 = 0;*/
    
    if (![NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"XKCheckResultCommonViewController"]) {
        
        [self.headPresureView.dataOneBtn  setTitle: [NSString stringWithFormat:@"%li",[dict[@"value3"] integerValue]]forState:UIControlStateNormal];//舒张压
        
        [self.headPresureView.dataTwoBtn  setTitle: [NSString stringWithFormat:@"%li",[dict[@"value4"] integerValue]] forState:UIControlStateNormal];//舒张压
        
        
        [self.headPresureView.dataThreeBtn  setTitle:[NSString stringWithFormat:@"%li",[dict[@"value1"] integerValue]] forState:UIControlStateNormal];//舒张压
        
        self.manualText = [NSString stringWithFormat:@"%li",[dict[@"value3"] integerValue]];
        
        self.manualTwoText = [NSString stringWithFormat:@"%li",[dict[@"value4"] integerValue]];
        
        self.manualThreeText = [NSString stringWithFormat:@"%li",[dict[@"value1"] integerValue]];
        
        self.PressjumpCountIndex = 2;
        
        NSLog(@"--PressjumpCountIndex----%d",self.PressjumpCountIndex);
        
        [self loadData:nil];
        
    }
    if (self.PressjumpCountIndex  == 1) {
        
    }
    
}
/**
 血压检测数据传输
 */
-(void)pressureSend:(NSDictionary *)dict;
{
    NSLog(@"-PC300血压-%@----%li",dict,[dict[@"pressure"] integerValue]);
    
}

/**
 血氧检测数据传输
 */
-(void)oxygenSend:(NSDictionary *)dict;
{
    NSLog(@"-PC300血氧-%@",dict);
    if ([dict[@"value1"] integerValue]!=0) {
        
        if (![NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"XKCheckResultCommonViewController"]) {
            
            self.checkHeaderResultView.dataLab.text = [NSString stringWithFormat:@"%@",dict[@"value1"]];
            
            self.manualText = self.checkHeaderResultView.dataLab.text;
            
            [self loadData:nil];
            
        }
        
    }
    
}


/**
 心电  脉率
 
 @param nHR <#nHR description#>
 */
-(void)ecgSendnHR:(NSInteger)nHR;
{
    
    
    NSLog(@"---ecgSendnHR---%li",nHR);
    
    if (nHR!=0) {
        //        if (self.jumpCountIndex == 1) {
        self.checkHeaderCommonResultView.dataLab.text = [NSString stringWithFormat:@"%li",nHR ];
        
        self.manualText = [NSString stringWithFormat:@"%li",nHR];
        
        [self loadData:nil];
        
    }
    
}
/**
 心电检测数据传输
 */
-(void)ecgSend:(NSString *)ecgStr  nHR:(NSInteger)nHR lead:(BOOL)bLeadOff;
{
    NSLog(@"-心电-%@----%d",ecgStr,bLeadOff);   //27    44  44
    
    //59:33。19  15:00:16  15:13:12.62 15:13:56.1800   15:15:16.65  15:16:00.23  15:18:17.75   15:19:01.14
    //15:20:08.57  15:20:51.817
    void (^createDataecg)(void) = ^{
        NSString *tempString =ecgStr;
        
        NSMutableArray *tempData = [[tempString componentsSeparatedByString:@","] mutableCopy];
        [tempData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *tempDataa = @([obj integerValue] );
            [tempData replaceObjectAtIndex:idx withObject:tempDataa];
        }];
        self.checkHeaderResultView.dataSource = tempData;
        //[self.checkHeaderResultView createWorkDataSourceWithTimeInterval:3];
    };
    createDataecg();
    
    
    NSArray *arr =  [ecgStr componentsSeparatedByString:@","];
    NSLog(@"-心电的值---%@",arr);
    
}

/**
 血糖
 
 @param nGu <#nGu description#>
 */
-(void)nGuiSendnGu:(NSInteger)nGu;
{
    
    NSLog(@"血糖类型-nGu值---%.1f--",(float)nGu/10.0);
    //血糖类型（1空腹2餐后）随机血糖
    
    self.checkHeaderCommonResultView.dataLab.text =  [NSString stringWithFormat:@"%.1f",(float)nGu/10.0];
    
    self.manualText = self.checkHeaderCommonResultView.dataLab.text;
    
    [self loadData:nil];
    
}
#pragma mark   MSBlueToothDelegate  体温
-(void)temperatureManagerToolSend:(NSString *)dict;
{
    NSLog(@"temperatureManagerToolSend:%@",dict);
    self.checkHeaderCommonResultView.dataLab.text = dict;
    self.manualText = dict;
    [self loadData:nil];
}

/**
 血脂  凯迪拉克
 
 @param dict <#dict description#>
 */
-(void)resultManagerToolSend:(NSDictionary *)dict;
{
    
    NSLog(@"resultManagerToolSend:%@",dict);
    
    NSString *CHOL = dict[@"CHOL"];
    NSString *TRIG = dict[@"TRIG"];
    NSString *CALC = dict[@"CALC"];//3
    NSString *HDL = dict[@"HDL"];//  4
    /*    Chol = "3.47";总胆固醇
     HDL = "2.59"; 高密度脂蛋白
     LDL = "1.81";低密度脂蛋白
     Mobile = 15970682406;
     Token = e530fa07bf1253022a192477621e6f43;
     Triglycerides = 0;甘油三脂
     
     CALC = "----";
     CHOL = "3.47";
     HDL = "2.59";
     TRIG = "1.81";
     }
     2018
     }*/
    
    [self.headHyperliView.dataTwoBtn setTitle: dict[@"TRIG"] forState:UIControlStateNormal];
    self.manualTwoText = dict[@"TRIG"];
    
    
    [self.headHyperliView.dataThreeBtn setTitle: dict[@"HDL"] forState:UIControlStateNormal];
    self.manualThreeText = dict[@"HDL"];
    
    
    [self.headHyperliView.dataOneBtn setTitle:dict[@"CHOL"] forState:UIControlStateNormal];
    self.manualText = dict[@"CHOL"];
    
    
    [self.headHyperliView.dataFourBtn setTitle:dict[@"CALC"]  forState:UIControlStateNormal];
    self.manualFourText = dict[@"CALC"];
    
    
    
    if ([CHOL containsString:@"-"]) {
        CHOL = @"0";
        self.manualText = @"0";
        [self.headHyperliView.dataOneBtn setTitle:@"--" forState:UIControlStateNormal];
        
    }
    if ([CALC containsString:@"-"]) {
        CALC = @"0";
        self.manualFourText =@"0";
        [self.headHyperliView.dataFourBtn setTitle:@"--"  forState:UIControlStateNormal];
    }
    if ([HDL containsString:@"-"]) {
        HDL = @"0";
        self.manualThreeText =@"0";
        [self.headHyperliView.dataThreeBtn setTitle: @"--" forState:UIControlStateNormal];
    }
    if ([TRIG containsString:@"-"]) {
        TRIG = @"0";
        self.manualTwoText = @"0";
        [self.headHyperliView.dataTwoBtn setTitle:@"--" forState:UIControlStateNormal];
    }
    [self loadData:nil];
}


#pragma mark   PODS
/**
 POD   血氧
 
 @param dict <#dict description#>
 */
-(void)oxygenPodSend:(NSDictionary *)dict;
{
    NSLog(@"-POD   血氧-%@",dict);
    if ([dict[@"value1"] integerValue]!=0) {
        
        self.checkHeaderResultView.dataLab.text = [NSString stringWithFormat:@"%@",dict[@"value1"]];
        
        self.manualText = self.checkHeaderResultView.dataLab.text;
        
        //  self.checkHeaderResultView.dataSource = @[@0,@0,@0,@0];
        
        
        
        //先让他做10秒中  然后再运行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if (![NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"XKCheckResultCommonViewController"]) {
                
                
                [self.bc PoddisconnectDevice];
                
                [self loadData:nil];
                
            }
            
        });
        
        
    }
    
    
}

-(void)TheConnectionPodStatus:(NSInteger)connectionStatus;
{
    
    
    if (connectionStatus == 3)
    {
        
        
        
        [self popViewController];//连接失败
    }
    if (connectionStatus == 2)
    {
        
        self.searchEquipView.style = 4;//连接陈功
        
    }
    if (connectionStatus == 7)
    {
        
        self.searchEquipView.style = 5;//正在连接中
        
    }
    
}
-(void)updateTheConnectionStatus:(NSInteger) connectionStatus;
{
    
    
    if (connectionStatus == 3)
    {
        
        
        //         ShowErrorStatus@"连接蓝牙异常，请重新检测" length:1];
        [self popViewController];
    }
    if (connectionStatus == 2)
    {
        
        self.searchEquipView.style = 4;//连接陈功
        
        
        
        
    }
    if (connectionStatus == 7)
    {
        
        self.searchEquipView.style = 5;//正在连接中
        
    }
    
}
/**
 未连接上设备的状态
 */
-(void)TheUnConnectionStatus;
{
    
    self.searchEquipView.style = 3;
    
}
-(void)popViewController{
    
    
    XKDectingViewController *chect;
    
    for (UIViewController *control in self.navigationController.viewControllers) {
        
        if ([control isKindOfClass:[XKDectingViewController class]]) {
            
            chect=(XKDectingViewController *)control;
        }
        
    }
    
    if (!chect) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        [self.navigationController popToViewController:chect animated:YES];
    }
    
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}
@end
