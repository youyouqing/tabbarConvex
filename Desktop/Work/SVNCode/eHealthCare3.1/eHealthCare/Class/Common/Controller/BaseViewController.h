//
//  BaseViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

///页面类型
typedef NS_ENUM(NSInteger, pageType){
    
    pageTypeNormal = 0,//普通类型，有标题有返回按钮
    pageTypeOnlyTitle = 1,//只有标题类型
    pageTypeNoNavigation = 2//无导航栏类型
};

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UILabel *titleLab;//标题按钮
///自定义导航栏视图
@property (nonatomic, strong) UIView *headerView;

///标题
@property (nonatomic, copy) NSString *myTitle;

///左边按钮
@property (nonatomic, strong) UIButton *leftBtn;

///右边按钮
@property (nonatomic, strong) UIButton *rightBtn;

///页面类型
@property (nonatomic, assign) pageType pageType;

- (id)initWithType:(pageType)pageType;

///回到上一级界面
- (void)popToUpViewController;

@end