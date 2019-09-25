//
//  AppointInfoModel.h
//  eHealthCare
//
//  Created by xiekang on 17/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointInfoModel : NSObject
/**
 姓名
 */
@property (nonatomic,copy)NSString *FullName;

/**
 性别
 */
@property (nonatomic,assign)NSInteger Sex;

/**
 电话
 */
@property (nonatomic,copy)NSString *Phone;

/**
 身份证号
 */
@property (nonatomic,copy)NSString *IDCard;

/**
 预约时间
 */
@property (nonatomic,copy)NSString *ReserveTime;

/**
 购买方式
 */
@property (nonatomic,assign)NSInteger PayMethod;

/**
 购买类型
 */
@property (nonatomic,assign)NSInteger PuyType;
@end
