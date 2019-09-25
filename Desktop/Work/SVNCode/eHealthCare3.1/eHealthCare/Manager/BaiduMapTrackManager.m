//
//  BaiduMapTrackManager.m
//  eHealthCare
//
//  Created by John shi on 2018/7/13.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaiduMapTrackManager.h"
#define minDistance 5.0f
@interface BaiduMapTrackManager()

@end

@implementation BaiduMapTrackManager
static BaiduMapTrackManager *sharedBaiduMap = nil;
+ (BaiduMapTrackManager *)shareInstance
{
    static dispatch_once_t  once;
    dispatch_once(&once,^{
        
        sharedBaiduMap = [[BaiduMapTrackManager alloc] init];
        
    });
    
    return sharedBaiduMap;
}
-(NSMutableArray<CLLocation *> *)locations
{
    if (_locations== nil) {
        _locations = [NSMutableArray array];
    }
    
    return _locations;
}
#pragma mark - BMKLocationServiceDelegate
//是否正确定位
-(void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"定位失败 error : %@",error);
}
- (void)didUpdateUserHeading:(BMKUserLocation *)managerUseManager
{
    // 动态更新我的位置数据
    [self.delegate locationManagerdidUpdateUserHeading:managerUseManager];
}
//处理位置更新,即有位置更新的时候调用
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    if (TrailStart == self.trail) {
        self.userLocation = userLocation;
        CLLocation *location = userLocation.location;
        if(location.horizontalAccuracy <0 ||location.horizontalAccuracy>20.0) {
            NSLog(@"GPS信号差");
             [self.delegate locationManagerGPSData:location];

        }
        else if (0<location.horizontalAccuracy&&location.horizontalAccuracy<10) {
            NSLog(@"GPS信号强");
             [self.delegate locationManager:self didUpdatedLocations:self.locations];
        }
        else
        {
            NSLog(@"--location---drawWalkPolyline------%@",location);
            if(self.locations.count>1) {
                //计算本次定位数据与上一次的距离
                CGFloat distance = [location distanceFromLocation:[self.locations lastObject]];
                if(distance > minDistance) {
                    self.totalDistance += distance;
                    self.speed = location.speed;
                }else {
                    //不添加距离太近的两点，minDistance = 5 因为误差比较大
                    //程序在前台,或者在后台运行，即还保持活动状态,允许程序在后台运行
                    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
                    if( applicationState == UIApplicationStateActive||applicationState == UIApplicationStateBackground ) {
                        //位置发生变化的时候调用
                        [self.delegate locationManager:self didUpdatedLocations:self.locations];
                    }
                    return;
                }
            }
            //每次移动，位置更新的时候把当前的location加入数组self.locations
            [self.locations addObject:location];
        }
        //程序在前台,或者在后台运行，即还保持活动状态,允许程序在后台运行
        UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
        if(applicationState == UIApplicationStateActive||applicationState ==UIApplicationStateBackground) {
            //位置发生变化的时候调用
            [self.delegate locationManager:self didUpdatedLocations:self.locations];
//            [self changeTimeValue];//程序在前台或者后台锁屏会继续计时器增加计时
        }
        
    } else if (TrailEnd == self.trail) {
        
        //设置终点大头针
        //        self.endPoint = [self creatPointWithLocaiton:userLocation.location title:@"终点"];
        self.trail = TrailOther;
    }
    
}


//开始更新位置
-(void)startUpdatingLocation {
    if(self.running) {
        //已经在定时了
        return;
    }
    if(!_locationService) {
        _locationService = [[BMKLocationService alloc] init];
        
        if([UIDevice currentDevice].systemVersion.doubleValue>=9.0) {
            _locationService.allowsBackgroundLocationUpdates = YES;
        }
        
        _locationService.desiredAccuracy = kCLLocationAccuracyBest;
        _locationService.pausesLocationUpdatesAutomatically = NO;
        _locationService.delegate = self;
    }
    self.running = YES;
    if([self.delegate respondsToSelector:@selector(locationManager:didChangeLocationsState:) ]) {
        [self.delegate locationManager:self didChangeLocationsState:self.running];
    }
    //    //开始定位前清空数组
    self.trail = TrailStart;
   
    [self.locationService startUserLocationService];
    self.continuteLocationDate =  [[NSDate alloc]init];//当前时间
    
    if (self.pauseLocationDate) {
        NSTimeInterval seconds = [  self.continuteLocationDate  timeIntervalSinceDate:self.pauseLocationDate];
        NSLog(@"两个时间相隔：%f----%f", seconds,self.secondsLoactionDate);
        
        self.secondsLoactionDate += seconds;
    }else
         self.startLocationDate = [[NSDate alloc]init];//当前时间
 
}

//结束位置更新,即跑步结束
-(void)stopUpdatingLocation {
//    self.trail = TrailEnd;
    [self.locationService stopUserLocationService];
    self.locationService = nil;
    self.running = NO;
    if([self.delegate respondsToSelector:@selector(locationManager:didChangeLocationsState:) ]) {
        [self.delegate locationManager:self didChangeLocationsState:self.running];
    }
    self.pauseLocationDate =  [[NSDate alloc]init];//当前时间

}
//该方法永远不会被调用，因为在程序的生命周期内，该单例是一直存在的
-(void)dealloc {
    NSLog(@"RCLocationManager dealloc");
}
-(void)startTimer {
    
    //    [self resetRecord];
    if(!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimeValue) userInfo:nil repeats:YES];
        [self startUpdatingLocation];
        
        
    }else {
        [_timer setFireDate:[NSDate distantPast]]; //开始
        [self startUpdatingLocation];
    }
}
-(void)stopTimer {
    //唯一的方法将_timer从runloop池中移除,invalite会让timer退出runloop,取消timer
    [_timer invalidate];
    _timer = nil;
    //    _timerNumber = 0;
}
-(void)changeTimeValue {
    _timerNumber ++;
    if([self.delegate respondsToSelector:@selector(locationManagerTime:) ]) {
        [self.delegate locationManagerTime:_timerNumber];
    }
}
-(void)resetRecord {
    _timerNumber = 0;
    [_timer setFireDate:[NSDate distantFuture]]; //暂停
}
-(void)pauseRecord {
    [self stopUpdatingLocation];
    [_timer setFireDate:[NSDate distantFuture]]; //暂停
}
@end
