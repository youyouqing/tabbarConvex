//
//  UIBarButtonItem+Item.m
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2013年 JunnpyStrong. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

#pragma mark 创建导航按钮
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    
    
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage ButtonItemTwoWithImage:(UIImage *)twoimage highImage:(UIImage *)twohighImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents twotarget:(id)twotarget twoaction:(SEL)twoaction fortwoControlEvents:(UIControlEvents)twocontrolEvents
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [closeBtn setBackgroundImage:twoimage forState:UIControlStateNormal];
    
    [closeBtn setBackgroundImage:twohighImage forState:UIControlStateHighlighted];
    
    [closeBtn sizeToFit];
    
    [closeBtn addTarget:twotarget action:twoaction forControlEvents:twocontrolEvents];
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 151, 32)];
    
    [leftView addSubview:btn];
    
    [leftView addSubview:closeBtn];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
}
@end