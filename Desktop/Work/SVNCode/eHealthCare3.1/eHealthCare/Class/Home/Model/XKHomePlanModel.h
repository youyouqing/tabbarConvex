//
//  XKHomePlanModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKHomePlanModel : NSObject

/**
 健康计划主编号
 */
@property (nonatomic,assign)NSInteger PlanMainID;

/**
 用户加入计划记录ID
 */
@property (nonatomic,assign)NSInteger MemPlanID;
//1、饮食 2、运动 3、调理
@property (nonatomic,assign)NSInteger PlanTypeID;

//是否完成当日计划 1、是 0、否
@property (nonatomic,assign)NSInteger IsCurrentComplete;
/**
 健康计划Logo
 */
@property (nonatomic,copy)NSString *PlanLogo;

/**
 健康计划标题
 */
@property (nonatomic,copy)NSString *PlanTitle;

/**
 健康计划当前天数
 */
@property (nonatomic,assign)NSInteger CurrrentDays;

/**
 健康计划当日第一步内容
 */
@property (nonatomic,copy)NSString *TodayContent;

//计划完成比例（如60、
@property (nonatomic,assign)NSInteger PlanCompletePercent;

/**
PlanBGM
 */
@property (nonatomic,copy)NSString *PlanBGM;


@property (nonatomic,assign)BOOL isMiddle;
@end