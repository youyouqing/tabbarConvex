//
//  XKBindMobileViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKBindMobileViewController.h"
#import "JPUSHService.h"
#import "EncryptionTool.h"
#import "TabbarController.h"
#import "AppDelegate.h"
#define TIME 100
@interface XKBindMobileViewController ()<UITextFieldDelegate>
{

     NSTimer *_timer;
     BOOL istimeOut;
    
}
@property (weak, nonatomic) IBOutlet UIView *phoneTFBackView;
@property (weak, nonatomic) IBOutlet UILabel *phoneTextLal;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (nonatomic,assign) CGFloat TimeCount;
@property (nonatomic,copy)NSString *codeStr;//存放密码--验证码
//电话号码输入正确
@property (nonatomic,assign)BOOL phoneWright;


@property (weak, nonatomic) IBOutlet UIView *passBigBackView;
@property (weak, nonatomic) IBOutlet UITextField *passTF;

@property (weak, nonatomic) IBOutlet UILabel *pswLab;

@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;

@property (nonatomic,strong) CADisplayLink *link;
@end

@implementation XKBindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitle = @"绑定手机号";
    
    [self createUI];
    
//      self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}


-(void)back{
    

    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}

-(void)createUI{


    self.phoneTFBackView.layer.cornerRadius = 5;
    self.phoneTFBackView.clipsToBounds = YES;
    self.phoneTFBackView.layer.borderWidth = 1.0;
    self.phoneTFBackView.layer.borderColor = [UIColor getColor:@"d8d8d8"].CGColor;
   
    
    self.phoneTF.backgroundColor = [UIColor clearColor];
    self.phoneTF.tintColor = kMainColor;//看不到光标
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTF.delegate = self;
    
    
    self.passBigBackView.layer.cornerRadius = 5;
    self.passBigBackView.clipsToBounds = YES;
    self.passBigBackView.layer.borderWidth = 1.0;
    self.passBigBackView.layer.borderColor = [UIColor getColor:@"d8d8d8"].CGColor;
//    self.passBigBackView.backgroundColor = [UIColor clearColor];
    self.passTF.tintColor = kMainColor;//看不到光标
   
    self.passTF.delegate = self;
    

    
    self.LoginBtn.layer.cornerRadius = self.LoginBtn.height/2;
    self.LoginBtn.clipsToBounds = YES;
     self.LoginBtn.enabled = NO;
    
   
    
  
    self.againBtn.layer.cornerRadius = self.againBtn.frame.size.height/2;
    self.againBtn.clipsToBounds = YES;
     self.againBtn.enabled = NO;

}
static NSString *const DESKey = @"xk@12580";

#pragma mark - 网络请求 --- 请求验证码
-(void)loadPassWordData
{
    NSLog(@"获取验证码");
    NSDictionary *dict=@{@"Token":@" ",@"LoginName":self.phoneTF.text};
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"100" parameters:dict success:^(id json) {
        [IanAlert hideLoading];
        NSLog(@"%@",json);
        
        NSDictionary *dic=[json objectForKey:@"Result"];
        NSString *codeString = [EncryptionTool decryptUseDES:[dic objectForKey:@"CaptchaCode"] key:DESKey];
        self.codeStr = codeString;
//        ShowErrorStatus(codeString);
        //提供给苹果审核平台的测试账号，给出一个弹窗提示验证码
        if ([self.phoneTF.text isEqualToString:@"13760440737"]) {
            UIAlertView  *alter = [[UIAlertView alloc]initWithTitle:@"验证码（Code）" message:codeString delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil];
            [alter show];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        
    }];
}
-(void)toRootViewController{
//    UIViewController *viewController = self;
//    while (viewController.presentingViewController) {
//        //判断是否为最底层控制器
//        if ([viewController isKindOfClass:[BaseViewController class]]) {
//            viewController = viewController.presentingViewController;
//        }else{
//            break;
//        }
//    }
//    if (viewController) {
//        [viewController dismissViewControllerAnimated:YES completion:nil];
//    }
    
    
//    UIViewController *rootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
//    while (rootViewController.presentedViewController)
//    {
//        rootViewController = rootViewController.presentedViewController;
//    }
//    [rootViewController dismissViewControllerAnimated:YES completion:nil];
    
     [self setRootViewController];
}
#pragma mark 设置rootViewController
- (void)setRootViewController
{
//    TabbarController *tab = [[TabbarController alloc]init];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.window.rootViewController = tab;
    
    UIViewController *vc = self.presentingViewController;
    
    if (!vc.presentingViewController)   {
        
        [vc dismissViewControllerAnimated:YES completion:nil];
        TabbarController *tab = [[TabbarController alloc]init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = tab;
        return ;
    };
    
    while (vc.presentingViewController)  {
        vc = vc.presentingViewController;
    }
    
    [vc dismissViewControllerAnimated:YES completion:nil];

}

-(void)loadLoginData
{
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {

             
             
             NSLog(@"%@"            ,user.credential.rawData[@"unionid"]);
             //绑定类型:1.微信  2.QQ  3.新浪微博  4.腾讯微博 5支付宝 6微信公众平台
             [ProtosomaticHttpTool protosomaticPostWithURLString:@"933" parameters:@{@"Token":@"",@"OpenId":user.credential.rawData[@"openid"],@"UnionId":user.credential.rawData[@"unionid"],@"BindType":@(self.bindType),@"Mobile":self.phoneTF.text} success:^(id json) {
                 
                 NSLog(@"933-------%@",json);
                 if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                     
                     [[XKLoadingView shareLoadingView] hideLoding];
                     
                     NSDictionary *dataDic = (NSDictionary *)json;
                     

                         //1、接口登录判断
                         if ([[NSString stringWithFormat:@"%@",dataDic[@"Basis"][@"Status"] ]isEqualToString:@"200"]) {
                             [[XKLoadingView shareLoadingView] hideLoding];
                             
                             //**推送--这个方法是设置别名和tag 可省
                             [JPUSHService setTags:nil alias:self.phoneTF.text fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                                 NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
                             }];
                             
                             //如果登录返回后 -- 注册标识(是1已经注册环信) -- 则让登录环信
                             if ([[NSString stringWithFormat:@"%@",dataDic[@"Result"][@"EasemobRegister"]] isEqualToString:@"1"]) {
                                 

                             }
//                             [SingleTon shareInstance].isLogin = YES;
//                             [SingleTon shareInstance].token = [json objectForKey:@"Result"];
                             //登录成功后--进入主页面
                             NSMutableDictionary *modelDic = [[NSMutableDictionary alloc]initWithDictionary:[json objectForKey:@"Result"]];
                             modelDic[@"isLogin"] = @1;
                             
                          
                             UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:modelDic];
                             [UserInfoTool saveLoginInfo:model];
//                             NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
//
//                             [center postNotificationName:@"home" object:nil];
//
                             [self toRootViewController];
                         }
                         else
                         {
                             
                             [[XKLoadingView shareLoadingView] errorloadingText:@"登录失败"];
                             
                         }
                         
                         
                     
                     
                     
                 }else{
                     
                      [self clearPassNum];//清空验证码输入框
                     
                     
                     [[XKLoadingView shareLoadingView]errorloadingText:nil];
                     
                 }
                 
             } failure:^(id error) {
                 
                 NSLog(@"%@",error);
                 [[XKLoadingView shareLoadingView]errorloadingText:nil];
                 
                 
             }];
             
             
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
    
}
- (IBAction)checkPSwBtn:(id)sender {
    
    
    
    if ([Judge validateMobile:self.phoneTF.text]&& self.phoneTF.text.length >0) {
        
        
            [self loadPassWordData];//获取验证码，请求
            [self startTime];
        
            [self.passTF becomeFirstResponder];
        
        
        }
    
    
    else{
        
       
        if ( self.phoneTF.text.length == 0) {
            
            [self phoneWrong:@"电话号码输入有错"];
            
        }else{
            if ( [Judge validateMobile:self.phoneTF.text]) {
                [self.view endEditing:YES];
            }else{
                [self phoneWrong:@"电话号码输入有错"];
            }
        }
    }
 
    
    
}
#pragma mark - 验证码输入判断操作
- (IBAction)getPassWordBtn:(UIButton *)sender {
    
    
 
    
            
        [self.view endEditing:YES];
        
        if ([self.passTF.text isEqualToString:self.codeStr] && istimeOut == NO) {
            //密码正确
            NSLog(@"密码正确,登录");
            [self loadLoginData];
            
        }else{
            
            if (self.passTF.text.length == 0) {
                NSLog(@"验证码为空");
                [self passWordIsNullTip];
                return;
            }
            
            //密码错误
            NSLog(@"密码错误");
            [self clearPassNum];//清空验证码输入框
           
        }
            
    
    
    
}
//密码为空时提示
-(void)passWordIsNullTip
{
 
    ShowErrorStatus(@"密码不能为空");
}
//清空验证码输入框
-(void)clearPassNum
{
    [self.passTF becomeFirstResponder];
    
   
    ShowErrorStatus(@"密码错误请重新输入");
    self.passTF.text = @"";
    
    [self editingPhone2:self.pswLab];
    self.LoginBtn.backgroundColor = [UIColor getColor:@"cacaca"];//当开始输入的时候，按钮就是确定换绑
    self.LoginBtn.enabled = NO;
    
}
//开始编辑时触发，文本字段将成为first responder
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    
//    if (textField == self.phoneTF) {
//        if (self.phoneTF.text.length>0) {
//            [self editingPhone:self.phoneTextLal];
//        }
//       
//        
//        
//    }else{
//        
//        [self editingPhone:self.pswLab];
//        
//    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
    if (textField == self.phoneTF) {
        //判断是否展开，如果已经展开，则不存在，phoneTF无内容时，提示下移“手机号码”,提示手机号码有误；若未展开则可
        
            if (textField.text.length == 0) {
               self.phoneTextLal.hidden = NO;
                self.againBtn.enabled = NO;
                self.againBtn.backgroundColor = [UIColor getColor:@"cacaca"];
              
            }else{
                
                if ([Judge validateMobile:self.phoneTF.text]&&self.phoneTF.text > 0) {
                    //电话正确
                    [self phoneRight];
                    self.againBtn.enabled = YES;
                    self.againBtn.backgroundColor = kMainColor;
                }else{
                    //电话错误
                    [self phoneWrong:@"电话号码输入有错"];
                    self.againBtn.enabled = NO;
                    self.againBtn.backgroundColor = [UIColor getColor:@"cacaca"];
                    
                }
            }
       
            
    
       
        
    }else{
        
        if (textField.text.length == 0) {
            self.pswLab.hidden = NO;
            
        }else{
            
            if (self.passTF.text.length == 4) {
                //电话正确
                if ([Judge validateMobile:self.phoneTF.text]&&self.phoneTF.text > 0) {
                    self.LoginBtn.enabled = YES;
                    self.LoginBtn.backgroundColor = kMainColor;
                }
                
            }else{
                //电话错误
                [self phoneWrong:@"验证码输入有错"];
                
                self.LoginBtn.enabled = NO;
                self.LoginBtn.backgroundColor = [UIColor getColor:@"cacaca"];
            }
        }

        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF) {
        if (self.phoneTF.text.length==10) {
            
             self.againBtn.backgroundColor = kMainColor;
        }else
        {
             self.againBtn.backgroundColor = [UIColor getColor:@"cacaca"];
            
        }
        
        if (string.length>0) {
            [self editingPhone:self.phoneTextLal];
        }else if(string.length == 0&&self.phoneTF.text.length==1)
        {
        
           [self editingPhone2:self.phoneTextLal];
        
        }
       
        if (range.location > 10) {
            return NO;
        }
        return YES;
        
    }else{
        if (string.length>0) {
            [self editingPhone:self.pswLab];
        }else if(string.length == 0&&self.passTF.text.length==1)
        {
            
            [self editingPhone2:self.pswLab];
            
        }
        
        
          self.LoginBtn.enabled = NO;

        if (range.location < 4) {
            if (range.location == 3&&string.length!=0) {
                self.LoginBtn.backgroundColor = kMainColor;//当开始输入的时候，按钮就是确定换绑self.passTF.text.length == 4
                self.LoginBtn.enabled = YES;
                return YES;
            }
            self.LoginBtn.backgroundColor = [UIColor getColor:@"cacaca"];//当开始输入的时候，按钮就是确定换绑
            self.LoginBtn.enabled = NO;

            return YES;
        }

       
        else{

            self.LoginBtn.backgroundColor = kMainColor;//当开始输入的时候，按钮就是确定换绑self.passTF.text.length == 4
            self.LoginBtn.enabled = YES;
            return NO;//大于4位数，就不可编辑
        }
        
    }
}
-(void)startTime{
    
    //构建计时器的方法，放在需要触发动画事件之中
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(run)];
    
    _link.frameInterval = 1;
    
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
   
}

-(void)run{
    CGFloat nowSec = _TimeCount/60.0 ;//当前的秒
   
   
    //屏幕1秒执行60次**
    if (_TimeCount >= TIME * 60) {
        
        self.againBtn.enabled = YES;
        _link.paused = YES;//销毁计时器
        [_link invalidate];
        _link = nil;
        
        //设置界面的按钮显示 根据自己需求设置
        self.againBtn.hidden = NO;//隐藏重新发送验证码按钮
        _TimeCount = 0;//时间
        istimeOut = YES;
        
        //获取验证码
        
        [self.againBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        }
    else{
        self.againBtn.enabled = NO;
        _TimeCount++;
        [self.againBtn setTitle:[NSString stringWithFormat:@"%.0fs",TIME -nowSec] forState:UIControlStateNormal] ;
        istimeOut = NO;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark- 替换输入框
-(void)editingPhone:(UILabel *)lab
{
    [UIView animateWithDuration:0.15 animations:^{
       lab.hidden = YES;
      
        
    }];
}
-(void)editingPhone2:(UILabel *)lab
{
    [UIView animateWithDuration:0.15 animations:^{
        lab.hidden = NO;
        
        
    }];
}
-(void)phoneWrong:(NSString *)phoneStr
{
    [UIView animateWithDuration:0.15 animations:^{
        self.phoneTextLal.hidden = YES;
        
    }];
  
    ShowErrorStatus(phoneStr);
}

-(void)phoneRight
{
    [UIView animateWithDuration:0.15 animations:^{
       self.phoneTextLal.hidden = YES;
       
        
    }];
}
-(void)dealloc
{
  
    _timer = nil;
    [_timer invalidate];
    _link.paused = YES;//销毁计时器
    [_link invalidate];
    _link = nil;
    
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
