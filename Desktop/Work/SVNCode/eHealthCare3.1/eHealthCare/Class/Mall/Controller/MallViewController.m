//
//  MallViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MallViewController.h"
#import "HomeViewController.h"
#import "TabbarController.h"
#import "AppDelegate.h"
#import "CommonViewModel.h"
#import "PayMoneyModel.h"
#import "ShareView.h"
#import "LocationTool.h"
#import <WXApi.h>
#import "PayFailController.h"
#import "PayReusltController.h"
#import "XKHealthMallProductPayMessageModel.h"
@interface MallViewController ()
/**保存商品支付信息*/
@property (nonatomic,strong) XKHealthMallProductPayMessageModel *product;

/**保存支付信息*/
@property (nonatomic,strong)NSDictionary *payDict;

///进行二次跳转获取到的url
@property (nonatomic, strong) NSURL *webUrl;

///定位
@property (nonatomic, strong) LocationTool *location;
@end

@implementation MallViewController
- (void)viewWillAppear:(BOOL)animated
{
    //添加监听
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}


#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    //网页title
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView)
        {
            self.myTitle = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    self.urlString = self.homeAdvisterUrlStr.length>0?self.homeAdvisterUrlStr:(kMallMiddleUrl);
    
    self.myTitle = @"携康e加";
    
    
    //监听支付宝/微信支付成功的回调
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipaySuccess) name:@"alipaySuccess" object:nil];
    
    //监听支付宝/微信支付失败的回调
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayfailure) name:@"alipayfailure" object:nil];
    
    [self loadUrl];
}

#pragma mark 重写父类方法
//重写左侧返回按钮的点击事件
- (void)popToUpViewController
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }else
    {
        [self closeButtonAction];
    }
}
//叉子 按钮的点击事件
- (void)closeButtonAction
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *controller = app.window.rootViewController;
    
    TabbarController *tab = (TabbarController *)controller;
    
    [tab setSelectedIndex:0];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    if ([self.webView.backForwardList.backList firstObject]) {
        tab.tabBar.hidden = NO;
        self.closeButton.hidden = YES;
        [self.webView goToBackForwardListItem:[self.webView.backForwardList.backList firstObject]];
    }
    
}
- (void)startLocationServer
{
    if (!self.location) {
        //开始定位
        LocationTool *location = [[LocationTool alloc] init];
        location.delegate = self;
        self.location = location;
    }
    
    [self.location getCurrentLocation];
}
#pragma mark location delegate
- (void)getCurrentLocationSuccess:(NSString *)locations
{
    NSArray *params = [self.webUrl.query componentsSeparatedByString:@"="];
    NSString *sendString = [NSString stringWithFormat:@"%@('%@')",params[1],locations];
    
    [self.webView evaluateJavaScript:sendString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
         NSLog(@"response---%@",response);
    }];
}

#pragma mark --WKWebView WKNavigation Delegate
//重写WKWebView的delegate方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    if (!self.location) {
        //开始定位
        LocationTool *location = [[LocationTool alloc] init];
        location.delegate = self;
        self.location = location;
    }
    //分享
    if ([scheme containsString:@"share"]) {
        
        NSString *temp =  [NSString decodeFromPercentEscapeString:url.query];
        NSDictionary *dicTemp = [temp mj_JSONObject];
        
        [self shareUrlAction:dicTemp];
    }
    
    //支付
    if ([scheme containsString:@"pay"]) {
        
        [self getPayData:url];
    }

    if ([scheme containsString:@"xkapp"])
    {
        self.webUrl = url;
        
        [self startLocationServer];
        
    }
    //打电话
    if ([scheme containsString:@"tel"]) {
        
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark Action
//分享
- (void)shareUrlAction:(NSDictionary *)dicTemp
{
    ShareModel *model = [[ShareModel alloc]init];
    
    model.shareUrl = [NSString stringWithFormat:@"%@",dicTemp[@"url"]];
    model.shareTitle = dicTemp[@"title"];
    model.shareContent = dicTemp[@"content"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dicTemp[@"imagePath"]]]];
    if (image) {
       model.shareImageArray = @[image];
    }
   
    
    [ShareView shareActionOfShareUseFor:shareUseForShareContent shareType:shareUrl WithViewcontroller:self ShareModel:model Block:^(NSInteger tag) {
        
    } shareTree:NO];
}

- (void)getPayData:(NSURL *)url
{
    NSArray *params = [url.query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    for (NSString *paramStr in params) {
        NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
        NSLog(@"%@",dicArray);
        if (dicArray.count > 1) {
            
            NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [tempDic setObject:decodeValue forKey:dicArray[0]];
        }
    }
    NSLog(@"tempDic:%@",tempDic[@"data"]);
    NSArray *s = [tempDic[@"data"] componentsSeparatedByString:@"}"];
    NSString *ss = s[0];
    NSArray *sss = [ss componentsSeparatedByString:@"{"];
    NSLog(@"%@",sss[1]);
    NSArray *ssss = [sss[1] componentsSeparatedByString:@"\""];
    NSString *total = @"";
    for (NSString *res in ssss) {
        total = [NSString stringWithFormat:@"%@%@",total,res];
    }
    NSLog(@"%@",total);
    NSMutableDictionary *tDict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *sssss = [total componentsSeparatedByString:@","];
    for (NSString *res in sssss)  {
        NSArray *dataAr = [res componentsSeparatedByString:@":"];
        [tDict setObject:dataAr[1] forKey:dataAr[0]];
    }
    NSLog(@"%@",tDict);
    
    PayMoneyModel *model = [PayMoneyModel mj_objectWithKeyValues:tDict];
    
    [self payMoneyWithModel:model];
}

#pragma mark NetWorking
- (void)payMoneyWithModel:(PayMoneyModel *)model
{
    ShowNormailMessage(@"正在处理...");
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"OrderID":@(model.OrderID),
                          @"Amount":@(model.Amount),
                          @"Url":@" ",
                          @"PayMethodStatus":@(model.PayMethodStatus)};
    
    [CommonViewModel checkOrderBeforePayMoneyWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        DismissHud();
        if (response.code == CodeTypeSucceed) {
            
            //支付宝支付
            if (model.PayMethodStatus == 1)
            {
                [self aliPay:response.Result];
                
            //微信支付
            }else
            {
                [self wechatPay:response.Result];
            }
        }
        
    }];
}

#pragma mark 支付
- (void)aliPay:(NSDictionary *)needPayOrderDic
{
    [[AlipaySDK defaultService] payUrlOrder:needPayOrderDic[@"mweb_url"] fromScheme:@"eHealthCare" callback:^(NSDictionary *resultDic) {
        
        NSLog(@"%@",resultDic);
        if ([resultDic[@"resultCode"] integerValue] == 9000) {//支付成功
            
            ShowSuccessStatus(@"支付成功");
            [self.webView goBack];
            
        }else{//支付失败
            
            ShowErrorStatus(@"支付失败");
            [self.webView reload];
        }
    }];
}

//微信支付
- (void)wechatPay:(NSDictionary *)needPayOrderDic
{
    if (![WXApi isWXAppInstalled]) {
        
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:nil message:@"您尚未安装微信" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        
        [alertCon addAction:action1];
        [alertCon addAction:action2];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }
    
    PayReq *req = [[PayReq alloc] init];
    req.openID = needPayOrderDic[@"appid"];
    req.partnerId =needPayOrderDic[@"partnerid"];
    req.prepayId = needPayOrderDic[@"prepayid"];
    req.nonceStr = needPayOrderDic[@"noncestr"];
    req.timeStamp = [needPayOrderDic[@"timestamp"] intValue];
    req.package = needPayOrderDic[@"package"];

    req.sign = needPayOrderDic[@"sign"];

    [WXApi sendReq:req];
}
/**
 支付宝支付成功的监听方法
 */
-(void)alipaySuccess{
    NSLog(@"支付成功");
    PayReusltController *payresult=[[PayReusltController alloc]init];
    
    payresult.fromIndex=0;
    
    payresult.method=self.product.PayMethodStatus;
    
    payresult.tradeCode=self.payDict[@"OrderCode"];
    
    [self.navigationController pushViewController:payresult animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipaySuccess" object:nil];
}

-(void)alipayfailure{
    NSLog(@"支付失败");
    PayFailController *failVC = [[PayFailController alloc] init];
    
    failVC.fromIndex=0;
    
    failVC.method=self.product.PayMethodStatus;
    
    failVC.OrderID=self.product.OrderID;
    
    [self.navigationController pushViewController:failVC animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipayfailure" object:nil];
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