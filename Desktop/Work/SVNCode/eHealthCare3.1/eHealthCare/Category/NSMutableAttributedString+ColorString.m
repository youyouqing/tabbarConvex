//
//  NSMutableAttributedString+ColorString.m
//  eHealthCare
//
//  Created by jamkin on 16/9/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSMutableAttributedString+ColorString.h"

@implementation NSMutableAttributedString (ColorString)

+(instancetype)createColorString:(NSString *)dainamicStr withExcision:(NSString *)excisionStr dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor{
    
    NSString *str=dainamicStr;
    
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:excisionStr];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range1=[str rangeOfString:excisionStr];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range1];
    
    return attri;
    
}

+(instancetype) changeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo
{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeOne] range:range];
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo] range:range1];
    
    
    return attri;
}

+(instancetype) changeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor{
    
    NSString *str=needText;
        
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeOne] range:range];
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
    return attri;
    
}
+(instancetype) changeLabelWithText:(NSString*)needText withBigImpactFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallImpactFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont  fontWithName:@"Impact" size:sizeOne] range:range];
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Impact" size:sizeTwo] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
    return attri;
    
}
+(instancetype) changeLabelWithText:(NSString*)needText withBigBoldFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:sizeOne] range:range];
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
    return attri;
    
}
+(instancetype) changeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor widthAddLine:(NSString *)lineStr{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeOne] range:range];
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
     NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    [attri addAttributes:attribtDic range:[str rangeOfString:lineStr]];
    
    return attri;
    
}

+(instancetype)fontChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:needText attributes:@{NSKernAttributeName:@(0.6)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [needText length])];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeOne] range:range];//***要增加字体大小
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo weight:0.5] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
    return attri;
   
    
}
+(instancetype)boldChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt excisionColor:(UIColor *)exColor
{
    
    NSString *str=needText;
    
    const CGFloat fontSize = sizeOne;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    NSUInteger length = [str length];
    //设置字体
    UIFont *baseFont = [UIFont systemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[str rangeOfString:changeTxt]];//设置Text这四个字母的字体为粗体

    return attrString;
}

+(instancetype) unfontChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:needText attributes:@{NSKernAttributeName:@(0.6)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [needText length])];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeOne] range:range];//***要增加字体大小
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
    return attri;
    
    
}

+(instancetype) threeChangeLabelWithText:(NSString*)needText withBigFont:(CGFloat)sizeOne withNeedchangeText:(NSString *)changeTxt withSmallFont:(CGFloat)sizeTwo dainmaicColor:(UIColor *)dColor excisionColor:(UIColor *)exColor repayColor:(UIColor *)rColor rPayStr:(NSString *)rstr{
    
    NSString *str=needText;
    
    NSMutableAttributedString *attri=[[NSMutableAttributedString alloc]initWithString:str];
    
    NSArray *textArray=[str componentsSeparatedByString:changeTxt];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeOne] range:range];
        
    }
    NSRange range1=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:sizeTwo] range:range1];
    
    for (int i=0;i<textArray.count;i++) {
        
        NSRange range=[str rangeOfString:textArray[i]];
        
        [attri addAttribute:NSForegroundColorAttributeName value:dColor range:range];
        
    }
    NSRange range2=[str rangeOfString:changeTxt];
    
    [attri addAttribute:NSForegroundColorAttributeName value:exColor range:range2];
    
    NSRange range3=[str rangeOfString:rstr];
    
    [attri addAttribute:NSForegroundColorAttributeName value:rColor range:range3];
    
    return attri;
    
}

/**+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
 
 NSString *labelText = label.text;
 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 [paragraphStyle setLineSpacing:space];
 [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
 label.attributedText = attributedString;
 [label sizeToFit];
 
 }
 
 + (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
 
 NSString *labelText = label.text;
 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
 label.attributedText = attributedString;
 [label sizeToFit];
 
 }
 
 + (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
 
 NSString *labelText = label.text;
 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 [paragraphStyle setLineSpacing:lineSpace];
 [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
 label.attributedText = attributedString;
 [label sizeToFit];
 
 }**/

@end
