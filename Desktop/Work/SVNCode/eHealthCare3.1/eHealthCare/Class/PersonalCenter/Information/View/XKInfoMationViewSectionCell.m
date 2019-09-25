//
//  XKInfoMationViewSectionCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInfoMationViewSectionCell.h"


@interface XKInfoMationViewSectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

@end
@implementation XKInfoMationViewSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImage.layer.cornerRadius = 30*.5f;
    // 这样写比较消耗性能
    _iconImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
