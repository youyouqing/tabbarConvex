//
//  XKBloodFatChooseCell.m
//  eHealthCare
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本血脂选择视图表格cell 创建者：张波

#import "XKBloodFatChooseCell.h"

@interface XKBloodFatChooseCell()

/**选项标签*/
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/**是否选中图片*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@end

@implementation XKBloodFatChooseCell

/**重写数据源实体set方法*/
-(void)setModel:(XKPhySicalItemModel *)model{
    _model = model;
    self.nameLab.text = model.PhysicalItemName;
    if (_model.IsSelect) {
        self.iconImg.hidden = NO;
    }else{
        self.iconImg.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
