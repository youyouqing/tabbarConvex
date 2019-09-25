//
//  NewAboutUsViewController.m
//  eHealthCare
//
//  Created by mac on 17/2/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NewAboutUsViewController.h"

@interface NewAboutUsViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *usWeb;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@end

@implementation NewAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myTitle=@"关于我们";
    self.topCons.constant = PublicY;
    self.usWeb.backgroundColor=[UIColor whiteColor];
    
    self.usWeb.delegate=self;
    
    NSString *urlStr=[NSString stringWithFormat:@"%@AppComm/AboutUs",kMainUrl];
    
    if ([urlStr containsString:@"?"]) {
        
        urlStr=[NSString stringWithFormat:@"%@&AppIdentify=80001&OSType=2&Token=%@",urlStr,[UserInfoTool getLoginInfo].Token];
        
    }else{
        
        urlStr=[NSString stringWithFormat:@"%@?&AppIdentify=80001&OSType=2&Token=%@",urlStr,[UserInfoTool getLoginInfo].Token];
        
    }
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self.usWeb loadRequest:request];

}

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
