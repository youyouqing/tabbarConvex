//
//  BaiduMapTrackManager.h
//  eHealthCare
//
//  Created by John shi on 2018/7/13.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduTraceSDK/BaiduTraceSDK.h>
#import <CoreLocation/CoreLocation.h>
//定位头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
typedef NS_ENUM(NSUInteger, ServiceOperationType) {
    YY_SERVICE_OPERATION_TYPE_START_SERVICE,
    YY_SERVICE_OPERATION_TYPE_STOP_SERVICE,
    YY_SERVICE_OPERATION_TYPE_START_GATHER,
    YY_SERVICE_OPERATION_TYPE_STOP_GATHER,
};
typedef enum : NSUInteger {
    TrailOther = 0,
    TrailStart,
    TrailEnd,
} Trail;
@class BaiduMapTrackManager;
@protocol BaiduMapTrackManagerDelegate <NSObject>
//当位置发生变化的时候调用
-(void)locationManager:(BaiduMapTrackManager *)manager didUpdatedLocations:(NSArray<CLLocation *> *)locations;
-(void)locationManagerdidUpdateUserHeading:(BMKUserLocation *)managerUseManager ;
//当运动状态发生变化时候调用 [即是running 是true还是false]
@optional
-(void)locationManager:(BaiduMapTrackManager *)manager didChangeLocationsState:(BOOL)running;




-(void)locationManagerTime:(NSInteger)timerNumber;


-(void)locationManagerGPSData:(CLLocation *)GPS;
@end
@interface BaiduMapTrackManager : NSObject <BTKTraceDelegate>
//存储用户每次移动的位置点
@property(nonatomic,strong) NSMutableArray<CLLocation *> *locations;
//是否是在运动
@property(nonatomic,getter=isRunning) BOOL running;
@property(nonatomic,strong) BMKLocationService *locationService;
//保存总记录
@property(nonatomic) double totalDistance;

@property(nonatomic,weak) NSTimer *timer;
//速度
@property(nonatomic) double speed;
//定位开始时间
@property(nonatomic,strong) NSDate *startLocationDate;


//开始时间
@property(nonatomic,strong) NSDate *continuteLocationDate;

//暂停时间
@property(nonatomic,strong) NSDate *pauseLocationDate;
@property(nonatomic,assign)NSTimeInterval secondsLoactionDate;
//显示当前所在的位置
@property(nonatomic,strong) BMKUserLocation *userLocation;
//开始定位
-(void)startUpdatingLocation;

//停止定位
-(void)stopUpdatingLocation;
@property(nonatomic,weak) id <BaiduMapTrackManagerDelegate> delegate;

+ (BaiduMapTrackManager *)shareInstance;

//用于记时的
@property(nonatomic,assign) NSInteger timerNumber;
/** 轨迹记录状态 */
@property (nonatomic, assign) Trail trail;
//重置记录
-(void)resetRecord;
//开始记时器
-(void)startTimer;
//停止记时器
-(void)stopTimer;
-(void)pauseRecord;
@end