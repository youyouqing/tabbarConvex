//
//  LoginViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/6/29.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "LoginViewController.h"
#import "TabbarController.h"
#import "AppDelegate.h"
#import "LoginViewModel.h"
#import "XKBindMobileViewController.h"
#import "AdvertisingScrolllView.h"
#import "JPUSHService.h"
#import "EncryptionTool.h"
#import "Judge.h"
#import <MZTimerLabel.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
///短信验证码DES解密的秘钥
static NSString *const DESKey = @"xk@12580";

@interface LoginViewController () <MZTimerLabelDelegate,UITextFieldDelegate>
{
    
    BOOL isTop;//判断提示是否在上面
    BOOL phone_need_up;
    BOOL phone_need_down;
    
    BOOL code_need_top;
    BOOL code_need_down;
    
    BOOL is_phone_top;
    BOOL is_code_top;
    
    BOOL is_phone_error;
}
@property (nonatomic, weak)IBOutlet UILabel *lineOne;
@property (nonatomic, weak)IBOutlet UILabel *lineTwo;
@property (nonatomic, weak)IBOutlet UITextField *phoneText;
@property (nonatomic, weak)IBOutlet UITextField *codeText;//手机验证码输入框
@property (nonatomic, strong) UIButton *getMSMCodeButton;//获取验证码按钮
@property (nonatomic, strong) MZTimerLabel *timer;//用来倒计时
@property (nonatomic, weak)IBOutlet UILabel *pswLab;
@property (nonatomic, weak)IBOutlet UILabel *phoneLab;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong)UIImageView *thirdImage;
@property (nonatomic, strong)UIButton *thirdLogin;
@property (nonatomic, strong)UILabel *weixinLab;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLoginUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![WXApi isWXAppInstalled]) {
        if (self.loginButton) {
//            [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//                make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(KHeight(735));
//                make.centerX.mas_equalTo(self.view.mas_centerX);
//                make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//            }];
            
         self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = YES;
           
        }
        
        
        
    }else
    {
        if (self.loginButton) {
            self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = NO;

//            [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//                make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(KHeight(35));
//                make.centerX.mas_equalTo(self.view.mas_centerX);
//                make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//            }];
        }
    }
}

#pragma UI
- (void)setLoginUI
{
    UIButton *getMSMCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getMSMCodeButton.titleLabel.font = Kfont(15);
    [getMSMCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getMSMCodeButton setTitleColor:[UIColor getColor:@"03C7FF"] forState:UIControlStateNormal];
    getMSMCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [getMSMCodeButton addTarget:self action:@selector(getMSMCodeWithNetWorking) forControlEvents:UIControlEventTouchUpInside];
    getMSMCodeButton.layer.cornerRadius = KHeight(40)/2.0;
    getMSMCodeButton.clipsToBounds = YES;
    getMSMCodeButton.layer.borderWidth = 1.f;
    getMSMCodeButton.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    [self.view addSubview:getMSMCodeButton];
    self.getMSMCodeButton = getMSMCodeButton;
    [getMSMCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.lineTwo.mas_bottom).mas_offset(-KHeight(7));
        make.right.mas_equalTo( -KWidth(24));//- KWidth(200)
        make.size.mas_equalTo(CGSizeMake(KWidth(98), KHeight(40)));
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.layer.cornerRadius = KHeight(45)/2.0;
    loginButton.clipsToBounds = YES;
    //    loginButton.layer.borderWidth = 1.f;
    //    loginButton.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    loginButton.titleLabel.font = Kfont(19);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginActionWithNetWorking) forControlEvents:UIControlEventTouchUpInside];
    loginButton.backgroundColor = [UIColor getColor:@"03C7FF"];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(getMSMCodeButton.mas_bottom).mas_offset(KHeight(55));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(45));
        make.left.mas_equalTo(KWidth(24));
        make.right.mas_equalTo(-KWidth(24));
    }];
    self.loginButton = loginButton;
    
    
    UIImageView *thirdImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iv_login_disanfang"]];
    [self.view addSubview:thirdImage];
//    [thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(loginButton.mas_bottom).mas_offset(KHeight(55));
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(KWidth(141), );//KWidth(141)*19/141.0)
//    }];
  [thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {

      make.top.mas_equalTo(loginButton.mas_bottom).mas_offset(KHeight(35));
      make.centerX.mas_equalTo(self.view.mas_centerX);
      make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
  }];
    self.thirdImage = thirdImage;
    
    //微信登录
    UIButton *thirdLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdLogin setBackgroundImage:[UIImage imageNamed:@"icon_login_weixin"] forState:UIControlStateNormal];
    
    [thirdLogin setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [thirdLogin addTarget:self action:@selector(loginWithWechat) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:thirdLogin];
    self.thirdLogin = thirdLogin;
    [thirdLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(thirdImage.mas_bottom).mas_offset(KHeight(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(40), KWidth(40)));
    }];
    
    
    UILabel *weixinLab = [[UILabel alloc]init];
    [self.view addSubview:weixinLab];
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
//            make.top.mas_equalTo(loginButton.mas_bottom).mas_offset(KHeight(735));
//            make.centerX.mas_equalTo(self.view.mas_centerX);
//            make.size.mas_equalTo(CGSizeMake(KWidth(0), KHeight(0)));
//        }];
        
        self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = YES;

    }else
    {
        self.weixinLab.hidden =  self.thirdImage.hidden =  self.thirdLogin.hidden = NO;

//        [ self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.mas_equalTo(loginButton.mas_bottom).mas_offset(KHeight(35));
//            make.centerX.mas_equalTo(self.view.mas_centerX);
//            make.size.mas_equalTo(CGSizeMake(KWidth(141), KHeight(14)));
//        }];
        
    }
    
}

#pragma mark NetWorking
///登录
- (void)loginActionWithNetWorking
{
    [self.view endEditing:YES];
    
    if (self.phoneText.text.length != 11) {
        ShowErrorStatus(@"请输入正确的手机号");
        return;
    }

    if (self.codeText.text.length == 0) {
        ShowErrorStatus(@"请输入验证码");
        return;
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"--main_data---%@",[user objectForKey:@"main_data"]);
     id  tempDic = [user objectForKey:@"main_data"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSDictionary *tempdic = [[NSDictionary alloc]init];
    if ([tempDic isKindOfClass:[NSDictionary class]])
     {
         NSString *birthday = tempDic[@"birthday"];
         NSString *timeSp = @"";
         if (birthday.length>0) {
             NSDate *defaultDate = [dateFormatter dateFromString:birthday];
             timeSp = [NSString stringWithFormat:@"%ld", (long)[defaultDate timeIntervalSince1970]*1000];
         }
         NSArray *temp = tempDic[@"QuestionAnswerList"];
         NSString *planIDStr = tempDic[@"PlanID"];
         NSString *height = tempDic[@"height"];
         NSString *weight = tempDic[@"weight"];
         
          tempdic =  @{@"LoginName":self.phoneText.text,
                               @"PassWord":self.codeText.text,
                               @"Token":@" ",
                               @"IsSkip":@([tempDic[@"IsSkip"] isEqualToString:@"1"]?1:0),
                               @"PlanID":planIDStr.length>0?tempDic[@"PlanID"]:@"",
                               @"Height":height?tempDic[@"height"]:@"",
                               @"Weight":weight.length>0?tempDic[@"weight"]:@"",
                               @"Sex": @([tempDic[@"sex"] isEqualToString:@"wowen"]?1:0),
                               @"BirthDay":timeSp,
                               @"QuestionAnswerList":temp.count>0?tempDic[@"QuestionAnswerList"]:[NSArray array]
                               
                               };
    }else
    {
        tempdic =  @{@"LoginName":self.phoneText.text,
                     @"PassWord":self.codeText.text,
                     @"Token":@" ",
                     @"IsSkip":@0,
                     @"PlanID":@" ",
                     @"Height":@0,
                     @"Weight":@0,
                     @"Sex": @(-1),
                     @"BirthDay":@"",
                     @"QuestionAnswerList":@[@{@"GuideQuestionID":@0,@"QuestionAnswerID":@0}]
                     
                     };
        
        
    }
   NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:tempdic];
   
   
  
    NSLog(@"正在登陆.:%@",dic);
    ShowNormailMessage(@"正在登陆...");
    [LoginViewModel loginActionWithParams:dic FinishedBlock:^(ResponseObject *response) {
       
        DismissHud();
        if (response.code == CodeTypeSucceed) {
            //**推送--这个方法是设置别名和tag 可省
            [JPUSHService setTags:nil alias:self.phoneText.text fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
            }];
            //保存用户手机号
            [UserInfoTool saveUserPhone:self.phoneText.text];
            
//            if (self.presentingViewController) {//  这是为了改成哪退出d登录，哪里再重新登录进去
//
//                [self dismissViewControllerAnimated:YES completion:nil];
//
//            }else{
//
//                if (self.loginSuccess)
//                {
//                    self.loginSuccess(self);
//                }
//            }
            TabbarController *tab = [[TabbarController alloc]init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = tab;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"" forKey:@"main_data"];
            [user synchronize];
        }else {
            
            ShowErrorStatus(response.msg);
            
        }
    }];
}

///获取验证码
- (void)getMSMCodeWithNetWorking
{
    [self.view endEditing:YES];
    
    if (self.phoneText.text.length != 11) {
        
        ShowErrorStatus(@"请输入正确的手机号码");
        return;
    }
     if ([Judge validateMobile:self.phoneText.text] == NO) {
         ShowErrorStatus(@"请输入正确的手机号码");
         return;
     }
    NSDictionary *dic = @{@"LoginName":self.phoneText.text,
                          @"Token":@""
                          };
    
    ShowNormailMessage(@"获取验证码...");
    //启动倒计时
    [self startCountDownTimer];
    [LoginViewModel getLoginMSMCodeParams:dic FinishedBlock:^(ResponseObject *response) {
        
        DismissHud();
        if (response.code == CodeTypeSucceed) {
            
            ShowSuccessStatus(@"获取验证码成功");
            NSString *codeString = [EncryptionTool decryptUseDES:response.Result[@"CaptchaCode"] key:DESKey];
            NSLog(@"---code------%@",codeString);
            

          
//              ShowErrorStatus(codeString);
            
            //提供给苹果审核平台的测试账号，给出一个弹窗提示验证码
            if ([self.phoneText.text isEqualToString:@"13760440737"])
            {
//                [AlertView showMessage:codeString withTitle:@"验证码" sureButtonTitle:@"确认"];
                [self.codeText becomeFirstResponder];
                self.codeText.text = codeString;
                [self.codeText resignFirstResponder];
            }
            
        }else{
            
            ShowSuccessStatus(response.msg);
            
        }
        
    }];
}

///第三方微信登录
- (void)loginWithWechat
{
    [self.view endEditing:YES];
    if (![WXApi isWXAppInstalled]) {
        
        
        
        if ([self.phoneText.text isEqualToString:@"13760440737"]) {
            
            
            
            
            return;
        }
        
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
            
//            if (self.presentingViewController) {//  这是为了改成哪退出d登录，哪里再重新登录进去
//
//                [self dismissViewControllerAnimated:YES completion:nil];
//
//            }else{
//
//                if (self.loginSuccess)
//                {
//                    self.loginSuccess(self);
//                }
//            }
            TabbarController *tab = [[TabbarController alloc]init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = tab;
            
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

#pragma mark Action
- (void)startCountDownTimer
{
    if (!self.timer) {
        MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.getMSMCodeButton.titleLabel andTimerType:MZTimerLabelTypeTimer];
        timer.timeFormat = @"ss";
        self.timer = timer;
        timer.delegate = self;
        self.getMSMCodeButton.layer.borderWidth = 0.f;
        
    }
    self.getMSMCodeButton.enabled = NO;
    [self.timer setCountDownTime:60];
    [self.timer start];
   
}

- (void)textFieldDidChange
{
    if (self.phoneText.text.length > 11)
    {
        self.phoneText.text = [self.phoneText.text substringToIndex:11];
    }
}
#pragma mark - UITextFieldDelegate
//开始编辑时触发，文本字段将成为first responder
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    if (textField == self.phoneText) {
        
        if (textField.text.length == 0) {
            phone_need_up = YES;
            phone_need_down = NO;
        }
        [self editingPhone];
        [self phoneRight];
    }else{
        self.lineTwo.backgroundColor = MainCOLOR;
        self.lineOne.backgroundColor = [UIColor getColor:@"E2E2E2"];
        if (textField.text.length == 0) {
            code_need_top = YES;
            code_need_down = NO;
        }
    }
    [self up_down];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField == self.phoneText) {
        if (self.codeText.text.length == 0) {
            code_need_top = NO;
            code_need_down = YES;
        }
        if (textField.text.length == 0) {
            
            phone_need_up = NO;
            phone_need_down = YES;
        }
        if (textField.text.length > 0)
        {
            if ([Judge validateMobile:textField.text]) {
                //电话正确
                
                [self phoneRight];
            }else{
                //电话错误
                
                [self phoneWrong];
            }
            
        }
    } else{
        
        if (textField.text.length == 0) {
            code_need_top = NO;
            code_need_down = YES;
        }
        if (self.phoneText.text.length == 0) {
            phone_need_up = NO;
            phone_need_down = YES;
        }
        
        
        
    }
    [self up_down];
    
    
    
}

-(void)phoneWrong
{
    is_phone_error = YES;
}

-(void)phoneRight
{
    is_phone_error = NO;
}
-(void)editingPhone
{
    [UIView animateWithDuration:0.15 animations:^{
        self.lineOne.backgroundColor = MainCOLOR;
        self.lineTwo.backgroundColor = [UIColor getColor:@"E2E2E2"];
        
        
    }];
}
-(void)TipMoveUp:(BOOL)ret lab:(UILabel *)lab text:(UITextField *)text;
{
    [self.view layoutIfNeeded];
    if (ret) {
        //        if (!isTop) {
        //上移
        [UIView animateWithDuration:0.2 animations:^{
            
            
            lab.y = text.y - 26;
        }];
        //        }
        //        isTop = YES;
    }else{
        //        if (isTop) {
        
        //下移
        [UIView animateWithDuration:0.15 animations:^{
            
            
            lab.y = text.y;
            
            
            //                self.phoneLab.font = [UIFont systemFontOfSize:17];
        }];
        //        }
        //        isTop = NO;
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneText) {
        [self editingPhone];
        
        
        if (range.location > 10) {
            return NO;
        }
        
        return YES;
        
    }else  {
        //当开始输入的时候，按钮就是确定换绑
        if (range.location > 3) {
            return NO;
        }
        return YES ;
        
    }
    
    
}

#pragma mark MZTimerLabel Delegate
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
//    self.getMSMCodeButton.titleLabel.text = @"重新发送";
     [self.getMSMCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
    self.getMSMCodeButton.enabled = YES;
    self.getMSMCodeButton.layer.borderWidth = 1.f;
    [self.timer reset];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)up_down
{
    if (phone_need_up && !is_phone_top) {
        [self TipMoveUp:YES lab:self.phoneLab text:self.phoneText];
        is_phone_top = YES;
    }
    if (phone_need_down && is_phone_top) {
        [self TipMoveUp:NO lab:self.phoneLab text:self.phoneText];
        is_phone_top = NO;
    }
    if (code_need_top && !is_code_top) {
        [self TipMoveUp:YES lab:self.pswLab text:self.codeText];
        is_code_top = YES;
    }
    if (code_need_down && is_code_top) {
        [self TipMoveUp:NO lab:self.pswLab text:self.codeText];
        is_code_top = NO;
    }
    if (is_phone_error) {
        self.phoneLab.text = @"手机号码错误";
        self.phoneLab.textColor = [UIColor getColor:@"FF4564"];
    }else{
        self.phoneLab.text = @"请输入手机号";
        self.phoneLab.textColor = [UIColor getColor:@"7C838C"];
    }
    phone_need_up = phone_need_down =code_need_top=code_need_down =NO;
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
