//
//  XKBindToolTableViewCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBindToolTableViewCell.h"


@interface XKBindToolTableViewCell ()

/**
 去绑定
 */
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

/**
 设备名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end



@implementation XKBindToolTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bindBtn.layer.cornerRadius = self.bindBtn.frame.size.height/2.0;
    
    
    self.bindBtn.clipsToBounds = YES;

}
- (IBAction)buyAction:(id)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(buyTools:)]) {
        [self.delegate buyTools:self];
    }
    
    
}
- (IBAction)bindAction:(id)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(bindView:)]) {
        [self.delegate bindView:self];
    }
    
}
-(void)setModel:(XKDeviceMod *)model
{
    _model = model;
    
    
    self.nameLab.text = model.ProductName;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.ImgUrl] placeholderImage:[UIImage imageNamed:@"moren"]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
