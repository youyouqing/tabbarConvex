//
//  XKMultifunctionCheckHomeCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMultifunctionCheckHomeCell.h"
@interface XKMultifunctionCheckHomeCell()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *iconIimg;

@property (weak, nonatomic) IBOutlet UILabel *titlLab;


@property (weak, nonatomic) IBOutlet UILabel *detailLab;


@end
@implementation XKMultifunctionCheckHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//-(void)setXKHouseHoldModel:(XKHouseHoldModel *)XKHouseHoldModel{
//    
//    _XKHouseHoldModel=XKHouseHoldModel;
//    
//    
//    self.titlLab.text=_XKHouseHoldModel.Name;
//    
//    [self.iconIimg sd_setImageWithURL:[NSURL URLWithString:_XKHouseHoldModel.DeviceTitleImg] placeholderImage:[UIImage imageNamed:@"pc300P"]];
//    
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
