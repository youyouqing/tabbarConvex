//
//  XKCheckHeaderCommonResultView.m
//  eHealthCare
//
//  Created by xiekang on 2017/11/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKCheckHeaderCommonResultView.h"
@interface XKCheckHeaderCommonResultView()

@property (weak, nonatomic) IBOutlet UIView *topCircleView;

@property (nonatomic, assign) NSInteger number;//移动5个点   再偏移


@property (nonatomic,strong)CAShapeLayer *shapeLayer;

@property (nonatomic,strong)CAShapeLayer *preLayer;

@property (weak, nonatomic) IBOutlet UILabel *scoreLab;

@property (weak, nonatomic) IBOutlet UIView *showView;

@property (weak, nonatomic) IBOutlet UIButton *scopebtn;
@end
@implementation XKCheckHeaderCommonResultView
{
    UIImageView* _endPoint;//检测位置过程中添加一个点
    BOOL is_rep;
    
    
    CALayer* imageLayer;//绘制波形图
    
    NSMutableArray *points;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.shapeLayer=[CAShapeLayer layer];
    
    self.shapeLayer.frame=CGRectMake(0, 0, 187, 187);
    
    UIBezierPath *path3=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 187, 187)];
    
    self.shapeLayer.fillColor=[[UIColor clearColor]CGColor];
    
    self.shapeLayer.strokeColor=[[UIColor whiteColor]CGColor];
    
    self.shapeLayer.lineWidth=2;
    
    self.shapeLayer.strokeStart=0.0;
    
    self.shapeLayer.strokeEnd=1.0;
    
    self.shapeLayer.path=path3.CGPath;
    
    [self.showView.layer addSublayer:self.shapeLayer];
    
    is_rep = YES;
    // [self detectingCourse];
    
    
    

    
}
-(void)setMode:(ExchinereportModel *)mode
{
    
    _mode = mode;
    
    self.BMILab.text = mode.Unit;
    
    [self.scopebtn setTitle:[NSString stringWithFormat:@"理想范围：%@",mode.ReferenceValue] forState:UIControlStateNormal];
    
    
    if (self.mode.ParameterStatus == 1) {
        self.scoreLab.text = @"偏高";
        
//        self.backgroundColor = [UIColor colorWithHexString:@"FF7342"];
        self.topCircleView.backgroundColor = [UIColor colorWithHexString:@"FF7342"];
        
    }
    if (self.mode.ParameterStatus == 2) {
        self.scoreLab.text = @"正常";
        self.topCircleView.backgroundColor = [UIColor colorWithHexString:@"25D352"];
    }
    
    if (self.mode.ParameterStatus == 3) {
        self.scoreLab.text = @"偏低";
        self.topCircleView.backgroundColor = [UIColor colorWithHexString:@"F3C331"];
    }
    
   
    
}
-(void)detectingCourse{
    
    //用于显示结束位置的小点
    _endPoint = [[UIImageView alloc] init];
    
    _endPoint.frame = CGRectMake((self.showView.bounds.size.width-187)/2.0+187-10, (self.showView.bounds.size.height-187)/2.0+187/2.0-10, 20,20);
    
    _endPoint.image = [UIImage imageNamed:@"morningAndNight_dot"];
    
    [self.showView addSubview:_endPoint];
    
    CAKeyframeAnimation *path=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //矩形的中心就是圆心
    CGRect rect=CGRectMake((self.showView.bounds.size.width-187)/2.0, (self.showView.bounds.size.height-187)/2.0, 187, 187);
    path.duration=1;
    //绕此圆中心转
    path.path=CFAutorelease(CGPathCreateWithEllipseInRect(rect, NULL));
    path.calculationMode=kCAAnimationPaced;
    path.rotationMode=kCAAnimationRotateAuto;
    path.repeatCount = 10000;
    //    pat
    [_endPoint.layer addAnimation:path forKey:@"round"];
    
}
/**
 转圈动画  开始停止
 */
- (void)TouchCircleAndHide {
    is_rep = !is_rep;
    if (is_rep) {
        [_endPoint removeFromSuperview];
    }else{
        [self detectingCourse];
    }
}
- (void)StopCircleAninmationAndHide;
{
    
    [_endPoint removeFromSuperview];

}
/**
 再来一次
 
 @param sender <#sender description#>
 */
- (IBAction)againAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(AgainCheckResult:)]) {
        [self.delegate AgainCheckResult:self];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
