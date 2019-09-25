//
//  BaseWebViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController <WKNavigationDelegate>

///需要加载的网页链接
@property (nonatomic, copy) NSString *urlString;

///叉子 按钮
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) WKWebView *webView;

//4.0版本的喝水。 久坐等提醒的  距离顶部是0 其他是PublicY
@property (nonatomic, assign)BOOL isNewHeight;
///加载url
- (void)loadUrl;
- (void)loadHtmlUrl:(NSString *)htmlName;
/**
 叉子 按钮的点击事件
 */
- (void)closeButtonAction;

@end
