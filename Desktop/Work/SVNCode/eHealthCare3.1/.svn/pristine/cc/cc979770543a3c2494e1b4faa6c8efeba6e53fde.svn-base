//
//  ProfileCell.m
//  eHealthCare
//
//  Created by jamkin on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ProfileCell.h"

@interface ProfileCell ()
{
    UIBezierPath *maskPathleft;
    UIBezierPath *maskPathRight;
    
    CAShapeLayer *maskLayer;
    CAShapeLayer *maskLayerright;

}
@property (weak, nonatomic) IBOutlet UIImageView *msgImg;

@property (weak, nonatomic) IBOutlet UILabel *remrkLab;

@end

@implementation ProfileCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    CGRect rect = CGRectMake(0, 0, KScreenWidth-12, 49);
    maskPathleft = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = rect;
    
    maskLayer.path = maskPathleft.CGPath;
    
   
    
    maskPathRight = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    
    maskLayerright = [[CAShapeLayer alloc] init];
    
    maskLayerright.frame = rect;
    
   
    maskLayerright.path = maskPathRight.CGPath;
    
    
    
}

-(void)setMessageDict:(NSDictionary *)messageDict{
    
    _messageDict=messageDict;
    
    self.msgImg.image=[UIImage imageNamed:_messageDict[@"img"]];
    
    self.remrkLab.text=_messageDict[@"remark"];
//    if ([_messageDict[@"viewTag"] isEqualToString:@"6"]) {
//        self.backgroundBottomView.layer.mask = maskLayer;
//    }
//    if ([_messageDict[@"viewTag"] isEqualToString:@"8"]) {
//
//        
//        self.backgroundBottomView.layer.mask = maskLayerright;
//    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
