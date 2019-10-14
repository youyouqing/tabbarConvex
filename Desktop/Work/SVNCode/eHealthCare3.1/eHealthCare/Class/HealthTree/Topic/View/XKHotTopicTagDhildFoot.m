//
//  XKHotTopicTagDhildFoot.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKHotTopicTagDhildFoot.h"

@interface XKHotTopicTagDhildFoot ()

/**
 确定按钮视图
 */
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@end

@implementation XKHotTopicTagDhildFoot

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.sureBtn.backgroundColor = kMainColor ;
    self.sureBtn.layer.cornerRadius = 22.5;
    self.sureBtn.layer.masksToBounds = YES;
}

- (IBAction)sureAction:(id)sender {
    NSLog(@"确定选中标签");
    
    if ([self.delegate respondsToSelector:@selector(sureSendMsg)]) {
        [self.delegate sureSendMsg];
    }
    
}

@end