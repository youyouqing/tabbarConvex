//
//  SettingLoginOutCell.m
//  eHealthCare
//
//  Created by jamkin on 16/8/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SettingLoginOutCell.h"

@interface SettingLoginOutCell ()

@property (weak, nonatomic) IBOutlet UILabel *msgLab;

@end

@implementation SettingLoginOutCell

-(void)setMsg:(NSString *)msg{
    
    _msg=msg;
    
    self.msgLab.text=_msg;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.msgLab.layer.cornerRadius = self.msgLab.frame.size.height/2.0;
    self.msgLab.layer.masksToBounds = YES;
    self.msgLab.layer.borderColor = [UIColor getColor:@"C3CEDD"].CGColor;
    self.msgLab.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
