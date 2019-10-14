//
//  UIViewController+Entension.h
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Entension)

#pragma mark 弹出登录页
/**
 present出登录界面
 */
- (void)presentLoginView;

#pragma mark 获取当前viewController
/**
 获取当前ViewController
 
 @return 当前ViewController
 */
- (UIViewController *)getCurrentViewController;


#pragma mark 顶部提示信息

@property (nonatomic, strong) UILabel *remindTextLabel;//提示文字

/**
 显示顶部提示信息

 @param remindText 需要展示的提示文字
 @param isHas 是否有导航栏
 */
- (void)showRemindText:(NSString *)remindText hasNavigation:(BOOL)isHas;


/**
 隐藏顶部提示信息
 */
- (void)hiddenRemindText;


#pragma mark 占位图

@property (nonatomic, strong) UIImageView *placeHoldImage;//占位图

/**
 在视图中央显示占位图,占位图图片可以填nil（nil就是使用默认图片）

 @param image 占位图图片 可以填nil（就是使用默认图片咯）
 */
- (void)showPlaceHoldImageAtCenterOfViewController:(UIImage *)image;


/**
 隐藏占位图
 */
- (void)hiddenPlaceHoldImage;


#pragma mark 无导航页面显示title和放回按钮
/**
 无导航栏页面显示标题和返回按钮
 @param title 标题
 */
- (void)showTitleAndBackButtonWithoutNavigation:(NSString *)title;

///无导航栏页面的返回按钮的点击事件 写在这里是为了给子类重写
- (void)noNavigationBackToUpviewControllerAction;




/**
 *  Present View Controller with Material Design
 *
 *  @param viewController presented View Controller
 *  @param view           view tapped, to calculate the point that animation starts
 *  @param color          animation color, if nil, will use viewController's background color
 *  @param animated       animated or not
 *  @param completion     completion block
 */
- (void)presentLHViewController:(UIViewController *)viewController
                        tapView:(UIView *)view
                          color:(UIColor *)color
                       animated:(BOOL)animated
                     completion:(void (^)(void))completion;

/**
 *  Dismiss View Controller with Material Design
 *
 *  @param view       view tapped, if nil, will use the presenting view controller's point that animation starts
 *  @param color      animation color, if nil, will use viewController's background color
 *  @param animated   animated or not
 *  @param completion completion block
 */
- (void)dismissLHViewControllerWithTapView:(UIView *)view
                                     color:(UIColor*)color
                                  animated:(BOOL)animated
                                completion:(void (^)(void))completion;



//修改appicon


@end