//
//  SportDetailController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportDetailController.h"

@interface SportDetailController ()
#define removeObjectsLen 20
@property(nonatomic,strong) BMKLocationService *locationService;



@property(nonatomic,strong) RunningView *runningView;
/**
 锁屏视图
 */
@property (nonatomic,strong)XKSpLockedView *lockedView;
@end

@implementation SportDetailController
/**
 改变view的透明图
 */
- (void)changeView:(BOOL)isUnLock{
    XKSpLockedView *myLockedView = [[NSBundle mainBundle]loadNibNamed:@"XKSpLockedView" owner:nil options:nil].lastObject;
    _lockedView = myLockedView;
    myLockedView.frame = [UIScreen mainScreen].bounds;
    myLockedView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:myLockedView];
}
-(RunningView *)runningView {
    if(!_runningView) {
        _runningView = [[[NSBundle mainBundle] loadNibNamed:@"RunningView" owner:self options:nil] firstObject];
        _runningView.x = 0;
        _runningView.y = 0;
        _runningView.width = KScreenWidth;
        _runningView.height = KScreenHeight;
        _runningView.delegate = self;
    }
    return _runningView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.runningView;
    if ([SportCommonMod shareInstance].isMinuteCount == YES) {
        self.runningView.runDesMinute = RunningTypeMinute;
    }else
        self.runningView.runDesMinute = RunningTypeKilometer;
    self.presentControllerButton = self.runningView.mapButton;
    [self presentMapVC];
    [self loadSharedRCLocationManagerInstance];
    //更新数据时减少getter访问的次数[???]
    self.locationManager.totalDistance = 0;
    [self.locationManager startTimer];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //这里一定要再设置一次，因为如果从地图页面过来的，viewDidLoad()不会再加载了，只会加载viewWillAppear:方法
   [BaiduMapTrackManager shareInstance].delegate = self;
    if(self.locationManager.running) {
         if ([SportCommonMod shareInstance].isMinuteCount == YES) {
             double allTime = self.locationManager.timerNumber;//hours*60+minutes+(floorf(seconds)/60);
             int pm = [[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] / 60;
             int ps = ((int)[[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] % 60);//每公里用时, 秒  9*60+17;
             NSString *pace = [NSString stringWithFormat:@"%d'%d\"", pm,ps];
             
             self.runningView.timeLB.text = pace;
         }else
        self.runningView.timeLB.text = [NSString stringWithFormat:@"%.2ld:%.2ld",[BaiduMapTrackManager shareInstance].timerNumber/60,[BaiduMapTrackManager shareInstance].timerNumber%60];
    }
    [self continueTimer];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
-(void)stopRecord {
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    //这一句不用加，因为locationManager是个单例，它的dealloc方法永远不会被调用，因为在程序的生命周期内，该单例一直都存在
    //    self.locationManager = nil;
}
-(void)loadSharedRCLocationManagerInstance {
    BaiduMapTrackManager *locationManager = [BaiduMapTrackManager shareInstance];
    if(!locationManager.running) {
        //开始定位,这时locationManager.running = YES;直到点击暂停按钮再把locationManager.running = NO;
        //即running从该VC一加载算起，直到停止按钮点击的时候停止
        //不能把running理解为跑步的时候为true,停止下来休息的时候为false
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    self.locationManager = locationManager;
}

-(void)stopTime {
    //关闭定时器
    [self.locationManager.timer setFireDate:[NSDate distantFuture]];
}
-(void)presentMapVC {
    [self.runningView.mapButton addTarget:self action:@selector(mapShow) forControlEvents:UIControlEventTouchUpInside];
}
-(void)mapShow {
    BaiduMap_SportViewController *mapVc = [[BaiduMap_SportViewController alloc]initWithType:pageTypeNoNavigation];
    mapVc.type = self.locationManager.running;
    
    mapVc.locationManager = self.locationManager;
    mapVc.locations = [NSMutableArray arrayWithArray:self.locationManager.locations];
    mapVc.backSportDetailDataBlock = ^(NSString *distance) {
        self.runningView.runDistanceLB.text = distance;
        if ([SportCommonMod shareInstance].isMinuteCount == YES) {
            double allTime = self.locationManager.timerNumber;//hours*60+minutes+(floorf(seconds)/60);
            int pm = [[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] / 60;
            int ps = ((int)[[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] % 60);//每公里用时, 秒  9*60+17;
            NSString *pace = [NSString stringWithFormat:@"%d'%d\"", pm,ps];
            
            self.runningView.timeLB.text = pace;
        }else
        {
            
            
            [self.runningView updateProgressCircle:[self.runningView.runDistanceLB.text floatValue]/ [SportCommonMod shareInstance].totalDistance];
            
        }
    };
    [self presentLHViewController:mapVc tapView:self.runningView.mapButton color:nil animated:YES completion:^{
        
    }];
}
-(void)continueTimer {
    BaiduMapTrackManager *locationManager = [BaiduMapTrackManager shareInstance];
    if(locationManager.running) {
    [self.locationManager.timer setFireDate:[NSDate distantPast]];
    NSDate *nowDate = [[NSDate alloc] init];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.locationManager.startLocationDate];
    NSLog(@"两个时间相隔222：%f---%f", timeInterval,self.locationManager.secondsLoactionDate);
    self.locationManager.timerNumber = (NSInteger)timeInterval-self.locationManager.secondsLoactionDate;
    }
}
-(void)locationManagerdidUpdateUserHeading:(BMKUserLocation *)managerUseManager ;
{
    
    NSLog(@"----locationManagerdidUpdateUserHeading---%@",managerUseManager);
}
#pragma mark- RCLocationManagerDelegate
-(void)locationManager:(BaiduMapTrackManager *)manager didUpdatedLocations:(NSArray<CLLocation *> *)locations {
    self.runningView.runDistanceLB.text = [NSString stringWithFormat:@"%.2lf",manager.totalDistance/1000.0];
    
    if ([SportCommonMod shareInstance].isMinuteCount == YES)
    {
        double allTime = self.locationManager.timerNumber;//hours*60+minutes+(floorf(seconds)/60);
        int pm = [[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] / 60;
        int ps = ((int)[[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] % 60);//每公里用时, 秒  9*60+17;
        NSString *pace = [NSString stringWithFormat:@"%d'%d\"", pm,ps];
        
        self.runningView.timeLB.text = pace;
    }else
    {

        [self.runningView updateProgressCircle:[self.runningView.runDistanceLB.text floatValue]/ [SportCommonMod shareInstance].totalDistance];
    }
    
    
    NSLog(@"---didUpdatedLocations---%@",self.runningView.distanceLB.text);
}
-(void)locationManagerGPSData:(CLLocation *)GPS;
{
    NSLog(@"---locationManagerGPSData-");
    
}
-(void)locationManager:(BaiduMapTrackManager *)manager didChangeLocationsState:(BOOL)running {
    if(running) {
        [self.locationManager startTimer];
        UIApplication *app = [UIApplication sharedApplication];
        //接收当前的UIApplication[单例]发送的通知，然后处理selector
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueTimer) name:UIApplicationWillEnterForegroundNotification object:app];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTime) name:UIApplicationDidEnterBackgroundNotification object:app];
        
    }else {//点击停止按钮后
        [self.locationManager stopTimer];
        
    }
}
-(void)locationManagerTime:(NSInteger)timerNumber;
{
    //默认120分钟
    
    long seconds =  [SportCommonMod shareInstance].totalTime*60;
    
    seconds = seconds - self.locationManager.timerNumber;

    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    NSLog(@"%@",format_time);
    
    int hours = [str_hour integerValue];
    
    //    double minutes = (self.locationManager.timerNumber - (3600*hours)) / 60;
    if ([SportCommonMod shareInstance].isMinuteCount == YES) {
        if (hours>=1) {
            self.runningView.unitLabel.text = @"时:分";
            self.runningView.minuteCountLab.text = [NSString stringWithFormat:@"%d:%.2ld",[str_hour intValue],(long)[str_minute integerValue]];
        }else
        {
            self.runningView.unitLabel.text = @"分:秒";
            self.runningView.minuteCountLab.text = [NSString stringWithFormat:@"%ld:%.2ld",(long)[str_minute integerValue],(long)[str_second integerValue]];
        }
        if (seconds <= 0) {
            //alert
            self.runningView.minuteCountLab.text = @"00:00";
            if (seconds == 0) {
                ShowAutoDissmissMessage(@"亲,到计时结束咯~");
            }
            
            return;
        }
        
    }else
    {

        self.runningView.timeLB.text = [NSString stringWithFormat:@"%.2ld:%.2ld",timerNumber/60,timerNumber%60];


    }
    
    
}
#pragma mark  解锁
- (void)unLocked{
    [self.lockedView removeFromSuperview];
    self.lockedView = nil;
}
#pragma mark  解锁
- (void)lockOrunLockBtn;
{
    [self changeView:YES];
    
}
- (void)suspendOrunKeep:(BOOL)keep;
{
    if (keep == YES) {
        [self continueTimer];
        [self loadSharedRCLocationManagerInstance];
    }else
    {
        [self.locationManager pauseRecord];
        [self stopRecord];
    }
    
}
-(void)stopActionBtn;
{
    //点击停止按钮后
    [self.locationManager stopTimer];
    //下面开始做保存的工作
    if(self.locationManager.locations.count < 3) {
        [self.locationManager resetRecord];
        [self stopRecord];
        self.locationManager.timerNumber = 0;
       self.locationManager.pauseLocationDate =self.locationManager.continuteLocationDate = self.locationManager.startLocationDate = nil;
        self.locationManager.secondsLoactionDate = 0;
        if (self.locationManager.timer) {
            self.locationManager.timer = nil;
            [self.locationManager.timer invalidate];
        }
        //弹出
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"距离太短,无法保存" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popSportViewController];
        }];
        [alert addAction:doAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if(self.locationManager.locations.count >= 3) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            //主线程中更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSInteger endTime = [[NSDate date] timeIntervalSince1970];
                NSDate *nowDate = [[NSDate alloc] init];
                NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:self.locationManager.startLocationDate];
                NSInteger timeInt = timeInterval;
                NSString *startTime = [NSString stringWithFormat:@"%ld000", (long)[self.locationManager.startLocationDate timeIntervalSince1970]];
                 double calerisSum;
                if ([SportCommonMod shareInstance].Type == 2) {
                    
                  
                     calerisSum =  70*(ceil(30)/24*[self.runningView.runDistanceLB.text floatValue])*(1.0);
                }
                if ([SportCommonMod shareInstance].Type == 3) {
                    double spd = [self.runningView.runDistanceLB.text floatValue]/((self.locationManager.timerNumber)/3600);
                    calerisSum = [self.runningView.runDistanceLB.text floatValue] * 70*1.05;
                }
                if ([SportCommonMod shareInstance].Type == 4) {
                    double spd = [self.runningView.runDistanceLB.text floatValue]/((self.locationManager.timerNumber)/3600);
                    calerisSum = [self.runningView.runDistanceLB.text floatValue] * 70*1.05;
                }
                
                double allTime = self.locationManager.timerNumber;//配速
                int pm = [[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] / 60;
                int ps = ((int)[[NSString stringWithFormat:@"%lf",allTime/[self.runningView.runDistanceLB.text floatValue]] doubleValue] % 60);//每公里用时, 秒  9*60+17;
                NSString *pace = [NSString stringWithFormat:@"%d'%d‘’", pm,ps];
                
                [[XKLoadingView shareLoadingView]showLoadingText:nil];
                NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"KilometerCount":[NSString stringWithFormat:@"%.2f",[self.runningView.runDistanceLB.text floatValue]],
                                       @"KilocalorieCount":[NSString stringWithFormat:@"%.2f",calerisSum],
                                       @"AvgPace":pace,
                                       @"TotalUseTime":@(timeInt),
                                       @"PatternType":@([SportCommonMod shareInstance].Type),//类型（2跑步3骑行4登山）
                                       @"StartTime":startTime,
                                       @"EndTime":@(endTime*1000)};
                NSLog(@"343添加运动-------%@",dict);
                [SportViewModel updateSprotMessageWithParams:dict FinishedBlock:^(ResponseObject *response) {
                    [[XKLoadingView shareLoadingView] hideLoding];
                    if (response.code == CodeTypeSucceed) {
                        self.locationManager.timerNumber = 0;
                        self.locationManager.startLocationDate = nil;
                        self.locationManager.secondsLoactionDate = 0;
                        if (self.locationManager.timer) {
                            [self.locationManager.timer invalidate];
                            self.locationManager.timer = nil;
                            
                        }
                        [self stopRecord];
                         [self.locationManager.locations removeAllObjects];
                        NSLog(@"343添加运动（跑步、骑行、新增登山）:%@",response.Result);
                     
                       
                    }else
                    {
                         ShowErrorStatus(response.msg);
                        
                    }
                    [self popSportViewController];
                }];
                
            });
        });
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)popSportViewController{

        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[SportViewController class]])
            {
                SportViewController *test = (SportViewController *)controller;
                [self.navigationController popToViewController:test animated:YES];
                return;
            }
            
        }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)enterTrendPage;
{
    XKAcountHistoryViewController *history = [[XKAcountHistoryViewController alloc] initWithType:pageTypeNormal];
    //    history.step = self.step;
    UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
    while (rootViewController.presentedViewController)
    {
        rootViewController = rootViewController.presentedViewController;
    }
    [rootViewController presentViewController:history animated:YES completion:nil];
    
}
@end
