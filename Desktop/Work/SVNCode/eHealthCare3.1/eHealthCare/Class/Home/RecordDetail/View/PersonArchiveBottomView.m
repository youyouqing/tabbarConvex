//
//  PersonArchiveBottomView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PersonArchiveBottomView.h"
@interface PersonArchiveBottomView()
@property (weak, nonatomic) IBOutlet UIButton *haveAccountBtn;
@property (weak, nonatomic) IBOutlet UIButton *noneAccountBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation PersonArchiveBottomView
-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    self.haveAccountBtn.layer.cornerRadius = 5;
    self.haveAccountBtn.clipsToBounds = YES;
    self.haveAccountBtn.layer.borderColor = [UIColor getColor:@"DCE4EA"].CGColor;
    self.haveAccountBtn.layer.borderWidth = 1.f;
    
    self.noneAccountBtn.layer.cornerRadius = 5;
    self.noneAccountBtn.clipsToBounds = YES;
    self.noneAccountBtn.layer.borderColor = [UIColor getColor:@"DCE4EA"].CGColor;
    self.noneAccountBtn.layer.borderWidth = 1.f;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth, 185)      byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight   cornerRadii:CGSizeMake(3, 3)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bottomView.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.bottomView.layer.mask = maskLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)AccountbtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(ArchiveBottomViewSelectClick:)]) {
        [self.delegate ArchiveBottomViewSelectClick:btn.tag-111];
    }

}

@end