//
//  MoodCollectionViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MoodCollectionViewCell.h"

@implementation MoodCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 75, (24)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.nameLab.layer.mask=maskTwoLayer;
    
}

@end
