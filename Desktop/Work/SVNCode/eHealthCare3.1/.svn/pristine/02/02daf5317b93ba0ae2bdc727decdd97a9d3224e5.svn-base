//
//  XKWeatherScene.m
//  eHealthCare
//
//  Created by xiekang on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XKWeatherScene.h"

#define X(x) ((float)x/1080)*[UIScreen mainScreen].bounds.size.width

#define Y(y) (float)y/1920*[UIScreen mainScreen].bounds.size.height

@implementation XKWeatherScene

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initEmitterWithFrame:(CGRect)frame  type:(NSInteger)type imageName:(NSString *)imageName{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.image = [UIImage imageNamed:imageName];
        if (type == 111) {
             [self.layer addAnimation:[self opacityForever_Animation:1] forKey:nil];
        }
        else if(type == 222)
             [self.layer addAnimation:[self moveX:1.0f X:[NSNumber numberWithFloat:KScreenWidth + 300]] forKey:nil];//[self.layer addAnimation:animaGroup forKey:@"Animation"];
         else if(type == 300)
             [self animateFloat:@"shootingstarOne" floatImagetwo:@"shootingstarTwo" bgImage:self rotate:NO];//标记是否需要旋转
         else if(type == 301)
             [self cloudFloatRotateMovePostionAndOcaptiyBgImage:self];
        else
            [self animateFloat:@"叶子" floatImagetwo:@"叶子2" bgImage:self rotate:YES];
        
        
    }
    return self;
}

 //围绕X咒旋转角度
-(void)cloudFloatRotateMovePostionAndOcaptiyBgImage:(UIImageView *)image
{
    
    //树叶效果（用CALayer创建枫叶）
    CALayer *leafLayer = [CALayer layer];
    leafLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"光"].CGImage);
    leafLayer.bounds = CGRectMake(0, 0, 218, 250);
    leafLayer.position = CGPointMake(KWidth(131) + 44 , KHeight(463) + 125);
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
   //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
   animation.fromValue = [NSNumber numberWithFloat: 0];
   animation.toValue = [NSNumber numberWithFloat:-M_PI_4/1.5];
//   animation.duration = 10;
   animation.autoreverses = NO;
   animation.fillMode = kCAFillModeForwards;
   animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
//   [leafLayer addAnimation:animation forKey:nil];
//
//   [image.layer addSublayer:leafLayer];
    
    
    CABasicAnimation *animationOcaptiy = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animationOcaptiy.fromValue = [NSNumber numberWithFloat:1.0f];
    animationOcaptiy.toValue = [NSNumber numberWithFloat:0.1f];//这是透明度。
    animationOcaptiy.autoreverses = YES;
    //     animationOcaptiy.duration = 10;
    animationOcaptiy.fillMode = kCAFillModeForwards;
    animationOcaptiy.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    //    [leafLayer addAnimation:animationOcaptiy forKey:nil];
   
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 8.f;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.animations = @[animation,animationOcaptiy];
    animaGroup.repeatCount = MAXFLOAT;
    //    [leafLayer addAnimation:animaGroup forKey:@"Animation"];
    [image.layer addSublayer:leafLayer];
    [leafLayer addAnimation:animaGroup forKey:nil];
}


#pragma mark =====横向、纵向移动===========
-(CAAnimationGroup *)moveX:(float)time X:(NSNumber *)x

{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];///.y的话就向下移动。

    animation.toValue = x;

//    animation.duration = 8;

//    animation.removedOnCompletion = NO;//yes的话，又返回原位置了。

//    animation.repeatCount = MAXFLOAT;

    animation.fillMode = kCAFillModeForwards;
    
    
    
    
    CABasicAnimation *animationOcaptiy = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    
    animationOcaptiy.fromValue = [NSNumber numberWithFloat:0.75f];
    
    animationOcaptiy.toValue = [NSNumber numberWithFloat:1.0f];//这是透明度。
    
    animationOcaptiy.autoreverses = YES;
    
//    animationOcaptiy.duration = 8;
//    
//    animationOcaptiy.repeatCount = MAXFLOAT;
//    
//    animationOcaptiy.removedOnCompletion = NO;
    
    animationOcaptiy.fillMode = kCAFillModeForwards;
    
    animationOcaptiy.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 10.f;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.animations = @[animation,animationOcaptiy];
    animaGroup.repeatCount = MAXFLOAT;
//    [self.layer addAnimation:animaGroup forKey:@"Animation"];
    return animaGroup;
    
}
#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time;
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    
    animation.toValue = [NSNumber numberWithFloat:0.85f];//这是透明度。
    
    animation.autoreverses = YES;
    
    animation.duration = time;
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    
    return animation;
    
}
-(void)animateFloat:(NSString *)imageName floatImagetwo:(NSString *)imageTwoName bgImage:(UIImageView *)image  rotate:(BOOL)rotate;
{
    
    //树叶效果（用CALayer创建枫叶）
    CALayer *leafLayer = [CALayer layer];
    leafLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:imageName].CGImage);
    leafLayer.bounds = CGRectMake(0, 0, 40, 40);
    leafLayer.position = CGPointMake( image.frame.size.width, image.frame.size.height/2);
    
    
    //树叶效果（用CALayer创建枫叶）
    CALayer *leafLayer2 = [CALayer layer];
    leafLayer2.contents = (__bridge id _Nullable)([UIImage imageNamed:imageTwoName].CGImage);
    leafLayer2.bounds = CGRectMake(0, 0, 26.5, 21.5);//53   43
    leafLayer2.position = CGPointMake( image.frame.size.width+25, image.frame.size.height/2-38);
    if (rotate) {
         leafLayer2.bounds = CGRectMake(0, 0, 26.5, 21.5);
    }
    else
    {
         leafLayer.position = CGPointMake( image.frame.size.width, -15);
         leafLayer2.bounds = CGRectMake(0, 0, 27.5*2.5, 27.5*2.5);
         leafLayer.bounds = CGRectMake(0, 0, 50, 50);
         leafLayer2.position = CGPointMake( image.frame.size.width, -38);
    }
    
    [image.layer addSublayer:leafLayer];
    [image.layer addSublayer:leafLayer2];
    //添加路径
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *p1 = [NSValue valueWithCGPoint:leafLayer.position];
    NSValue *p2 = [NSValue valueWithCGPoint:CGPointMake(0, KHeight(139))];

    
    
    CAKeyframeAnimation *keyAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *p11 = [NSValue valueWithCGPoint:leafLayer2.position];
    NSValue *p22 = [NSValue valueWithCGPoint:CGPointMake(0, (int)image.frame.size.height/2)];
    if (rotate) {
        p2 = [NSValue valueWithCGPoint:CGPointMake(150, (int)image.frame.size.height/2 + Y(1100))];
        p22 = [NSValue valueWithCGPoint:CGPointMake(60, (int)image.frame.size.height/2 + Y(1050))];
    }
    else
    {
        

        p2 = [NSValue valueWithCGPoint:CGPointMake(-60, (int)image.frame.size.height/2 + Y(100))];
        p22 = [NSValue valueWithCGPoint:CGPointMake(-50, (int)image.frame.size.height/2 + Y(50))];
    }
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.values = @[p1, p2];
    keyAnimation2.values = @[p11, p22];
    CABasicAnimation *roateAnimation = nil;
    CABasicAnimation *roateAnimation2 = nil;
    if (rotate) {
        //设置旋转动画
        roateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        roateAnimation.fromValue = @0;
        roateAnimation.toValue = @(2);
        
        roateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        roateAnimation2.fromValue = @0;
        roateAnimation2.toValue = @(3);
    }
    roateAnimation.removedOnCompletion = NO;
    //动画组（播放旋转动画和路径）
    CAAnimationGroup  *group = [CAAnimationGroup animation];
      if (rotate) {
          group.animations = @[roateAnimation, keyAnimation];
          group.duration = 8;
      }
      else
      {
          group.duration = 4;
          group.animations = @[keyAnimation];
      }
    
     group.removedOnCompletion = NO;
    group.repeatCount = MAXFLOAT;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [group setValue:leafLayer forKey:@"leafLayer"];
    [leafLayer addAnimation:group forKey:nil];
    
    
    CAAnimationGroup  *group2 = [CAAnimationGroup animation];
    if (rotate) {
        group2.animations = @[roateAnimation2, keyAnimation2];
         group2.duration = 7;
    }
    else
    {
         group2.animations = @[keyAnimation2];
         group2.duration = 5;
    }
   
    roateAnimation2.removedOnCompletion = NO;
    keyAnimation2.removedOnCompletion = NO;
    
   
    group2.removedOnCompletion = NO;
    group2.repeatCount = MAXFLOAT;
    group2.delegate = self;
    group2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [group2 setValue:leafLayer2 forKey:@"leafLayer2"];
    [leafLayer2 addAnimation:group2 forKey:nil];
}
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    //移除layer的动画
//    CALayer *layer = [anim valueForKey:@"leafLayer"];
//     CALayer *layer2 = [anim valueForKey:@"leafLayer2"];
//    [layer2  removeFromSuperlayer];
//    [layer removeFromSuperlayer];
//}

//暂停动画

- (void)pauseAnimation {
    
    
    
    //（0-5）
    
    //开始时间：0
    
    //    myView.layer.beginTime
    
    //1.取出当前时间，转成动画暂停的时间
    
    CFTimeInterval pauseTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    
    self.layer.timeOffset = pauseTime;
    
    
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    
    self.layer.speed = 0;
    
    
    
}



//恢复动画

- (void)resumeAnimation {
    
    
    
    //1.将动画的时间偏移量作为暂停的时间点
    
    CFTimeInterval pauseTime = self.layer.timeOffset;
    
    
    
    //2.计算出开始时间
    
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    
    
    [self.layer setTimeOffset:0];
    
    [self.layer setBeginTime:begin];
    
    
    
    self.layer.speed = 1;
    
}
@end
