//
//  XKXKHealthIntergralDailyPlanHealthDetailListModel.h
//  eHealthCare
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 mac. All rights reserved.
/*PlanHealthDetailList 福利任务列表*/

#import <Foundation/Foundation.h>

@interface XKXKHealthIntergralDailyPlanHealthDetailListModel : NSObject

/*WelfareTaskID
 Int32
 福利任务编号
 */
@property (nonatomic,assign) NSInteger WelfareTaskID;

/*WelfareTaskTitle
 String
 福利任务标题
 */
@property (nonatomic,copy) NSString *WelfareTaskTitle;

/*WelfareTaskContent
 String
 福利任务内容
 */
@property (nonatomic,copy) NSString *WelfareTaskContent;

/*KValue
 Int32
 任务奖励K值
 */
@property (nonatomic,assign) NSInteger KValue;

/*KCurrency
 Int32
 奖励康币
 */
@property (nonatomic,assign) NSInteger KCurrency;

/*TaskTypeID
 Int32
 福利任务类型（1、完善个人档案 2、完善家庭成员档案3、检测报告4、预约健康体检 5、分享阅读 6、关联设备 7、购买商品 8、评论健康资讯）
 */
@property (nonatomic,assign) NSInteger TaskTypeID;

/*Iscomplete
 Int32
 是否完成（1、已完成 2、未完成）
 */
@property (nonatomic,assign) NSInteger Iscomplete;


@end
