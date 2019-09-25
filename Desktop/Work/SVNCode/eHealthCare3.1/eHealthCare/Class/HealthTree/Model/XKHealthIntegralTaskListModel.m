//
//  XKHealthIntegralTaskListModel.m
//  eHealthCare
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本健康任务列表页面实体类

#import "XKHealthIntegralTaskListModel.h"

@implementation XKHealthIntegralTaskListModel


/**
重写每日任务列表set方法
 */
-(void)setDailyQuestList:(NSArray *)DailyQuestList{
    _DailyQuestList = DailyQuestList;
    //数据格式化
    _DailyQuestList = [XKHealthIntergralDailyQuestListModel objectArrayWithKeyValuesArray:_DailyQuestList];
}

/**
 重写每日福利任务set方法
 */
-(void)setWelfareTaskList:(NSArray *)WelfareTaskList{
    _WelfareTaskList = WelfareTaskList;
    //数据格式化
    _WelfareTaskList = [XKXKHealthIntergralDailyPlanHealthDetailListModel objectArrayWithKeyValuesArray:_WelfareTaskList];
}

@end
