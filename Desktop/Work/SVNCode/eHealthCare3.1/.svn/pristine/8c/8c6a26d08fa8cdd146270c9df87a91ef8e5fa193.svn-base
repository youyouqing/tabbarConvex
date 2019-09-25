//
//  XKBackButton.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBackButton.h"

@implementation XKBackButton
+(UIButton *)backBtn:(NSString *)breathbackName;
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:breathbackName] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:breathbackName] forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    if ([breathbackName isEqualToString:@"icon_back_white"]) {
        btn.frame = CGRectMake(15, 35, 33, 33);
    }else
    btn.frame = CGRectMake(20, 35, 23, 23);
    
    return btn;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
