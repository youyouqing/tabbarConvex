//
//  BaiduMap_SportViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseViewController.h"
#import "BaiduMapTrackManager.h"
#include<stdlib.h>
#import "SportMapViewController.h"
#import "SportMapHeaderView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduTraceSDK/BaiduTraceSDK.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <dispatch/object.h>
#import "SportMessageView.h"
#import "SportViewModel.h"
typedef enum: NSUInteger {
    //定位 0,默认的
    MapViewTypeLocation,
    //运动轨迹 1
    MapViewTypeRunning,
    //轨迹回放 2
    MapViewTypeQueryDetail,
    //专用于保存的时候返回的轨迹
    MapViewTypeDetail
}MapViewType;

@class SportMapViewController;
@interface BaiduMap_SportViewController : BaseViewController
@property(nonatomic,strong) BaiduMapTrackManager *locationManager;
@property(nonatomic,strong) NSMutableArray<CLLocation *> *locations;

@property(nonatomic) MapViewType type;


@property (nonatomic, copy) void (^backSportDetailDataBlock)(NSString *distance);


@end
