//
//  DateformatTool.h
//  eHealthCare
//
//  Created by John shi on 2018/7/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateformatTool : NSObject

///时间转时间戳
//+ (NSString *)dateTransformToString:(NSDate *)date;
//
/////时间戳转时间
//+ (NSString *)stringFromTimeInterVerString:(NSString *)timeIntervel;
//
/////转年月日格式时间:2018-07-03
+ (NSString *)ymdStringFromString:(NSDate *)date;
//
/////字符串转时间NSDate
+ (NSDate *)dateFromString:(NSString *)str;
//
/////日期转星期几
//+ (NSString*)weekdayStringFromDate:(NSDate*)date;
//
///*
// 秒转时分秒格式
// fillMinute:时间小于30秒情况下是否显示为1分钟
// */
//+ (NSString *)trimCurrentTimeFormat:(long long)time fillMinute:(BOOL)fillMinute;


/**
 获取当前时间

 @return 当前时间字典
 */
+ (NSDictionary *)getDateTime;


/**
 输出对应格式的时间字符串

 @param date 需要被转换的时间字符串
 @param format 需要输出的格式
 @return 被处理后的时间字符串
 */
+ (NSString *)DateFormatWithDate:(NSString *)date withFormat:(NSString *)format;

@end
