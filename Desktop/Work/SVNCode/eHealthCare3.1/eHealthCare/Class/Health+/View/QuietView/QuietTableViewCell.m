//
//  QuietTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/24.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "QuietTableViewCell.h"

@implementation QuietTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
