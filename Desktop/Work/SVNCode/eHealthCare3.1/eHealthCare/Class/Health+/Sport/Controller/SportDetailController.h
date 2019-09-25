//
//  SportDetailController.h
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunningView.h"
#import "BaiduMap_SportViewController.h"
#import "XKSpLockedView.h"
#import "SportViewModel.h"
#import "XKAcountHistoryViewController.h"
#import <CoreLocation/CoreLocation.h>
//定位头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "SportViewController.h"
@class BaiduMapTrackManager;
@interface SportDetailController : BaseViewController
@property(nonatomic,strong) BaiduMapTrackManager *locationManager;

@property (nonatomic,strong) UIButton *presentControllerButton;
@end
