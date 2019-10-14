//
//  AppDelegate.h
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarController.h"
//百度地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "UIViewController+Entension.h"

static NSString *appKey = @"7a2856b652a3442f28b869a6";
static NSString *channel = @"App Store";
static BOOL isProduction =true;// true;//
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BMKMapManager *mapManager;//百度地图
@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier taskId;
@property (nonatomic, strong) NSTimer *timer;
@end
