//
//  UIViewController+Entension.m
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "UIViewController+Entension.h"
#import "LoginViewController.h"

static const char remindTextKey = '\3';
static const char placeHoldImageKey = '\4';
static const char *pointVarKey = "animationPoint";

@interface UIViewController (Extension)

@end

@implementation UIViewController (Entension)

#pragma mark 弹出登录页
//present登录
- (void)presentLoginView
{
    LoginViewController *login = [[LoginViewController alloc]initWithType:pageTypeNoNavigation];
    
    [self.navigationController presentViewController:login animated:YES completion:nil];
    
    
    
}

#pragma mark 获取当前viewController
//获取当前Controller
- (UIViewController *)getCurrentViewController
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    
    if (appRootVC.presentedViewController) {
        
        while (appRootVC.presentedViewController) {
            
            appRootVC = appRootVC.presentedViewController;
            
            if (appRootVC)
            {
                nextResponder = appRootVC;
            }else
            {
                break;
            }
        }
        
    }else{
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* tabbar = (UITabBarController *)nextResponder;
        UINavigationController* nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        
        result = nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
        
    }else{
        
        result = nextResponder;
    }
    return result;
}

#pragma mark 顶部提示信息
//显示顶部提示信息
- (void)showRemindText:(NSString *)remindText hasNavigation:(BOOL)isHas
{
    UILabel *remindTextLabel = [[UILabel alloc]init];

    remindTextLabel.text = remindText;
    remindTextLabel.font = Kfont(14);
    remindTextLabel.textAlignment = NSTextAlignmentCenter;
    remindTextLabel.textColor = [UIColor redColor];

    [self.view addSubview:remindTextLabel];
    self.remindTextLabel = remindTextLabel;

    [remindTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        if (isHas) {

           make.top.mas_equalTo(PublicY);

        }else{

            make.top.mas_equalTo(PublicY - 44);
        }

        make.left.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, 20));

    }];
}

//隐藏顶部提示信息
- (void)hiddenRemindText
{
    [self.remindTextLabel removeFromSuperview];
}

//getter setter 方法
//提示文字
- (UILabel *)remindTextLabel
{
    return objc_getAssociatedObject(self, &remindTextKey);
}

- (void)setRemindTextLabel:(UILabel *)remindTextLabel
{
    objc_setAssociatedObject(self, &remindTextKey, remindTextLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark 占位图
//显示占位图
- (void)showPlaceHoldImageAtCenterOfViewController:(UIImage *)image
{
    UIImage *placeImage = [[UIImage alloc]init];
    if (image)
    {
        placeImage = image;
        
    }else
    {
        placeImage = [UIImage imageNamed:@""];
    }
    
    //占位图
    UIImageView *placeHoldImage = [[UIImageView alloc]init];
    
    if (image)
    {
        placeHoldImage.image = image;
        
    }else
    {
        placeHoldImage.image = [UIImage imageNamed:@"none_dataImage"];
    }
    
    [self.view addSubview:placeHoldImage];
    self.placeHoldImage = placeHoldImage;
    
    [placeHoldImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(164), KHeight(160)));
    }];
}

//隐藏占位图
- (void)hiddenPlaceHoldImage
{
    
    if (self.placeHoldImage)
    {
        [self.placeHoldImage removeFromSuperview];
    }
}

//getter setter 方法
- (UIImageView *)placeHoldImage
{
    return objc_getAssociatedObject(self, &placeHoldImageKey);
}

- (void)setPlaceHoldImage:(UIImageView *)placeHoldImage
{
    objc_setAssociatedObject(self, &placeHoldImageKey, placeHoldImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark 无导航页面显示title和放回按钮
//无导航栏页面显示title和返回按钮
- (void)showTitleAndBackButtonWithoutNavigation:(NSString *)title
{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = Kfont(20);
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = title;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo((PublicY) - 42);
        make.height.mas_equalTo(40);
    }];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(noNavigationBackToUpviewControllerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.top.mas_equalTo((PublicY) - 42);
        make.width.height.mas_equalTo(40);
    }];
}

//返回按钮的点击事件
- (void)noNavigationBackToUpviewControllerAction
{
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)presentLHViewController:(UIViewController *)viewController
                        tapView:(UIView *)view
                          color:(UIColor*)color
                       animated:(BOOL)animated
                     completion:(void (^)(void))completion{
    if (animated) {
        self.view.userInteractionEnabled = NO;
        CGPoint convertedPoint = [self.view convertPoint:view.center fromView:view.superview];
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController*)viewController).topViewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
        } else {
            [viewController setAnimationPoint:[NSValue valueWithCGPoint:convertedPoint]];
        }
        
        UIColor *animationColor = color;
        if (animationColor == nil) {
            animationColor = viewController.view.backgroundColor;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:viewController animated:NO completion:nil];
        });
        
        CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:convertedPoint];
        shapeLayer.fillColor = animationColor.CGColor;
        self.view.layer.masksToBounds = YES;
        [self.view.layer addSublayer:shapeLayer];
        
        [self mdAnimateAtPoint:convertedPoint duration:0.4 inflating:YES shapeLayer:shapeLayer completion:^{
            self.view.userInteractionEnabled = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        [self presentViewController:viewController animated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }
}

- (void)dismissLHViewControllerWithTapView:(UIView *)view
                                     color:(UIColor*)color
                                  animated:(BOOL)animated
                                completion:(void (^)(void))completion{
    if (animated) {
        CGPoint animaionPoint = CGPointZero;
        if (view) {
            animaionPoint = [self.view convertPoint:view.center fromView:view.superview];
        } else {
            animaionPoint = [[self animationPoint] CGPointValue];
        }
        UIColor *animationColor = color;
        if (animationColor == nil) {
            animationColor = self.view.backgroundColor;
        }
        
        UIViewController *vc = self.presentingViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).topViewController;
        }
        vc.view.userInteractionEnabled = NO;
        
        CAShapeLayer *shapeLayer = [self mdShapeLayerForAnimationAtPoint:animaionPoint];
        shapeLayer.fillColor = animationColor.CGColor;
        vc.view.layer.masksToBounds = YES;
        [vc.view.layer addSublayer:shapeLayer];
        
        [self dismissViewControllerAnimated:NO completion:^{
            [self mdAnimateAtPoint:animaionPoint duration:0.4 inflating:NO shapeLayer:shapeLayer completion:^{
                vc.view.userInteractionEnabled = YES;
                if (completion) {
                    completion();
                }
            }];
        }];
    } else {
        [self dismissViewControllerAnimated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }
}
#pragma mark - var

- (NSValue *)animationPoint {
    return (NSValue *)objc_getAssociatedObject(self, &pointVarKey);
}

- (void)setAnimationPoint:(NSValue *)animationPoint {
    objc_setAssociatedObject(self, &pointVarKey, animationPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - animation

- (void)mdAnimateAtPoint:(CGPoint)point
                duration:(NSTimeInterval)duration
               inflating:(BOOL)inflating
              shapeLayer:(CAShapeLayer *)shapeLayer
              completion:(void (^)(void))block {
    
    CGFloat scale = 1.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [self shapeAnimationWithTimingFunction:[CAMediaTimingFunction functionWithName:timingFunctionName] scale:scale inflating:inflating];
    animation.duration = duration;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        if (block) {
            block();
        }
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
}
- (CAShapeLayer *)mdShapeLayerForAnimationAtPoint:(CGPoint)point {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    return shapeLayer;
}
- (CABasicAnimation *)shapeAnimationWithTimingFunction:(CAMediaTimingFunction *)timingFunction scale:(CGFloat)scale inflating:(BOOL)inflating {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    if (inflating) {
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    } else {
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    }
    animation.timingFunction = timingFunction;
    animation.removedOnCompletion = YES;
    return animation;
}
#pragma mark - helpers

- (CGFloat)mdShapeDiameterForPoint:(CGPoint)point {
    CGPoint cornerPoints[] = { {0.0, 0.0}, {0.0, KScreenHeight}, {KScreenWidth, KScreenHeight}, {KScreenWidth, 0.0} };
    CGFloat radius = 0.0;
    for (int i = 0; i < sizeof(cornerPoints) / sizeof(CGPoint); i++) {
        CGPoint p = cornerPoints[i];
        CGFloat d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0) );
        if (d > radius) {
            radius = d;
        }
    }
    return radius * 2.0;
}
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(lq_presentViewController:animated:completion:));

        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

- (void)lq_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {

    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
                NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
                NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);

        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil&& alertController.preferredStyle == UIAlertControllerStyleAlert) {
            return;
        }
    }

    [self lq_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
