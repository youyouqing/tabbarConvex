//
//  UIViewController+Extension.h
//  eHealthCare
//
//  Created by John shi on 2018/7/4.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (UIViewController *)parentController;

- (UIViewController *)currentViewController;


#pragma mark layer绘制
/**
 设置控件为圆形

 @param controleWidth 控件的宽度
 */
- (void)setCircularControl:(float)controleWidth;


/**
 绘制控件的边框宽度和边框弧度

 @param bordWidth 边框宽度
 @param cornerRadius 边框弧度
 */
- (void)setLayerBordWidth:(CGFloat)bordWidth AndCornerRadius:(CGFloat)cornerRadius;


#pragma mark 占位图
@property (nonatomic, strong) UIImageView *placeHoldImage;//占位图

/**
 在视图中央显示占位图
 
 @param image 占位图图片 可以填nil（就是使用默认图片咯）
 */
- (void)showPlaceHoldImageAtCenterOfView:(UIImage *)image;


/**
 隐藏占位图
 */
- (void)hiddenPlaceHoldImage;

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;
@end
