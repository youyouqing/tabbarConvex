//
//  NSMutableAttributedString+ColorString.h
//  eHealthCare
//
//  Created by jamkin on 16/9/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (ColorString)

/**
 *传入一个字符串  转为一个变色的字符串
 *dainamicStr 元字符串
 *excisionStr 要截取的字符串
 *dainmaicColor 不变的颜色
 *exColor 要变的颜色
 **/
+(instancetype)createColorString:(NSString *)dainamicStr withExcision:(NSString *)excisionStr dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor;

+(instancetype) changeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo;

+(instancetype) changeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor;

+(instancetype) changeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor widthAddLine:(NSString *)lineStr;
+(instancetype) changeLabelWithText:(NSString*)needText withBigImpactFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallImpactFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor;
//加粗
+(instancetype)fontChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor;

//加粗大的字体。小的未加粗
+(instancetype) changeLabelWithText:(NSString*)needText withBigBoldFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor;
/**
 未加粗

 @param needText <#needText description#>
 @param sizeOne <#sizeOne description#>
 @param changeTxt <#changeTxt description#>
 @param sizeTwo <#sizeTwo description#>
 @param dColor <#dColor description#>
 @param threeChangeLabelWithText <#threeChangeLabelWithText description#>
 @param needText <#needText description#>
 @param sizeOne <#sizeOne description#>
 @param changeTxt <#changeTxt description#>
 @param sizeTwo <#sizeTwo description#>
 @param dColor <#dColor description#>
 @param exColor <#exColor description#>
 @param rColor <#rColor description#>
 @param rstr <#rstr description#>
 @return <#return value description#>
 */
+(instancetype) unfontChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor;
/**
 三个颜色两个字体
 */
+(instancetype) threeChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor repayColor:(UIColor *)rColor rPayStr:(NSString *)rstr;
+(instancetype)boldChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt excisionColor:(UIColor *)exColor;
@end
