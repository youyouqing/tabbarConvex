//
//  XKSpHistoryModel.h
//  eHealthCare
//
//  Created by xiekang on 2017/9/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKSpHistoryModel : NSObject

@property (nonatomic,assign) NSInteger StepManageID;


/**
 步数
 */
@property (nonatomic,assign)CGFloat StepCount;



/**
 公里数

 */
@property (nonatomic,assign)CGFloat KilometerCount;


/**
 千卡数
*/
@property (nonatomic,assign)CGFloat KilocalorieCount;
/**
 总计用时(格式:00:00)“：”用英文分号隔开
 如果时间超过1小时用（01:00:00）
 */
@property (nonatomic, copy) NSString *TotalUseTime;

/**
 创建时间
 */
@property (nonatomic, assign) long CreateTime;

/**
 字符串
 */
@property (nonatomic,copy) NSString *strTime;


/**
 排序的年月时间字符串
 */
@property (nonatomic,copy) NSString *rankTime;
/**
 平均配速(格式00′00′′)

 */
@property (nonatomic, copy) NSString *AvgPace;

/**
 开始时间
 */
@property (nonatomic, assign) long StartTime;

/**
 结束时间
 */
@property (nonatomic, assign) long EndTime;

/**
 超越多少人
 */
@property (nonatomic,assign) NSInteger Ranking;

/**
 二维码路径
 */
@property (nonatomic,copy) NSString *WechatImg;



+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)otherDay;

@end
