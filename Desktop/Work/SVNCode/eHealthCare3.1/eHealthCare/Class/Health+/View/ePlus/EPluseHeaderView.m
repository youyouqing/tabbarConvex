//
//  EPluseHeaderView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "EPluseHeaderView.h"

@implementation EPluseHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor getColor:@"eff2f5"];
    self.lienView.backgroundColor=[UIColor getColor:@"EBF0F4"];
    self.backgroundColor = kbackGroundGrayColor;
    
    self.titleLab.textColor=kMainTitleColor;
    
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 45) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    maskLayer.frame = corPath.bounds;
    maskLayer.path=corPath.CGPath;
    self.backView.layer.mask=maskLayer;
    
}


- (IBAction)clickHead:(id)sender {
    
//    if ([self.titleLab.text isEqualToString:@"健康资讯"]) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickMainAtIndex:title:index:)]) {
//            [self.delegate buttonClickEPluseHeaderViewAtIndex:@"" title:@"健康资讯" index:3];
//        }
//
//
//    }else
//        if ([self.titleLab.text isEqualToString:@"健康计划"]){

        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickEPluseHeaderViewAtIndex:title:index:)]) {
            [self.delegate buttonClickEPluseHeaderViewAtIndex:[NSString stringWithFormat:@"%@AppComm/BaikeIndex",kMainUrl] title:self.titleLab.text index:2];
//        }
        
    }
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray=dataArray;
}
-(void)setIsUserMemberIdPauseHiden:(BOOL)isUserMemberIdPauseHiden
{
    _isUserMemberIdPauseHiden = isUserMemberIdPauseHiden;
//    if (isUserMemberIdPauseHiden == YES) {
     self.arrowImg.hidden =   self.moreLab.hidden = isUserMemberIdPauseHiden;
//    }else
    
    
}
@end