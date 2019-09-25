//
//  UILabel+Extension.m
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/**
 设置固定行间距文本
 */
-(void)setLineSpace:(CGFloat)lineSpace withText:(NSString*)text
{
    if (!text || lineSpace < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

@end
