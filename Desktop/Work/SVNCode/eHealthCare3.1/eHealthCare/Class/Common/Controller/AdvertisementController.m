//
//  advertisementController.m
//  eHealthCare
//
//  Created by jamkin on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "advertisementController.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface AdvertisementController ()<UIWebViewDelegate>

@property (strong, nonatomic)  UIWebView *webV;

@end

@implementation AdvertisementController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURL * url = [request URL];
   
    if ([[url scheme] containsString:@"share"]) {//截获到发起分享的链接
        NSData *jsonData = [[url.query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"%@",dic);
        
        [self Share:dic[@"title"] linkUrl:dic[@"url"] imgUrl:dic[@"imagePath"] titlecontent:dic[@"content"]];//调起网页交互发起分享
        
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
                       //                       //展示当天任务是否完成
                       //                       XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
                       //                       [tools validationAndAddScore:@{@"Token":[UserCaches getUserCache].Token,@"TaskType":@(2),@"MemberID":@([UserCaches getUserCache].MemberID),@"TypeID":@(8)} withAdd:@{@"Token":[UserCaches getUserCache].Token,@"TaskType":@(2),@"MemberID":@([UserCaches getUserCache].MemberID),@"TypeID":@(8)}];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, (PublicY), KScreenWidth, KScreenHeight)];
    [self.view addSubview:self.webV];
    self.webV.backgroundColor=[UIColor whiteColor];
   
    self.webV.delegate = self;
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.webUrlStr]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self.webV loadRequest:request];
    

}

-(void)setWebUrlStr:(NSString *)webUrlStr{
    
    if ( [self.webV isLoading]) {
        
        return;
        
    }
    
    [self.webV stopLoading];
    
    self.webV.delegate=nil;
    
    _webUrlStr=webUrlStr;
    
    self.webV.delegate=self;
    
//    AppIdentify=80001&OSType(iOS为2，安卓的为3)&Token=用户token
    
    if ([_webUrlStr containsString:@"?"]) {
        
        _webUrlStr=[NSString stringWithFormat:@"http://%@&AppIdentify=80001&OSType=2&Token=%@",_webUrlStr,[UserInfoTool getLoginInfo].Token];
        
    }else{
        
        _webUrlStr=[NSString stringWithFormat:@"http://%@?&AppIdentify=80001&OSType=2&Token=%@",_webUrlStr,[UserInfoTool getLoginInfo].Token];
        
    }
    NSLog(@"_webUrlStr---------%@",_webUrlStr);
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_webUrlStr]];
    
    NSURLRequest *request    =[NSURLRequest requestWithURL:url];
    
    [self.webV loadRequest:request];
    
   
    
}


/**
 重写属性set方法
 */
-(void)setModel:(AdvertiseModel *)model{
    _model = model;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"share"] highImage:[UIImage imageNamed:@"share"] target:self action:@selector(actionLoactonShare) forControlEvents:UIControlEventTouchUpInside];
}

/**本地分享*/
-(void)actionLoactonShare{
    NSArray *imageArray = @[[self getImage]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.model.AdvertiseContent images:imageArray url:[NSURL URLWithString:self.webUrlStr] title:self.model.AdvertiseTitle type:SSDKContentTypeAuto];
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
                               //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                               if (platformType == SSDKPlatformTypeFacebookMessenger)
                               {
                                   break;
                               }
                               
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
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

- (UIImage *)getImage {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenWidth, [UIApplication sharedApplication].keyWindow.height), NO, 0);  //NO，YES 控制是否透明
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark    webviewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[XKLoadingView shareLoadingView]hideLoding];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[XKLoadingView shareLoadingView]errorloadingText:@"亲，网速不给力哇~"];
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
