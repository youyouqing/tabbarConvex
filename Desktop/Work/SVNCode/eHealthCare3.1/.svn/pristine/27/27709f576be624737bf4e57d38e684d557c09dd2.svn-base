//
//  XKMedicalLookBigPhotoCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMedicalLookBigPhotoCell.h"

@interface XKMedicalLookBigPhotoCell ()




@end

@implementation XKMedicalLookBigPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(XKPatientPhotoModel *)model{
    
    _model = model;
    self.countLab.text = [NSString stringWithFormat:@"%li/%li",self.xkpage,self.counPage];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.PicUrl] placeholderImage:[UIImage imageNamed:@"Startpage"]];
    
}

@end
