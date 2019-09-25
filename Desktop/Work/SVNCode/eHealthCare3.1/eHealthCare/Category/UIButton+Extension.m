//
//  UIButton+Extension.m
//  eHealthCare
//
//  Created by John shi on 2018/8/8.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)SetTheArcButton
{
    self.layer.borderWidth = 0.3f;
    self.layer.cornerRadius = KHeight(45)/2.0;
    self.layer.borderColor = self.backgroundColor.CGColor;
    self.layer.masksToBounds = YES;
}

@end
