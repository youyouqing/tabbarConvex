//
//  HealthRecordNoDataFooterView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/19.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordNoDataFooterView.h"

@implementation HealthRecordNoDataFooterView
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.goBtn.layer.cornerRadius=self.goBtn.frame.size.height/2.0;
    self.goBtn.layer.masksToBounds=YES;
    
    //228 199
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 228)      byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft    cornerRadii:CGSizeMake(3, 3)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.backView.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.backView.layer.mask = maskLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)Action:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ComebuttonClick:)]) {
        [self.delegate ComebuttonClick:self.goBtn.titleLabel.text];
    }
    
}

@end
