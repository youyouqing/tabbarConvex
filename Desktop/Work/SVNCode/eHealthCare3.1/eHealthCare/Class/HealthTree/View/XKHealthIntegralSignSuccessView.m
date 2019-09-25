//
//  XKHealthIntegralSignSuccessView.m
//  eHealthCare
//
//  Created by mac on 2017/10/31.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本签到成功视图

#import "XKHealthIntegralSignSuccessView.h"

@interface XKHealthIntegralSignSuccessView()

@end

@implementation XKHealthIntegralSignSuccessView
/**
 加载xib方法
 */
-(void)awakeFromNib{
    [super awakeFromNib];
}

/**继续按钮的点击事件*/
- (IBAction)clickContinue:(id)sender {
    [self removeFromSuperview];
}

/**去逛逛按钮的点击事件*/
- (IBAction)clickBrowse:(id)sender {
    NSLog(@"去逛逛");
    
    if ([self.delegate respondsToSelector:@selector(clickToMall)]) {
        [self.delegate clickToMall];
    }
    
    [self removeFromSuperview];
    
}

@end
