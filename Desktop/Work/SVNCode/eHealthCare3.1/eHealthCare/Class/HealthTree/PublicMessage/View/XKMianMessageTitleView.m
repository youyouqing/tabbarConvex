//
//  XKMianMessageTitleView.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMianMessageTitleView.h"

@interface XKMianMessageTitleView ()



@end

@implementation XKMianMessageTitleView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self.tagSege setTitle:@"资讯" forSegmentAtIndex:0];
    
    self.layer.cornerRadius = 5;
    
    self.layer.masksToBounds = YES;
    
    self.tagSege.layer.cornerRadius = 5;
    
    self.tagSege.layer.masksToBounds = YES;
    
    self.tagSege.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tagSege.layer.borderWidth = .5f;
    self.tagSege.backgroundColor = kMainColor;
    self.tagSege.tintColor = [UIColor whiteColor];
    
    self.tagSege.selectedSegmentIndex = 0;
    
}

- (IBAction)segeAction:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"咨询");
    }else{
        NSLog(@"社区");
    }
    if ([self.delegate respondsToSelector:@selector(clickBtn:)]) {
        [self.delegate clickBtn:sender.selectedSegmentIndex];
    }
}

@end
