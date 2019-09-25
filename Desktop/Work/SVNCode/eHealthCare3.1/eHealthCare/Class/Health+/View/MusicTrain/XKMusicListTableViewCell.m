//
//  XKMusicListTableViewCell.m
//  eHealthCare
//
//  Created by xiekang on 2018/3/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XKMusicListTableViewCell.h"

@interface XKMusicListTableViewCell ()

@end

@implementation XKMusicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.firstBtn.layer.cornerRadius = 5;
    self.firstBtn.layer.masksToBounds = YES;
    self.plus_list_choose_img.hidden = YES;
//    self.plus_list_choose_img.layer.cornerRadius = 5;
//    self.plus_list_choose_img.layer.masksToBounds = YES;
    self.firstBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.firstBtn.imageView.clipsToBounds = YES;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.plus_list_choose_img.bounds      byRoundingCorners:UIRectCornerTopRight     cornerRadii:CGSizeMake(3, 3)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.plus_list_choose_img.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.plus_list_choose_img.layer.mask = maskLayer;
}
- (IBAction)exchangeAllView:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(listPrepare:)]) {
        [self.delegate listPrepare:self];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
