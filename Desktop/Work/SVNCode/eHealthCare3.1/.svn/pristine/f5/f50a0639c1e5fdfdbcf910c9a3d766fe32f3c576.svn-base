//
//  MedicCollectionViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MedicCollectionViewCell.h"
#import <UIButton+WebCache.h>
@implementation MedicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.backgroundColor = [UIColor whiteColor];//getColor:@"edf8ff"
}
-(void)setWikiEncyTypeListModel:(WikiEncyTypeList *)WikiEncyTypeListModel
{
    
    _WikiEncyTypeListModel = WikiEncyTypeListModel;
     [self.btnImage sd_setImageWithURL:[NSURL URLWithString:WikiEncyTypeListModel.ImgUrl] placeholderImage:[UIImage imageNamed:@""]];
//     [self.btnImage sd_setImageWithURL:[NSURL URLWithString:WikiEncyTypeListModel.ImgUrl] forState:UIControlStateNormal];
    
}
@end
