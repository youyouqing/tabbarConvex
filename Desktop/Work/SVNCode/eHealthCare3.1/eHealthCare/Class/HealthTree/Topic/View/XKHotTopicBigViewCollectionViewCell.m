//
//  XKHotTopicBigViewCollectionViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/12/26.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "XKHotTopicBigViewCollectionViewCell.h"

@implementation XKHotTopicBigViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImg setContentScaleFactor:[[UIScreen mainScreen] scale]];
}
//-(void)setModel:(XKPatientPhotoModel *)model{
//    
//    _model = model;
//    self.countLab.text = [NSString stringWithFormat:@"%li/%li",self.xkpage,self.counPage];
//    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.PicUrl] placeholderImage:[UIImage imageNamed:@"Startpage"]];
//    
//}
@end
