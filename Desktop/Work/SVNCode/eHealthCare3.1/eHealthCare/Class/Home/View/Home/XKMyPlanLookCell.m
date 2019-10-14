//
//  XKMyPlanLookCell.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMyPlanLookCell.h"

@interface XKMyPlanLookCell ()

@property (weak, nonatomic) IBOutlet UIImageView *circleOneImage;
@property (weak, nonatomic) IBOutlet UIImageView *BGMimgaeView;

@property (assign, nonatomic)CGFloat progress;
@property (weak, nonatomic) IBOutlet UIImageView *circleTwoImage;

@end

@implementation XKMyPlanLookCell
- (void)drawCircle {
    //创建一个layer并添加到self.layer上面去
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.circleTwoImage.bounds;
    [self.circleTwoImage.layer addSublayer:layer];
    //创建一个圆
    CGFloat width = CGRectGetWidth(self.circleTwoImage.bounds);
    CGFloat height = CGRectGetHeight(self.circleTwoImage.bounds);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:0 endAngle:2* M_PI clockwise:YES];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor getColor:@"EEF1F6"].CGColor;
    layer.lineWidth = 10;
    layer.lineCap = kCALineCapRound;
    

}
- (void)updateProgressCircle:(CGFloat)progress{
    //update progress value
    self.progress = progress/100.0;
    //redraw back & progress circles
    //    [self setNeedsDisplay];
    NSLog(@"progress----%f",progress);
    [self drawColorLayer];
    //增加动画
    
}
//设置整个view渐变色
- (void)drawColorLayer {
    if (self.layerCirCle) {
        [self.layerCirCle removeFromSuperlayer];
    }
    self.layerCirCle = [CAShapeLayer layer];

    self.layerCirCle.frame = self.circleTwoImage.bounds;
    [self.circleTwoImage.layer addSublayer:self.layerCirCle];
    
    self.layerCirCle.frame = self.circleTwoImage.bounds;
    self.layerCirCle.lineWidth = 10;
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.circleTwoImage.bounds.size.width / 2,self.circleTwoImage.bounds.size.height / 2)
                                                                  radius:65/2
                                                              startAngle:(CGFloat) - M_PI_2
                                                                endAngle:(CGFloat)((- M_PI_2 + (2 * M_PI)))
                                                               clockwise:YES];
    
    
    self.layerCirCle.path = progressCircle.CGPath;
    self.layerCirCle.fillColor = [UIColor clearColor].CGColor;
    self.layerCirCle.strokeColor = kMainColor.CGColor;
    self.layerCirCle.lineCap = kCALineCapButt;
    
    self.layerCirCle.strokeEnd = self.progress;
    
//    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 2;
//    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue=[NSNumber numberWithFloat:self.progress];
//    pathAnimation.autoreverses=NO;
//    
//    pathAnimation.fillMode = kCAFillModeForwards;
//    pathAnimation.removedOnCompletion = YES;
//    pathAnimation.repeatCount = 1;
//    [self.layerCirCle addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
- (void)awakeFromNib {
    [super awakeFromNib];
     [self drawCircle];
    
    self.joinBtn.layer.cornerRadius = self.joinBtn.height/2;
    self.joinBtn.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.borderWidth = 0.5f;
    self.bgView.layer.borderColor = [UIColor getColor:@"e5e5e5"].CGColor;
    self.bgView.clipsToBounds = YES;

    
    self.iconImage.clipsToBounds = YES;
    
    self.iconImage.layer.cornerRadius = self.iconImage.height/2.0;
    
    
    self.circleOneImage.clipsToBounds = YES;
    
    self.circleOneImage.layer.cornerRadius = self.circleOneImage.height/2.0;
    
    self.circleTwoImage.clipsToBounds = YES;
    
    self.circleTwoImage.layer.cornerRadius = self.circleTwoImage.height/2.0;
    
    
    
    
    if (IS_IPHONE5||IS_IPHONE4S) {
        self.planProtectLab.font = [UIFont boldSystemFontOfSize:15.f];
        
        self.planNumberLab.font  = [UIFont systemFontOfSize:11.f];
    }
    
    

    
    

    
}
-(void)setPlanModel:(XKHomePlanModel *)planModel
{
   
    _planModel = planModel;
    
    self.planProtectLab.text = planModel.PlanTitle;
    if (planModel.PlanBGM.length>0) {
        [self.BGMimgaeView sd_setImageWithURL:[NSURL URLWithString:planModel.PlanBGM] placeholderImage:[UIImage imageNamed:@"bg_yinshijihua"]];

    }
     [self.iconImage sd_setImageWithURL:[NSURL URLWithString:planModel.PlanLogo] placeholderImage:[UIImage imageNamed:@"iv_yinshi"]];
    if (planModel.isMiddle == YES) {
        self.topbackViewCons.constant = self.bottomBackViewCons.constant = 12;

    }else
          self.topbackViewCons.constant = self.bottomBackViewCons.constant = 3;
    
    if (planModel.IsCurrentComplete == 1) {
        [self.joinBtn setTitle:@"去查看" forState:UIControlStateNormal];
    }else if (planModel.IsCurrentComplete == 0)
        [self.joinBtn setTitle:@"去完成" forState:UIControlStateNormal];
    [self updateProgressCircle:planModel.PlanCompletePercent];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)joinAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XKMyPlanLookCellJoinAction:)]) {
        
        [self.delegate XKMyPlanLookCellJoinAction:self.planModel];
    }
    
    
}



@end