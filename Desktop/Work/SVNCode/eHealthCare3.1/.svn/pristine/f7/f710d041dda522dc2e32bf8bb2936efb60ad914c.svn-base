//
//  HouseholdCheckHomeCell.m
//  PC300
//
//  Created by jamkin on 2017/4/18.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import "HouseholdCheckHomeCell.h"

@interface HouseholdCheckHomeCell()

@property (weak, nonatomic) IBOutlet UIView *containerV;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation HouseholdCheckHomeCell

-(void)setModel:(HouseholdModel *)model{
    
    _model=model;
    
//    self.iconImg.image=[UIImage imageNamed:_model.imgName];
    
    self.titleLab.text= model.markTitle;
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.imgName] placeholderImage:[UIImage imageNamed:@"moren"]];
}
-(void)setXKHouseHoldModel:(XKHouseHoldModel *)XKHouseHoldModel{
    
    _XKHouseHoldModel=XKHouseHoldModel;
    
    
    self.titleLab.text= XKHouseHoldModel.Name;
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_XKHouseHoldModel.DeviceTitleImg] placeholderImage:[UIImage imageNamed:@"moren"]];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor=[UIColor getColor:@"f2f2f2"];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
