//
//  ZBNavigationController.m
//
//  Created by junnpy Strong on 16/1/1.
//  Copyright © 2013年 Mystery. All rights reserved.
//

#import "XKNavigationController.h"
#import "XKTabBar.h"
#import "AppDelegate.h"
@interface XKNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation XKNavigationController

#pragma mark 导航控制器 只运行一次 统一设置样式
+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
}
#pragma mark 视图已经加载
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //取消系统的滑动返回效果代理就可以 换图片实现自己的滑动返回代理
    
    //定义stong变量来存储代理对象
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    //设置导航视图控制器的代理
    self.delegate = self;

    //统一设置导航栏的颜色        
//    self.navigationBar.barTintColor=COLOR(59, 201, 219, 1);
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"button-bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    //统一设置导航栏title的大小和颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
        
    [self.navigationBar setTitleTextAttributes:titleAttr];
    
}
#pragma mark 内容警告
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark 导航控制器跳转方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 不是根控制器
    if (self.childViewControllers.count) {
        // 如果不是根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        //设置跳转到的控制器的左右按钮 统一设置
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮 左
        viewController.navigationItem.leftBarButtonItem = left;
    }
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark 跳转到根控制器
- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark 向后跳转一级
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}

//ragma mark 已经显示的视图控制器
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        // 是根控制器  将代理对象还原
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        // 非根控制器  清除滑动代理对象
        self.interactivePopGestureRecognizer.delegate = nil;
        //是否禁用滑动返回的手势
        self.interactivePopGestureRecognizer.enabled=self.isTragBack;
    }
    
}

#pragma mark 视图控制器将要显示在窗体上
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
            if (![tabBarButton isKindOfClass:[XKTabBar class]]) {
                
                [tabBarButton removeFromSuperview];
            }
        }
        
    }
    
}


@end
