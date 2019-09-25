//
//  XKHealthIntegralTaskListModel.h
//  eHealthCare
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本健康任务列表页面实体类

#import <Foundation/Foundation.h>

//导入福利任务、每日任务实体类
#import "XKXKHealthIntergralDailyPlanHealthDetailListModel.h"
#import "XKHealthIntergralDailyQuestListModel.h"

@interface XKHealthIntegralTaskListModel : NSObject

/**KCurrency
 Int32
 用户总康币
 */
@property (nonatomic,assign) NSInteger KCurrency;

/*KValue
 Int32
 用户当天K值
 */
@property (nonatomic,assign) NSInteger KValue;

/*DailyQuestList 每日任务列表*/
@property (nonatomic,strong) NSArray *DailyQuestList;

/*PlanHealthDetailList 福利任务列表*/
@property (nonatomic,strong) NSArray *WelfareTaskList;

@end
