//
//  HealthPlanRecordFooterView.m
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "HealthPlanRecordFooterView.h"

@implementation HealthPlanRecordFooterView

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
    self.backgroundColor = kbackGroundGrayColor;
    self.backView.layer.cornerRadius=3;
    self.backView.layer.masksToBounds=YES;
    self.backView.backgroundColor = [UIColor getColor:@"EEFBFE"];
    self.addBtn.layer.masksToBounds=YES;
    self.addBtn.layer.borderWidth = 0.5;
    self.addBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    self.addBtn.layer.cornerRadius=self.addBtn.frame.size.height/2.0;
    
}
- (IBAction)addAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthPlanRecordFooterViewbuttonClick)]) {
        [self.delegate HealthPlanRecordFooterViewbuttonClick];
    }

    
}
@end