//
//  Dateformat.m
//  test
//
//  Created by RuanZhenJie on 10/10/15.
//  Copyright (c) 2015年 xie. All rights reserved.
//

#import "Dateformat.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Dateformat

-(NSString *)DateFormatWithDate:(NSString *)date withFormat:(NSString *)format
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

//date 是日期  两个字符串格式必须一致
-(NSString *)timeSpWithDate:(NSString *)date withFormat:(NSString *)format
{
    if(date.length == 0 || [date isEqual:[NSNull null]]){
        return @"";
    }
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:format];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter1 setTimeZone:timeZone];
    NSDate *beginDate = [formatter1 dateFromString:date];
    NSString *beginsp = [NSString stringWithFormat:@"%.0f", [beginDate timeIntervalSince1970]*1000];
    
    return beginsp;
    
}

/**
 1992-11-12转位为时间戳

 @return
 */
-(NSString *)timeConvertSp:(NSString *)dateSp{

    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * now = [dateformatter dateFromString:dateSp];
    //转成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[now timeIntervalSince1970]];
    timeSp = [NSString stringWithFormat:@"%@000",timeSp];
    NSLog(@"转位为时间戳= %@",timeSp);
    return timeSp;
}
/**
 1992-11-12 -----hh-mm-ss 转位为时间戳
 
 @return
 */
-(NSString *)AlltimeConvertSp:(NSString *)dateSp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:dateSp]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
   
     NSString *timeSp = [NSString stringWithFormat:@"%d", (long)[date timeIntervalSince1970]];
    
//    NSInteger timeSpint = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
//    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSpint); //时间戳的值
    
    
//     NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)timeSpint];
  
    

    NSLog(@"转位为时间戳= %@",timeSp);
    return timeSp;
}
/**
 时间戳转为1992-11-12
 
 @return
 */
-(NSString *)SptimeConvertDate:(NSString *)date
{
    double dateD = [date doubleValue];
    if (date.length>=12) {
       dateD =  dateD/1000;
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateD];
    NSLog(@"1296035591  = %@",date);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    return confromTimespStr;
}

//计算当前日期
-(NSDictionary *)getDateTime
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
//返回签名的拼接参数字符串 -- 未加密
+(NSString *)getSignMd5WithDic:(NSDictionary *)params andParameterArr:(NSArray *)parameterNameArr
{
    NSMutableString *signStr = [[NSMutableString alloc]init];
    for (int i = 0; i < parameterNameArr.count; i++) {
        NSString *s = [params objectForKey:parameterNameArr[i]];
        [signStr appendString:s];
        if (i == parameterNameArr.count - 1) {
            [signStr appendString:@"9ol.)P:?3edc$RFV5tgb"];
        }else{
            [signStr appendString:@"|"];
        }
    }
    
    return signStr;
}
#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    
    
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    
    
    
    NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeSp;
    
}


+(NSString *)DateFormatWithMd5:(NSString *)inputStr
{
    const char *cStr = [inputStr UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr,strlen(cStr),digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (NSInteger i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}
//字符串进行MD5加密大写
+(NSString *)md532BitUpper:(NSString *)str
{
    const char *cstr = [str UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cstr)];
    CC_MD5(cstr, [num intValue], result);
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (NSString *)DateFromDatePicker:(id)picker withDateFormat:(NSString *)format
{
    UIDatePicker *datePicker = picker;
    NSDate *date = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
}
//身份证隐藏几位数，如:34882289030*****   或电话号码：1593930****
+(NSString *)hideCharacterWith:(NSString *)str andBeginNum:(NSInteger)beginNum andEndNum:(NSInteger)endNum
{
    if (beginNum + endNum > str.length) {
        return str;
    }
    NSInteger len = str.length - beginNum - endNum;
    NSMutableString *newStr = [NSMutableString stringWithString:str];
    NSMutableString *replaceStr = [[NSMutableString alloc]init];
    for (int i = 0; i < len; i++) {
        [replaceStr appendString:@"*"];
    }
    [newStr replaceCharactersInRange:NSMakeRange(beginNum, len) withString:replaceStr];
//    NSLog(@"%li -- %@",str.length, replaceStr);
    return newStr;
}

#pragma mark - UIImage变灰方法
+(UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
//    if (minutes <= 10) {
//        return  @"刚刚";
//    }else if (minutes < 60){
//        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
//    }else if (hours < 24){
//        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
//    }else if (day < 30){
//        return [NSString stringWithFormat: @"%ld天前",(long)day];
//    }else if (month < 12){
//        NSDateFormatter * df =[[NSDateFormatter alloc]init];
//        df.dateFormat = @"M月d日";
//        NSString * time = [df stringFromDate:lastDate];
//        return time;
//    }else if (yers >= 1){
//        NSDateFormatter * df =[[NSDateFormatter alloc]init];
//        df.dateFormat = @"yyyy年M月d日";
//        NSString * time = [df stringFromDate:lastDate];
//        return time;
//    }
//    return @"";
    
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"今天"];//[NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 2){
        return [NSString stringWithFormat: @"昨天"];
    }else {
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour {
    
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"dateFrom=%@---dateTo=%@---currentDate=%@",dateFrom,dateTo,currentDate);
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending) {
        // 当前时间在9点和10点之间
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour {
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
    
}
@end