//
//  Dateformat.h
//  test
//
//  Created by RuanZhenJie on 10/10/15.
//  Copyright (c) 2015年 xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dateformat : NSObject
- (NSString *)DateFormatWithDate:(NSString *)date withFormat:(NSString *)format;
- (NSString *)timeSpWithDate:(NSString *)date withFormat:(NSString *)format;
+ (NSString *)DateFormatWithMd5:(NSString *)inputStr;
+ (NSString *)md532BitUpper:(NSString *)str;
+ (NSString *)DateFromDatePicker:(id)picker withDateFormat:(NSString *)format;
+ (NSString *)getSignMd5WithDic:(NSDictionary *)params andParameterArr:(NSArray *)parameterNameArr;
- (NSDictionary *)getDateTime;
+ (NSString  *)hideCharacterWith:(NSString *)str andBeginNum:(NSInteger)beginNum andEndNum:(NSInteger)endNum;

/**
 当前时间戳

 @return <#return value description#>
 */
+(NSInteger)getNowTimestamp;
/**彩色图片变黑白*/
+(UIImage *)grayImage:(UIImage *)sourceImage;

-(NSString *)AlltimeConvertSp:(NSString *)dateSp;

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime;

/**
 1992-11-12转位为时间戳
 
 @return
 */
-(NSString *)timeConvertSp:(NSString *)dateSp;
/**
 时间戳转为1992-11-12
 
 @return
 */
-(NSString *)SptimeConvertDate:(NSString *)date;

/**
 判断当前时间是否在fromHour和toHour之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour ;
@end
