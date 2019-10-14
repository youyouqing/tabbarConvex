//
//  UIViewController+Extension.m
//  eHealthCare
//
//  Created by John shi on 2018/7/4.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "UIView+Extension.h"

static const char placeHoldImageKey = '\4';

@implementation UIView (Extension)

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

//获取当前视图的控制器
- (UIViewController *)currentViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    UIView *firstView = [keyWindow.subviews firstObject];
    
    UIView *secondView = [firstView.subviews firstObject];
    
    UIViewController *vc = [secondView parentController];
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tab = (UITabBarController *)vc;
        
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            
            return [nav.viewControllers lastObject];
            
        } else {
            
            return tab.selectedViewController;
            
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController *)vc;
        
        return [nav.viewControllers lastObject];
        
    }
    else if (vc.presentingViewController) {
//        if ([vc.presentingViewController isKindOfClass:[UITabBarController class]]) {
//          UITabBarController *tab = (UITabBarController *)vc.presentingViewController;
//
//        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
//
//            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
//
//            return [nav.viewControllers lastObject];
//
//        } else {
//
//            return tab.selectedViewController;
//
//        }
        return vc.presentingViewController;
//        }
    }
    else {
        
        return vc;
    }
    return nil;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}




- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

#pragma mark layer绘制 圆形或圆弧边框
///设置控件为圆形
- (void)setCircularControl:(float)controleWidth
{
    self.layer.cornerRadius = controleWidth/2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1.0;
}

///绘制控件的边框宽度和边框弧度
- (void)setLayerBordWidth:(CGFloat)bordWidth AndCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    self.layer.borderWidth = bordWidth;
}

#pragma mark 占位图
- (void)showPlaceHoldImageAtCenterOfView:(UIImage *)image
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
    placeHoldImage.tag = 10090;

    if (image)
    {
        placeHoldImage.image = image;
        
    }else
    {
        placeHoldImage.image = [UIImage imageNamed:@"none_dataImage"];
    }
    
    [self addSubview:placeHoldImage];
    self.placeHoldImage = placeHoldImage;
    
    [placeHoldImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(164), KHeight(160)));
    }];
}

- (void)hiddenPlaceHoldImage
{
    [self.placeHoldImage removeFromSuperview];
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
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
    
}
/// 添加单边阴影效果
- (void)addSingleShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    theView.layer.shadowColor = theColor.CGColor;
    theView.layer.shadowOffset = CGSizeMake(0,0);
    theView.layer.shadowOpacity = 0.5;
    theView.layer.shadowRadius = 5;
    // 单边阴影 顶边
    float shadowPathWidth = theView.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2.0, theView.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
    
}
@end