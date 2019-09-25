//
//  SportMessageView.h
//  eHealthCare
//
//  Created by John shi on 2018/7/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MZTimerLabel.h>

#import "BaiduMap_SportViewController.h"

@protocol SportMessageDelegate <NSObject>

///开始
- (void)sportStart;

///暂停  返回1就是继续，0就是暂停
- (void)sportPauseOrReStart:(BOOL)isStart;

///结束
- (void)sportFinish;

@end

@interface SportMessageView : UIView

@property (nonatomic, weak) id <SportMessageDelegate> delegate;

- (instancetype)initWithType:(sportCommonType)sportType;

///运动类型
@property (nonatomic, assign) sportCommonType sportType;

// 距离
@property (nonatomic, strong) UILabel *distance;

// 平均速度
@property (nonatomic, strong) UILabel *avgSpeed;

// 目前速度
@property (nonatomic, strong) UILabel *currSpeed;

// 计时器
@property (nonatomic, strong) MZTimerLabel *timerLabel;

// 与上一个点的距离
@property (nonatomic, strong) UILabel *distanceWithPreLoc;

// 是否已经插上开始的旗帜
@property (nonatomic, strong) UILabel *startPointLabel;

// 是否已经插上结束的旗帜
@property (nonatomic, strong) UILabel *stopPointLabel;

// 累计用时
@property (nonatomic, strong) UILabel *sumTime;

//能量消耗
@property (nonatomic, strong) UILabel *EnergyLabel;

@end
