//
//  NSString+Extension.m
//  eHealthCare
//
//  Created by John shi on 2018/7/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)loadCharcterView:(NSString *)characString startS:(NSString *)start endS:(NSString *)end;
{
    NSString *string = characString;
    NSRange startRange = [string rangeOfString:start];
    
    NSRange endRange = [string rangeOfString:end];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    if (endRange.length <= 0) {
        return @"";
    }
    
    NSString *result = [string substringWithRange:range];
    return result;
}

#pragma mark 对字符串进行URL编码处理和解码
///对字符串进行URL编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr =
    
    (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                 
                                                                 NULL, /* allocator */
                                                                 
                                                                 (__bridge CFStringRef)input,
                                                                 
                                                                 NULL, /* charactersToLeaveUnescaped */
                                                                 
                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                 
                                                                 kCFStringEncodingUTF8);
    
    return outputStr;
    
}

///对字符串进行URL解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@""
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0,[outputStr length])];
    
    return
    
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

+(NSString *)formatterNum:(CGFloat)number{
    
    NSString *numString=[NSString stringWithFormat:@"%.1lf",number];
    
    NSArray *stringArray=[numString componentsSeparatedByString:@"."];
    
    NSString *string1=stringArray[0];
    
    NSString *string2=stringArray[1];
    
    return [string2 integerValue]==0?string1:numString;
    
}

//根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

//根据身份证号性别
+(NSString *)sexFromIdentityCard:(NSString *)numberStr
{
    int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    
    if(sexInt%2!=0)
    {
        return @"男";
    }
    else
    {
        return @"女";
    }
}

//根据省份证号获取年龄
+(NSString *)ageFromIdentityCard:(NSString *)numberStr
{
    
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayStrFromIdentityCard:numberStr]];
    
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    
    int age = trunc(dateDiff/(60*60*24))/365;
    
    return [NSString stringWithFormat:@"%d",-age];
}

+ (NSString *) compareCurrentTime:(NSString *) strDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    //yyyy-MM-dd HH:mm:ss
    
    NSDate *compareDate = [df dateFromString:strDate];
    
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return result;
}
+(float)scaneInteger:(NSString *)urlString{
    
    NSScanner *scanner = [NSScanner scannerWithString:urlString];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    float number;
    [scanner scanFloat:&number];
    return number;
    
    
}

/**
 传入一个字符串验证是否含有特殊支付
 */
+(BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //判断字符串是中文还是英文
    /*for (int i=0; i<self.groupNameTxt.text.length; i++) {
     NSRange range=NSMakeRange(i,1);
     NSString *subString=[self.groupNameTxt.text substringWithRange:range];
     const char *cString=[subString UTF8String];
     if (strlen(cString)==3)
     {
     NSLog(@"昵称是汉字");
     
     [IanAlert alertError:@"分组名称长度不能大于10"];
     
     return;
     
     }else if(strlen(cString)==1)
     {
     NSLog(@"昵称是字母");
     
     [IanAlert alertError:@"分组名称长度不能大于20"];
     
     return;
     
     }
     }*/
    
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

+(BOOL)isIncludeSpecialCharact: (NSString *)str{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
- (NSString *)firstChar
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%@", [self substringToIndex:1]]];
//    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}
//判断是否为整形：
+ (BOOL)isPureInt:(float)string{
    return (int)string - string == 0;
    
}
@end

