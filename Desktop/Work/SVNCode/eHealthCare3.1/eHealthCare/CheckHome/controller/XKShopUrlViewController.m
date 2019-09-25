//
//  XKShopUrlViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/11/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKShopUrlViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface XKShopUrlViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@end

@implementation XKShopUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.webView.backgroundColor=[UIColor whiteColor];
     self.topCons.constant = (PublicY);
    self.webView.delegate = self;
    
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.ShopUrl]];
     NSURL *url=[NSURL URLWithString: [ self.ShopUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     NSURLRequest *request=[NSURLRequest requestWithURL:url];
     self.myTitle = @"携康e加商城";
     [self.webView loadRequest:request];
    
}
-(void)setShopUrl:(NSString *)ShopUrl
{


    if ( [self.webView isLoading]) {
        
        return;
        
    }
    
    [self.webView stopLoading];
    
    self.webView.delegate=nil;
    
    _ShopUrl=ShopUrl;
    
    self.webView.delegate=self;
    
    //    OSType(iOS为2，安卓的为3)&Token=用户token
    
//    if ([_ShopUrl containsString:@"?"]) {
//        
        _ShopUrl=[NSString stringWithFormat:@"%@&Token=%@&OSType=2",_ShopUrl,[UserInfoTool getLoginInfo].Token];
//
//    }else{
//        
//        _ShopUrl=[NSString stringWithFormat:@"%@?&Token=%@&OSType=2",_ShopUrl,[UserInfoTool getLoginInfo].Token];
    
//    }
  
    NSURL *url=[NSURL URLWithString: [ _ShopUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",_ShopUrl);
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];

}

#pragma mark    webviewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self catchJsLog];
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    
    NSString *allHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.myTitle = allHtml;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[XKLoadingView shareLoadingView]hideLoding];
    
    
    NSString *allHtml = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.myTitle = allHtml;
     [self catchJsLog];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[XKLoadingView shareLoadingView]errorloadingText:@"亲，网速不给力哇~"];
     [self catchJsLog];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURL * url = [request URL];
    NSLog(@"%@",[url scheme]);
    NSLog(@"%@",url.query);
    NSLog(@"%@",url.path);
    NSLog(@"%@",url.absoluteString);
    

    if ([[url scheme] containsString:@"share"]) {//截获到发起分享的链接
        
        //        self.backImg.hidden = YES;
        //        NSString *testStr = @"\"{\"title\":\"肩颈按摩油+御方肩颈通络帖\",\"url\":\"https://wechat.xiekang.net/Mall/SellProductDetail?puyType=4&ProductID=40\",\"imagePath\":\"https://img.xiekang.net/Upload/SellProduct/201712151903223260.png\"}\"";
        NSData *jsonData = [[url.query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"%@",dic);

        [self Share:dic[@"title"] linkUrl:dic[@"url"] imgUrl:dic[@"imagePath"] titlecontent:dic[@"content"]];//调起网页交互支付
        
        return NO;
    }
    
  
    
    
    return YES;
}


/**
 分享给我的朋友按钮的点击事件
 */
- (void)Share:(NSString *)title linkUrl:(NSString *)linkUrl imgUrl:(NSString *)imgUrl titlecontent:(NSString *)titlecontent{
    NSLog(@"分享给我的朋友");
    NSURL *url = [NSURL URLWithString:imgUrl];
    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    NSArray *imageArray = @[imagea];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\r%@",title,titlecontent] images:imageArray url:[NSURL URLWithString:linkUrl] title:title type:SSDKContentTypeWebPage];
        [ShareSDK showShareActionSheet:nil
                                 items:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {

                       switch (state) {
                               
                           case SSDKResponseStateBegin:
                           {
                               
                               //                               [IanAlert showLoading:@"分享中..." allowUserInteraction:NO];
                               break;
                           }
                           case SSDKResponseStateSuccess:
                           {
                               
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                               if (platformType == SSDKPlatformTypeFacebookMessenger)
                               {
                                   break;
                               }
                               
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               else
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               break;
                           }
                           case SSDKResponseStateCancel:
                           {
                               //                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                               //                                                                                   message:nil
                               //                                                                                  delegate:nil
                               //                                                                         cancelButtonTitle:@"确定"
                               //                                                                         otherButtonTitles:nil];
                               //                               [alertView show];
                               
                               break;
                           }
                           default:
                               break;
                       }
                       
                       if (state != SSDKResponseStateBegin)
                       {
                           [IanAlert hideLoading];
                       }
                       
                   }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**错误日志捕获*/
- (void)catchJsLog{
//    if(DEBUG){
//        JSContext *ctx = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//        ctx[@"console"][@"log"] = ^(JSValue * msg) {
//            NSLog(@"xxxxH5  log : %@", msg.context);
//        };
//        ctx[@"console"][@"warn"] = ^(JSValue * msg) {
//            NSLog(@"xxxH5  warn : %@", msg.context);
//        };
//        ctx[@"console"][@"error"] = ^(JSValue * msg) {
//            NSLog(                                                                                                                                                                                                                                                                                                                                                                                      @"xxH5  error : %@", msg.context);
//        };
//    }
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
