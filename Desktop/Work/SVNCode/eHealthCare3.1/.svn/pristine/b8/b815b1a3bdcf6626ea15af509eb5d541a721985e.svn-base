//
//  LoginOutView.m
//  eHealthCare
//
//  Created by John shi on 2018/11/23.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "LoginOutView.h"

@implementation LoginOutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.msgLab.layer.cornerRadius = self.msgLab.frame.size.height/2.0;
    self.msgLab.layer.masksToBounds = YES;
    self.msgLab.layer.borderColor = [UIColor getColor:@"C3CEDD"].CGColor;
    self.msgLab.layer.borderWidth = 1;
}
- (IBAction)loginOutAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(LoginOutViewbuttonClick)]) {
        [self.delegate LoginOutViewbuttonClick];
    }
}

@end
