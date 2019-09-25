//
//  HealthRecordNoneDataCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordNoneDataCell.h"

@implementation HealthRecordNoneDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.goBtn.layer.cornerRadius=self.goBtn.frame.size.height/2.0;
    self.goBtn.layer.masksToBounds=YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 199)      byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft    cornerRadii:CGSizeMake(3, 3)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.backView.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.backView.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addComebuttonClick:)]) {
        [self.delegate addComebuttonClick:self.goBtn.titleLabel.text];
    }
    
}

@end
