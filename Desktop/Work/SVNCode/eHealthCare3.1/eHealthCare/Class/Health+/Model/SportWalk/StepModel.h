//
//  StepModel.h
//  eHealthCare
//
//  Created by jamkin on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StepModel : NSObject

@property (nonatomic,assign)NSInteger StepOrder;

@property (nonatomic,assign)long CreateTime;

@property (nonatomic,assign)CGFloat KilocalorieCount;

@property (nonatomic,assign)CGFloat KilometerCount;

@property (nonatomic,assign)NSInteger StepCount;

/**不行建议**/
@property (nonatomic,copy)NSString *SuggestContent;

/**
 表示月份和日期
 */
@property (nonatomic,copy) NSString *completeDate;

/**
 表示周几
 */
@property (nonatomic,copy) NSString *weekDay;

/**
 表示今天是几号
 */
@property (nonatomic,copy) NSString *dayTime;

@end
