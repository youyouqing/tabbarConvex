//
//  MineContactCell.m
//  eHealthCare
//
//  Created by xiekang on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MineContactCell.h"

@implementation MineContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textLal.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
