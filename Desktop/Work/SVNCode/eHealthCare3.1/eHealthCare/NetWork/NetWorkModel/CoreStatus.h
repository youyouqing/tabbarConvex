//
//  CoreStatus.h
//  DecentTrainUser
//
//  Created by John shi on 2018/6/20.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Reachability.h>

#import "CoreStatusHead.h"
#import "CoreNetworkStatus.h"
#import "CoreStatusProtocol.h"


typedef void(^NotiNetworkBlock)(CoreNetWorkStatus netWorkStatus);

@interface CoreStatus : NSObject
HMSingletonH(CoreStatus)

// 网络状态改变通知
@property (nonatomic, copy) NotiNetworkBlock netWorkNotiBlock;
// 网络播放视频开关
@property (nonatomic, assign) BOOL netWorkSwitch;

//@property (nonatomic, strong) GameModel *gameModel;//选择的游戏Model


// 获取当前网络状态：枚举
+ (CoreNetWorkStatus)currentNetWorkStatus;

// 获取当前网络状态：字符串
+ (NSString *)currentNetWorkStatusString;


// 开始网络监听
+ (void)beginNotiNetwork:(id<CoreStatusProtocol>)listener;

// 停止网络监听
+ (void)endNotiNetwork:(id<CoreStatusProtocol>)listener;


// 是否是Wifi
+ (BOOL)isWifiEnable;

// 是否有网络
+ (BOOL)isNetworkEnable;

// 是否处于高速网络环境：3G、4G、Wifi
+ (BOOL)isHighSpeedNetwork;


@end
