//
//  ViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "ViewController.h"
#import "VDGifPlayerTool.h"
#import "TabbarController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "WXApi.h"
#import "GuideView.h"
#import "CommonViewModel.h"
#import "LoginViewModel.h"
#import "XKBindMobileViewController.h"
#import "JPUSHService.h"
@interface ViewController ()
@property (nonatomic, strong) GuideView *guideView;
@property (nonatomic, strong) UIButton *newloginButton;
@property (nonatomic, strong)UIImageView *thirdImage;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong)UIButton *skipbutton;
@property (nonatomic, strong)UIButton *thirdLogin;
@property (nonatomic, strong)UILabel *weixinLab;
@property (nonatomic, weak)VDGifPlayerTool *addGif;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![WXApi isWXAppInstalled]) {
        if (self.newloginButton) {
              self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = YES;
//            [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//                
//                make.top.mas_equalTo(self.newloginButton.mas_bottom).mas_offset(KHeight(735));
//                make.centerX.mas_equalTo(self.view.mas_centerX);
//                make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//            }];
        }
        
        
        
    }else
    {
        if (self.newloginButton) {
            self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = NO;

//            [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//                
//                make.top.mas_equalTo(self.newloginButton.mas_bottom).mas_offset(KHeight(69));
//                make.centerX.mas_equalTo(self.view.mas_centerX);
//                make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    //判断当前版本是否是第一次进入App
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastVersion"];

    if(![nowVersion isEqualToString:lastVersion])
    {
        NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:@"lastVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self loadGuidePageView];

    }else
    {
        [self isGoToLogin];
    }
   

}
- (void)loginAction
{
     [self isGoToLogin];
    self.bgView.hidden = YES;
}
- (void)newloginAction
{
    self.bgView.hidden = YES;
    WEAKSELF;
    GuideView * guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [weakSelf.view addSubview:guideView];
    [weakSelf.view bringSubviewToFront:guideView];
    weakSelf.skipbutton.hidden = YES;
    [guideView setHideGuideViewBlock:^{
        weakSelf.guideView = nil;
        [weakSelf isGoToLogin];
    }];
    self.guideView = guideView;
    
//      [self loadGuidePageView];
      self.bgView.hidden = YES;
}
-(void)loginWithWechat
{
    [self.view endEditing:YES];
    if (![WXApi isWXAppInstalled]) {
        
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:nil message:@"您尚未安装微信" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            return ;
            
        }];
        
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            return ;
            
        }];
        
        [alertCon addAction:action1];
        [alertCon addAction:action2];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }
    
    [LoginViewModel getWechatLoginWithFinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            [SingleTon shareInstance].isLogin = YES;
            [SingleTon shareInstance].token = response.Result[@"Token"];
            UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:response.Result];
            [UserInfoTool saveLoginInfo:model];
            [JPUSHService setTags:nil alias:response.Result[@"Mobile"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {//self.phoneText.text
                NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
            }];
            //保存用户手机号
            [UserInfoTool saveUserPhone:response.Result[@"Mobile"]];
            
//            if (self.presentingViewController) {
//
//                [self dismissViewControllerAnimated:YES completion:nil];
//
//            }else{
//
//            }
             [self isGoToLogin];
            
        }else if (response.code == CodeTypeWechatNotOnLine)
        {
            //需要present的页面
            XKBindMobileViewController *p = [XKBindMobileViewController new];
             p.bindType = 6;
            UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
            while (rootViewController.presentedViewController)
            {
                rootViewController = rootViewController.presentedViewController;
            }
            [rootViewController presentViewController:p animated:NO completion:nil];
            
        }
        else{
            ShowErrorStatus(response.msg);
        }
        
    }];
    
    
}
-(void)createUI{
    
    UIView *bgView = [[UIView alloc]init];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
      
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.layer.cornerRadius = KHeight(45)/2.0;
    loginButton.clipsToBounds = YES;
    loginButton.layer.borderWidth = 1.f;
    loginButton.layer.borderColor = kMainColor.CGColor;
    [loginButton setTitle:@"我是老用户" forState:UIControlStateNormal];
    [loginButton setTitleColor:kMainColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(185));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(45));
        make.left.mas_equalTo(KWidth(24));
        make.right.mas_equalTo(-KWidth(24));
    }];
   
    
    
    
    UIButton *newloginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newloginButton.layer.cornerRadius = KHeight(45)/2.0;
    newloginButton.clipsToBounds = YES;
    //    loginButton.layer.borderWidth = 1.f;
    //    loginButton.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    [newloginButton setTitle:@"我是新用户" forState:UIControlStateNormal];
    [newloginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newloginButton addTarget:self action:@selector(newloginAction) forControlEvents:UIControlEventTouchUpInside];
    newloginButton.backgroundColor = [UIColor getColor:@"03C7FF"];
    [bgView addSubview:newloginButton];
    [newloginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(loginButton.mas_bottom).mas_offset(KHeight(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(45));
        make.left.mas_equalTo(KWidth(24));
        make.right.mas_equalTo(-KWidth(24));
    }];
    self.newloginButton = newloginButton;
    
    UIImageView *thirdImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iv_login_disanfang"]];
    [bgView addSubview:thirdImage];
//    [thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(newloginButton.mas_bottom).mas_offset(KHeight(69));
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(KWidth(141), KWidth(141)*19/141.0));
////        make.size.mas_equalTo(CGSizeMake(KWidth(126.9), KHeight(12.6)));
//    }];
    [thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(newloginButton.mas_bottom).mas_offset(KHeight(69));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
    }];
    self.thirdImage = thirdImage;
    
    //微信登录
    UIButton *thirdLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdLogin setBackgroundImage:[UIImage imageNamed:@"icon_login_weixin"] forState:UIControlStateNormal];
    
    [thirdLogin setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [thirdLogin addTarget:self action:@selector(loginWithWechat) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:thirdLogin];
     self.thirdLogin = thirdLogin;
    [thirdLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(thirdImage.mas_bottom).mas_offset(KHeight(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(40), KWidth(40)));
    }];
    
    
    UILabel *weixinLab = [[UILabel alloc]init];
    [bgView addSubview:weixinLab];
    weixinLab.text = @"微信";
    weixinLab.textColor = [UIColor getColor:@"7C838C"];
    weixinLab.font = Kfont(14);
    weixinLab.textAlignment = NSTextAlignmentCenter;
     self.weixinLab = weixinLab;
    [weixinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(thirdLogin.mas_bottom).mas_offset(KHeight(6));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(206), KHeight(26)));
        
    }];
    if (![WXApi isWXAppInstalled]) {
//        [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.mas_equalTo(newloginButton.mas_bottom).mas_offset(KHeight(735));
//            make.centerX.mas_equalTo(self.view.mas_centerX);
//            make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//        }];
        
         self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = YES;
    }else
    {
        
//        [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.mas_equalTo(newloginButton.mas_bottom).mas_offset(KHeight(69));
//            make.centerX.mas_equalTo(self.view.mas_centerX);
//            make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//        }];
         self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = NO;
    }
    
}

#pragma mark 判断是否登录了
- (void)isGoToLogin
{
     self.skipbutton.hidden = NO;
    //检查token是否失效
    if([UserInfoTool getLoginInfo].Token.length > 0)
    {
        [SingleTon shareInstance].token = [UserInfoTool getLoginInfo].Token;
        [SingleTon shareInstance].isLogin = YES;
        
        //检查token是否失效
        [CommonViewModel checkTokenIsFailureWithFinishedBlock:^(ResponseObject *response) {
            NSLog(@"---检查token是否失效-----");
            if (response.code != CodeTypeSucceed) {
                
                LoginViewController *login = [[LoginViewController alloc]init];
                [self presentViewController:login animated:YES completion:nil];
            }
        }];
    }
    
    if ([SingleTon shareInstance].isLogin)
    {
        NSLog(@"---isLogin登录了,直接登录-----");
        [self setRootViewController];
        
    }else
    {
        
         NSLog(@"---login登录-----");
        LoginViewController *login = [[LoginViewController alloc]initWithType:pageTypeNoNavigation];
        
        login.loginSuccess = ^(UIViewController *viewController) {
            
            [self setRootViewController];
        };
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//        nav.navigationBarHidden = YES;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = login;
    }
}

#pragma mark 设置rootViewController
- (void)setRootViewController
{
    TabbarController *tab = [[TabbarController alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = tab;
}

#pragma mark 加载引导页
- (void)loadGuidePageView
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
     WEAKSELF
    VDGifPlayerTool *addGif =  [[VDGifPlayerTool alloc]init];
    [addGif addGifWithName:@"welcome" toView:self.view];
    self.addGif = addGif;
    addGif.call_back = ^(BOOL dealloc) {
        if (dealloc == YES) {
            self.skipbutton.hidden = YES;
            [self createUI];
        }
    };
    self.skipbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipbutton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.skipbutton.titleLabel.font = Kfont(15);
    [self.skipbutton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipbutton setTitleColor:[UIColor getColor:@"B3BBC4"] forState:UIControlStateNormal];
    [self.skipbutton addTarget:self action:@selector(hiddenGuide:) forControlEvents:UIControlEventTouchUpInside];
    self.skipbutton.layer.cornerRadius = KHeight(45)/2.0;
    self.skipbutton.frame = CGRectMake(KScreenWidth - KWidth(106),  KHeight(15), KWidth(106), KHeight(45));
    [self.view addSubview:self.skipbutton];
}
-(void)hiddenGuide:(UIButton *)sender{
    [self.addGif remove];
//    WEAKSELF
//    GuideView * guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
//    [self.view addSubview:guideView];
//    [self.view bringSubviewToFront:guideView];
//
//    [guideView setHideGuideViewBlock:^{
//        weakSelf.guideView = nil;
//        [weakSelf isGoToLogin];
//    }];
//    self.guideView = guideView;
    [self isGoToLogin];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end