//
//  XKGoSportRemindView.m
//  eHealthCare
//
//  Created by John shi on 2018/11/20.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "XKGoSportRemindView.h"
#import "SportViewController.h"
@implementation XKGoSportRemindView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.sureBtn.layer.masksToBounds=YES;
//    self.borderBtn.layer.borderWidth = 0.5;
//    self.borderBtn.layer.borderColor = kMainColor.CGColor;
    self.sureBtn.layer.cornerRadius=self.sureBtn.frame.size.height/2.0;
    
}
- (IBAction)gpSportAction:(id)sender {
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(GoSportRemindbuttonClick)]) {
//        [self.delegate GoSportRemindbuttonClick];
//    }
    [self removeFromSuperview];
    
    UIViewController *nav = [self currentViewController];
 
    
    SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];

    sport.hidesBottomBarWhenPushed = YES;

    [nav.navigationController pushViewController:sport animated:YES];
}

- (IBAction)closeAction:(id)sender {
    
    [self removeFromSuperview];
}

@end
