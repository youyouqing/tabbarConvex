//
//  TodayHealthPlanViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/8/21.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, todayPlanType){
    
    ///今日计划进行中
    todayPlanTypeOngoing = 0,
    
    ///今日计划已完成
    todayPlanTypeFinished = 1,
    
    ///今日计划未完成
    todayPlanTypeUnFinished = 2,
    
    ///今日计划未开始
    todayPlanTypeInFuture = 3
};

@interface TodayHealthPlanViewController : BaseViewController

@property (nonatomic, strong) NSDictionary *dataDic;

///区分未完成 和 非未完成  未完成的UI和他们的不一样
@property (nonatomic, assign) BOOL isUnfinished;

///今日计划状态
@property (nonatomic, assign) todayPlanType planType;

@end
