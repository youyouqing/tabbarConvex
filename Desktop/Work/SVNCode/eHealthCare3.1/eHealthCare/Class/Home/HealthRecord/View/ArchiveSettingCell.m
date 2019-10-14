//
//  ArchiveSettingCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "ArchiveSettingCell.h"

@implementation ArchiveSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = kbackGroundGrayColor;
    self.backView.layer.cornerRadius=3;
    self.backView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleteAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteFamilybuttonClick:)]) {
        [self.delegate deleteFamilybuttonClick:self.famMod];
    }
    
}
-(void)setFamMod:(FamilyObject *)famMod
{
    
    _famMod = famMod;
    self.titleLab.text = famMod.FamilyName;
    
}
@end