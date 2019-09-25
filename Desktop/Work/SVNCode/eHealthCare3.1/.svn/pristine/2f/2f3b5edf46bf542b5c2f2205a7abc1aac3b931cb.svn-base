//
//  RippleView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/25.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//
#import "RippleView.h"
@implementation RippleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.raderColor = kMainColor;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    self.alpha = 0.5;
    self.raderColor = kMainColor;
    for (int i = 0; i < 10; i++) {
        [self addAnimationDelay:i rect:rect];
    }
    
}
//画雷达圆圈图
-(void)addAnimationDelay:(int)time rect:(CGRect )rect
{
    CGPoint centerPoint = CGPointMake(self.bounds.size.height / 2, self.bounds.size.width / 2);
    //使用贝塞尔画圆
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:10 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.opacity = 0.5;
    shapeLayer.strokeColor = kMainColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    //雷达圈圈大小的动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"path";
    CGPoint center = CGPointMake(self.bounds.size.height / 2, self.bounds.size.width / 2);
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:KWidth(30) startAngle:0 endAngle:2 * M_PI clockwise:YES];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:KWidth(130) startAngle:0 endAngle:2 * M_PI clockwise:YES];
    basicAnimation.fromValue = (__bridge id _Nullable)(path1.CGPath);
    basicAnimation.toValue = (__bridge id _Nullable)(path2.CGPath);
    basicAnimation.fillMode = kCAFillModeForwards;
    
    
    //雷达圈圈的透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    
    opacityAnimation.fromValue = @(0.3);
    opacityAnimation.toValue = @(0);
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicAnimation,opacityAnimation];
    
    //动画间隔时间  这里的值和创建的动画个数需要计算好，避免最后一轮动画结束了，第一个动画好没有结束，出现效果差
    group.duration = 5;
    //动画开始时间
    group.beginTime = CACurrentMediaTime() + (double)time/2;
    
    //循环次数最大（无尽）  HUGE
    group.repeatCount = HUGE;
    
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //指定的时间段完成后,动画就自动的从层上移除
    group.removedOnCompletion = YES;
    //添加动画到layer
    [shapeLayer addAnimation:group forKey:nil];
    
}
@end
