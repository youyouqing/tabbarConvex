//
//  NewTrendHomeCell.m
//  eHealthCare
//
//  Created by xiekang on 16/12/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewTrendHomeCell.h"

@implementation NewTrendHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(TrendNewModel *)model
{
    //    _iconImgV.backgroundColor = [UIColor clearColor];
    _titleLal.text = model.PhysicalItemName;
    if (model.TestCount > 0) {
        _textLal.text = @"已检测";
        _textLal.textColor = kMainColor;
        _iconImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_checked",model.iconImgStr]];
        _nextIconV.hidden = NO;
    }else{
        _textLal.text = @"未检测";
        _textLal.textColor = [UIColor grayColor];
        _iconImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nomal",model.iconImgStr]];
        _nextIconV.hidden = YES;
    }
    NSLog(@"model.iconImgStr%@",model.iconImgStr);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
