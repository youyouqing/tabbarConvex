//
//  XKNewHomeInSectionHeadView.m
//  eHealthCare
//
//  Created by mac on 16/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKNewHomeInSectionHeadView.h"
@interface XKNewHomeInSectionHeadView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightCons;

@property (weak, nonatomic) IBOutlet UIView *backView;


@end


@implementation XKNewHomeInSectionHeadView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor getColor:@"eff2f5"];
    self.lienView.backgroundColor=[UIColor getColor:@"EAEAEA"];
     self.backgroundColor = [UIColor whiteColor];
    self.lineHeightCons.constant=0.5;
    
    self.titleLab.textColor=kMainTitleColor;
    
  
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
//    maskLayer.frame = corPath.bounds;
//    maskLayer.path=corPath.CGPath;
//    self.backView.layer.mask=maskLayer;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 45) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    maskLayer.frame = corPath.bounds;
    maskLayer.path=corPath.CGPath;
    self.backView.layer.mask=maskLayer;
}


- (IBAction)clickHead:(id)sender {
   
    if ([self.titleLab.text isEqualToString:@"健康资讯"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickMainAtIndex:title:index:)]) {
            [self.delegate buttonClickMainAtIndex:@"" title:@"健康资讯" index:3];
        }
        
        
    }else if([self.titleLab.text isEqualToString:@"健康百科"]){

        
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickMainAtIndex:title:index:)]) {
            [self.delegate buttonClickMainAtIndex:kHealthBaiKeUrl title:@"健康百科"index:2];
        }

        
    }else if ([self.titleLab.text isEqualToString:@"健康计划"]||[self.titleLab.text isEqualToString:@"我的健康计划"]){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickMainAtIndex:title:index:)]) {
            [self.delegate buttonClickMainAtIndex:kHealthPlanUrl title:@"健康计划" index:4];
        }
        
    }
    else if ([self.titleLab.text isEqualToString:@"热门话题"]){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickMainAtIndex:title:index:)]) {
            [self.delegate buttonClickMainAtIndex:[NSString stringWithFormat:@"%@AppComm/BaikeIndex",kMainUrl] title:@"热门话题" index:5];
        }
        
    }
    else if ([self.titleLab.text isEqualToString:@"健康自测"]){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickMainAtIndex:title:index:)]) {
            [self.delegate buttonClickMainAtIndex:kHealthTestPageUrl title:@"健康自测" index:6];
        }
        
    }
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray=dataArray;
}

@end