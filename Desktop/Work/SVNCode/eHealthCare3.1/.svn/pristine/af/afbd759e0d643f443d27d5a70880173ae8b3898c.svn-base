//
//  DateformatTool.m
//  eHealthCare
//
//  Created by John shi on 2018/7/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "DateformatTool.h"

@implementation DateformatTool

//时间转时间戳
+ (NSString *)dateTransformToString:(NSDate *)date{
    
    NSTimeInterval timeInterval = [date timeIntervalSince1970] * 1000; //*1000是精确到毫秒，不乘就是精确到秒
    NSString *timeStamp = [NSString stringWithFormat:@"%.0f", timeInterval]; //转为字符型
    return timeStamp;
}

//时间戳转时间
+ (NSString *)stringFromTimeInterVerString:(NSString *)timeIntervel{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(timeIntervel.longLongValue) / 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

//转年月日格式
+ (NSString *)ymdStringFromString:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *ymrStr = [dateFormatter stringFromDate:date];
    return ymrStr;
}

//字符串转时间NSDate
+ (NSDate *)dateFromString:(NSString *)str{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[dateFormat dateFromString:str];
    return date;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)date {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shenzhen"];
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString *)trimCurrentTimeFormat:(long long)time fillMinute:(BOOL)fillMinute{
    
    long long h = time / (60 * 60);
    long long m = time % (60 * 60) / 60;
    long long s = time % 60;
    
    NSString *timeStr = @"0分钟";
    if (time < 30 && fillMinute) {
        
        timeStr = @"1分钟";
    }
    else{
        
        if (s >= 30) {
            
            m += 1;
        }
        timeStr = [NSString stringWithFormat:@"%lld分", m];
        
        if (h > 0) {
            
            timeStr = [NSString stringWithFormat:@"%lld小时%lld分",h , m];
        }
    }
    return timeStr;
}

+ (NSString *)DateFormatWithDate:(NSString *)date withFormat:(NSString *)format
{
    if(date.length == 0 || [date isEqual:[NSNull null]]){
        return @"";
    }
    //    NSArray *array = [date componentsSeparatedByString:@"+"];
    //    NSArray *dateArr = [array[0] componentsSeparatedByString:@"("];
    //
    //    NSString * timeStampString = dateArr[1];
    NSTimeInterval _interval=[date doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    [objDateformat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    return [NSString stringWithFormat:@"%@",[objDateformat stringFromDate:time]];
}

//计算当前日期
+ (NSDictionary *)getDateTime
{
    NSInteger year,hour,min,sec,month,day;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    year = [comps year];
    month = [comps month];
    day = [comps day];
    hour = [comps hour];
    min = [comps minute];
    sec = [comps second];
    
    
    NSString *dayStr = [NSString stringWithFormat:@"%02ld-%02ld-%02ld %02ld:%02ld:%02ld",(long)year,(long)month,(long)day,(long)hour,(long)min,(long)sec];
    NSDictionary *dic = @{@"year":[NSNumber numberWithInteger:year],@"month":[NSNumber numberWithInteger:month],@"day":[NSNumber numberWithInteger:day],@"hour":[NSNumber numberWithInteger:hour],@"min":[NSNumber numberWithInteger:min],@"sec":[NSNumber numberWithInteger:sec],@"sumtime":dayStr};
    
    return dic;
}
@end
