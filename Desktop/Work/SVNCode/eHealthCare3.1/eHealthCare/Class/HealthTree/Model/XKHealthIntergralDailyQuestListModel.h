//
//  XKHealthIntergralDailyQuestListModel.h
//  eHealthCare
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 mac. All rights reserved.
/*DailyQuestList 每日任务列表*/

#import <Foundation/Foundation.h>

@interface XKHealthIntergralDailyQuestListModel : NSObject

/*TaskID
 Int32
 每日任务编号
 */
@property (nonatomic,assign) NSInteger TaskID;

/*TaskTitle
 String
 每日任务标题
 */
@property (nonatomic,copy) NSString *TaskTitle;

/*TaskMainID
 String
 每日任务主编号
 */
@property (nonatomic,assign) NSInteger TaskMainID;

/*KCurrency
 Int32
 任务奖励康币
 */
@property (nonatomic,assign) NSInteger KCurrency;

/*KValue
 Int32
 任务奖励K值
 */
@property (nonatomic,assign) NSInteger KValue;

/*TaskTypeID
 Int32
 每日任务类型（1、签到任务 2、测量任务 3、舒缓心情任务 4、健康计划任务 5、健康小工具任务 6、养生小知识任务 7、运动任务）
 */
@property (nonatomic,assign) NSInteger TaskTypeID;

/*Days
 Int32
 当前第几天任务
 */
@property (nonatomic,assign) NSInteger Days;

/*Iscomplete
 Int32
 是否完成（1、完成 0、未完成）
 */
@property (nonatomic,assign) NSInteger Iscomplete;

@end
