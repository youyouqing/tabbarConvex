//
//  SettringArrowCell.m
//  eHealthCare
//
//  Created by jamkin on 16/8/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SettringArrowCell.h"

@interface SettringArrowCell ()

@property (weak, nonatomic) IBOutlet UILabel *msgLab;

@end

@implementation SettringArrowCell

-(void)setMsg:(NSString *)msg{
    
    _msg=msg;
    
    self.msgLab.text=_msg;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lineView.backgroundColor=COLOR(221, 230, 235, 1);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
