//
//  BaseWebViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseWebViewController.h"

#import "TabbarController.h"
#import "MallMiddleViewController.h"

#import "AppDelegate.h"

#import "WebProgress.h"
#import "MallViewController.h"
@interface BaseWebViewController () 
@property (nonatomic, strong) UIView *nullImgeView;

@property (nonatomic, strong) WebProgress *progress;//进度条
@property (strong, nonatomic)  UIImageView *backProgressimg;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self set_BaseWebView_UI];
    [self set_failWebUI];
}

- (void)set_BaseWebView_UI
{
    WKWebView *webView = [[WKWebView alloc]init];
    webView.scrollView.bounces = NO;
    self.urlString = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    config.preferences.minimumFontSize = 0.0f;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.UIDelegate = self;
    
    if (self.isNewHeight == YES) {
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);//0
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
    }else
    {
        
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(PublicY);//0
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
    }

    //叉子按钮
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [closeButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:closeButton];
    self.closeButton = closeButton;
    self.closeButton.hidden = YES;
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.leftBtn.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(-2);
        make.width.height.mas_equalTo(40);

    }];
     self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *))
    {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
//    self.backProgressimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mallLoadingBack"]];//
//    [self.view addSubview:self.backProgressimg];
//    [self.backProgressimg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(0);//0
//        make.left.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//
//    }];
}
-(UIView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIView alloc]initWithFrame:CGRectMake(0,self.webView.y,KScreenWidth, KScreenHeight-self.webView.y) ];
        _nullImgeView.backgroundColor =  [UIColor whiteColor];
        UIImageView *noDataImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0 ,self.webView.y, KWidth(207),KHeight(105)) ];
        noDataImageV.center = CGPointMake(KScreenWidth/2, (KScreenHeight - (PublicY))/2 - KScreenWidth/2.15/2);
        noDataImageV.image = [UIImage imageNamed:@"vi_webcheck"];
        [_nullImgeView addSubview:noDataImageV];
        
        UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-KWidth(159))/2.0, noDataImageV.y+noDataImageV.height+KHeight(30),KWidth(159) , KHeight(75))];
        textLab.text  = [NSString stringWithFormat:@"%@\n%@\n%@",@"当前使用人数过多",@"工程师正在抢修中",@"为您带来不便十分抱歉"];
        textLab.textColor = [UIColor getColor:@"B9C4D6"];
        textLab.font = [UIFont systemFontOfSize:14.f];
        textLab.textAlignment = NSTextAlignmentCenter;
        textLab.numberOfLines = 3;
        [_nullImgeView addSubview:textLab];
        
//        UIButton *reagainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        reagainBtn.frame = CGRectMake((KScreenWidth-110)/2.0, textLab.y+textLab.height+KHeight(38), 110, 35);
//        [reagainBtn setTitle:@"重新加载" forState:UIControlStateNormal];
//        [reagainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [reagainBtn setBackgroundImage:[UIImage imageNamed:@"bt_chongxinjiazai"] forState:UIControlStateNormal];
//        [reagainBtn addTarget:self action:@selector(clickWebAgain) forControlEvents:UIControlEventTouchUpInside];
//        reagainBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
//        [_nullImgeView addSubview:reagainBtn];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}
-(void)set_failWebUI
{
    
    [self.webView addSubview:self.nullImgeView];
    
    
}
-(void)clickWebAgain
{
     self.nullImgeView.alpha = 0;
    [self.webView reload];
    
}
- (void)loadUrl
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (void)loadHtmlUrl:(NSString *)htmlName
{
    
    NSString *bundlePath=[[NSBundle mainBundle]bundlePath];
    
    NSString *path=[bundlePath stringByAppendingPathComponent:htmlName];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}
#pragma mark WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
     self.backProgressimg.hidden = NO;
    self.progress = [WebProgress layerWithFrame:CGRectMake(0, 0, KScreenWidth, 2)];
    [self.view.layer addSublayer:self.progress];
    [self.progress startLoad];
//    ShowNormailMessage(gettingData);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
{
      NSLog(@"statusCode:%@", navigationResponse);
     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)navigationResponse.response;
     if (httpResponse.statusCode!=200) {//tmpresponse.statusCode>=500||
        self.nullImgeView.alpha = 1;
     }else
     {
        self.nullImgeView.alpha = 0;
     }
     decisionHandler(WKNavigationResponsePolicyAllow);
}
//完成加载
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:webView.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *tmpresponse = (NSHTTPURLResponse*)response;
//        NSLog(@"statusCode:%ld", tmpresponse.statusCode);
//        
//    }];
//    
//    [dataTask resume];
    self.backProgressimg.hidden = YES;
    [self.progress finishedLoad];
//    DismissHud();
    
    self.leftBtn.hidden = NO;
    
    if ([self.webView canGoBack])
    {
        
        self.closeButton.hidden = NO;
    }else
    {
        self.closeButton.hidden = YES;
    }
   
    
  
}
//亲，网速不给力哇~
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
     self.backProgressimg.hidden = YES;
   
}
//请求服务器跳转
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"二级跳转");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"4---didFailProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"5---didFailProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"tel"]) {
        
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }

    else{
        
        NSLog(@"webView.backForwardList.backList.count:%lu", (unsigned long)webView.backForwardList.backList.count);
        if (webView.backForwardList.backList.count > 0) {
            
            //[self addCancleBtn];
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark Action
//webview返回上一层
- (void)popToUpViewController
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//叉子 按钮的点击事件
- (void)closeButtonAction
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIViewController *controller = app.window.rootViewController;

    TabbarController *tab = (TabbarController *)controller;
//    if ([controller isKindOfClass:[MallMiddleViewController class]]) {
//     
//    }else
//    {
//        
//        
//    }
//    [tab setSelectedIndex:0];

    [self.navigationController popToRootViewControllerAnimated:YES];

    if ([self.webView.backForwardList.backList firstObject]) {
        tab.tabBar.hidden = NO;
        self.closeButton.hidden = YES;
        [self.webView goToBackForwardListItem:[self.webView.backForwardList.backList firstObject]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
