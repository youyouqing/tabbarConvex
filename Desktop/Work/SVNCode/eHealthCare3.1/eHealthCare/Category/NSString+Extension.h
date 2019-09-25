//
//  NSString+Extension.h
//  eHealthCare
//
//  Created by John shi on 2018/7/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 截取指定字符串
 
 @param characString 需要被解决的字符串
 @param start 截取的起始位置
 @param end 截取的终点
 @return 处理之后的字符串
 */
+ (NSString *)loadCharcterView:(NSString *)characString startS:(NSString *)start endS:(NSString *)end;

///对字符串进行URL编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;


///对字符串进行URL解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

/**传入浮点型数据返回是否含所有小数点之后的数据**/
+(NSString *)formatterNum:(CGFloat)number;

/*根据身份证号获取生日*/
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;

/*根据身份证号性别*/
+(NSString *)sexFromIdentityCard:(NSString *)numberStr;

/*根据省份证号获取年龄*/
+(NSString *)ageFromIdentityCard:(NSString *)numberStr;

+ (NSString *) compareCurrentTime:(NSString *) strDate;
/**
 判断数据是否在这之间
 
 @param urlString <#urlString description#>
 @return <#return value description#>
 */
+(float)scaneInteger:(NSString *)urlString;
/**
 传入一个字符串验证是否含有特殊支付
 */
+(BOOL)JudgeTheillegalCharacter:(NSString *)content;

/**
 判断是否含有特殊字符
 */
+(BOOL)isIncludeSpecialCharact: (NSString *)str;


/**
 首个字符名
 */
- (NSString *)firstChar;

+ (BOOL)isPureInt:(float)string;
@end
