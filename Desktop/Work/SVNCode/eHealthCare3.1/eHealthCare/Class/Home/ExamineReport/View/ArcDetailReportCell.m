//
//  ArcDetailReportCell.m
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArcDetailReportCell.h"

@implementation ArcDetailReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (IS_IPHONE5) {
        _textLal.font = [UIFont systemFontOfSize:15];
        _titleLal.font = [UIFont systemFontOfSize:15];
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
