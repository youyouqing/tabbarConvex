//
//  XKSpShareViewController.m
//  Test
//
//  Created by xiekang on 2017/9/13.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "XKSpShareViewController.h"
#import "UIView+Frame.h"
#import "XKSpHistoryModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <CoreMotion/CoreMotion.h>

@interface XKSpShareViewController ()

@property (nonatomic, strong) CMPedometer *pedometer;//记步器

/**
 背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

/**
 时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

/**
 配速描述标签
 */
@property (weak, nonatomic) IBOutlet UIButton *speedMarkLab;

/**
 步数、里程标签
 */
@property (weak, nonatomic) IBOutlet UILabel *acountLab;

/**
配速标签
 */
@property (weak, nonatomic) IBOutlet UILabel *speedLab;

/**
 超越用户标签
 */
@property (weak, nonatomic) IBOutlet UILabel *overUserLab;

/**
 消耗实物标签
 */
@property (weak, nonatomic) IBOutlet UILabel *hotLab;

/**
 消耗卡路里标签
 */
@property (weak, nonatomic) IBOutlet UILabel *caloriesLab;

/**
 展示数据容器
 */
@property (weak, nonatomic) IBOutlet UIView *dataContainerView;

@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImg;

/**
 返回按钮头部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bacBtnTopCons;

/**
 整个视图容器的高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dataViewHeightCons;

/**
 第一个标签头部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneLabTopcons;

/**
 数据容器中心约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datacenterCons;

/**二维码距离地图的约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qrBottomCons;
@property (weak, nonatomic) IBOutlet UIButton *shareUsButton;

@end

@implementation XKSpShareViewController

/**记不起懒加载*/
- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

/**返回按钮的操作*/
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**分享按钮的操作*/
- (IBAction)shareAction:(id)sender {
    NSLog(@"分享");
    NSArray *imageArray = @[[self getImage]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"" images:[self getImage] url:nil title:@"携康e加" type:SSDKContentTypeImage];
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
    self.shareUsButton.hidden = YES;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenWidth, [UIApplication sharedApplication].keyWindow.height), NO, 0);  //NO，YES 控制是否透明
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    self.shareUsButton.hidden = NO;
    return image;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden=NO;

[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"button-bg"] forBarMetrics:UIBarMetricsDefault];
[self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"button-bgTwo"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


NSString *distanceStr5;
NSString *distanc5;
float dis5;
int steps5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.shareUsButton.layer.cornerRadius = self.shareUsButton.height/2.0;
    self.shareUsButton.clipsToBounds = YES;
    if (IS_IPHONE5) {
        self.dataViewHeightCons.constant = 410;
        self.oneLabTopcons.constant = 10;
        self.datacenterCons.constant = -10;
        self.qrBottomCons.constant = 10;
    }
    
    if (_spStyle == 4) {
//        self.backImage.image = [UIImage imageNamed:@"sport_pic_riding"];
        
        [self.speedMarkLab setImage:[UIImage imageNamed:@"sport_speed"] forState:UIControlStateNormal];
        self.dataContainerView.backgroundColor = [UIColor getColor:@"2b3a3d"];
        [self.speedMarkLab setTitle:@"时速" forState:UIControlStateNormal];
        
        [self loadData];
    }
    else if (_spStyle == 2) {
//        self.backImage.image = [UIImage imageNamed:@"sport_running"];
        [self.speedMarkLab setImage:[UIImage imageNamed:@"sport_speed"] forState:UIControlStateNormal];
        self.dataContainerView.backgroundColor = [UIColor getColor:@"0168ab"];
        [self.speedMarkLab setTitle:@"配速" forState:UIControlStateNormal];
        
        [self loadData];
        
    }
    else
    {
//        self.backImage.image = [UIImage imageNamed:@"sport_pic_step"];
        
        [self.speedMarkLab setImage:[UIImage imageNamed:@"sport_mileage"] forState:UIControlStateNormal];
        
        [self.speedMarkLab setTitle:@"里程" forState:UIControlStateNormal];
        
        self.dataContainerView.backgroundColor = [UIColor getColor:@"3d4d5f"];
        
       //显示本地信息
        [self showLoctionMessage];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 1.判断计步器是否可用
            if (![CMPedometer isStepCountingAvailable]) {
                
                return;
            }
            
            //统计某天的
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *todayDateStr = [dateFormatter stringFromDate:[NSDate date]];
            
            NSString *beginDateStr = [todayDateStr stringByAppendingString:@"-00-00-00"];
            
            //字符转日期
            NSDateFormatter *beginDateFormatter = [[NSDateFormatter alloc] init];
            [beginDateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
            NSDate *beginDate = [beginDateFormatter dateFromString:beginDateStr];
            //  [NSDate dateWithTimeInterval:-24*60*画60 sinceDate:[NSDate date]];当你的步数有更新的时候，会触发这个方法，这个方法不会和时时返回结果，每次刷新数据大概在一分钟左右
            [self.pedometer startPedometerUpdatesFromDate:beginDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                
                if (error) {
                    
                    // //不可用也可以查询数据           NSLog(@"%@",error);
                    //             [self loadSetpData];
                    NSLog(@"查询有误");
                    return;
                }
                
                //距离字符串
                distanceStr5 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
                distanc5=[NSString stringWithFormat:@"%@",pedometerData.distance];
                dis5=[distanceStr5 floatValue];
                steps5 = [distanceStr5 intValue];
                self.step.StepCount = steps5;
                self.step.KilometerCount = [[NSString stringWithFormat:@"%.2lf",dis5/1000] floatValue];
                self.step.KilocalorieCount = [[NSString stringWithFormat:@"%.2lf",dis5/1000*65] floatValue];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //显示本地信息
                    [self showLoctionMessage];
                    
                });
                
            }];
        });
        
        
        [self loadData];
    }
}

/**显示本地信息方法*/
-(void)showLoctionMessage{
    //显示本地信息
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@步",[NSNumber numberWithInteger:self.step.StepCount]] withBigFont:40 withNeedchangeText:@"步" withSmallFont:13]];
    
    [self.speedLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@公里",[NSNumber numberWithFloat:self.step.KilometerCount]] withBigFont:40 withNeedchangeText:@"公里" withSmallFont:13]];
    
    if (self.step.StepCount<=0 || !self.step.StepCount) {
        self.hotLab.text=@"今日还没有运动哦!";    }
    
    if (self.step.StepCount>0&&self.step.StepCount<2000) {
        self.hotLab.text=@"今日运动不足";
    }
    
    if (self.step.StepCount>=2000&&self.step.StepCount<4000) {
        self.hotLab.text=@"消耗了2块饼干的热量哦!";
    }
    
    if (self.step.StepCount>=4000&&self.step.StepCount<6000) {
        self.hotLab.text=@"消耗了一盒薯条的热量哦！";
    }
    
    if (self.step.StepCount>=6000&&self.step.StepCount<8000) {
        self.hotLab.text=@"消耗了2个炸鸡腿的热量哦！";
    }
    if (self.step.StepCount>=8000&&self.step.StepCount<12000) {
        self.hotLab.text=@"消耗了1个汉堡包的热量哦！";
    }
    if (self.step.StepCount>=12000) {
        self.hotLab.text=@"太棒了，你今天已经达到了目标了";
    }
}

-(void)loadData{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    dict[@"Token"] = [UserInfoTool getLoginInfo].Token;
    dict[@"StepManageID"] = @(self.StepManageID);
    dict[@"MemberID"] = @([UserInfoTool getLoginInfo].MemberID);
    if (self.step) {
        dict[@"StepCount"] = [NSString stringWithFormat:@"%li",self.step.StepCount];
        dict[@"KilometerCount"] = [NSString stringWithFormat:@"%.1lf",self.step.KilometerCount];
        dict[@"KilocalorieCount"] = [NSString stringWithFormat:@"%.1lf",self.step.KilocalorieCount];
    }else{
        dict[@"StepCount"] = @"0";
        dict[@"KilometerCount"] = @"0.0";
        dict[@"KilocalorieCount"] = @"0.0";
    }
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"342" parameters:dict success:^(id json) {
        
//        NSLog(@"342:%@---%@",json,@{@"Token":[UserInfoTool getLoginInfo].Token,@"StepManageID":@(self.StepManageID),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"StepCount":[NSString stringWithFormat:@"%li",self.step.StepCount],@"KilometerCount":[NSString stringWithFormat:@"%.1lf",self.step.KilometerCount],@"KilocalorieCount":[NSString stringWithFormat:@"%.1lf",self.step.KilocalorieCount]});
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            XKSpHistoryModel *model = [XKSpHistoryModel objectWithKeyValues:json[@"Result"]];
            self.timeLab.text = model.strTime;
            [self.caloriesLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@Kcal",[NSNumber numberWithFloat:model.KilocalorieCount]] withBigFont:40 withNeedchangeText:@"Kcal" withSmallFont:13]];
            
            if (self.spStyle != 1) {
                [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%@公里",[NSNumber numberWithFloat:model.KilometerCount]] withBigFont:40 withNeedchangeText:@"公里" withSmallFont:13]];
                self.speedLab.text = model.AvgPace;
                
                NSString *str = model.AvgPace;
                NSArray *array = [str componentsSeparatedByString:@"&#39;"];
                str = [NSString stringWithFormat:@"%@'%@",array[0],array[1]];
                self.speedLab.text = str;
                
                if (model.KilocalorieCount <= 0) {
                    self.hotLab.text=@"今日还没有运动哦!";
                }
                
                if (model.KilocalorieCount>=1&&model.KilocalorieCount<=100) {
                    self.hotLab.text=@"消耗了1个鸡蛋的热量!";
                }
                
                if (model.KilocalorieCount>=101&&model.KilocalorieCount<=300) {
                    self.hotLab.text=@"消耗了2包炸薯条的热量哦!";
                }
                
                if (model.KilocalorieCount>=301&&model.KilocalorieCount<=500) {
                    self.hotLab.text=@"消耗了2个鸡腿的热量哦！";
                }
                
                if (model.KilocalorieCount>=501&&model.KilocalorieCount<=800) {
                    self.hotLab.text=@"消耗了2个馒头的热量哦！";
                }
                if (model.KilocalorieCount>=801&&model.KilocalorieCount<=1500) {
                    self.hotLab.text=@"消耗了2个汉堡的热量哦！";
                }
                if (model.KilocalorieCount>=1500) {
                    self.hotLab.text=@"消耗了1只烤鸭的热量哦!";
                }

                
            }else{
               
            }
            
            self.overUserLab.text = [NSString stringWithFormat:@"超越了 %li%@ 的用户",model.Ranking,@"%"];
            [self.qrcodeImg sd_setImageWithURL:[NSURL URLWithString:model.WechatImg] placeholderImage:[UIImage imageNamed:@"xk_sportsShareQrcode"]];
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:error];
        
        
    }];
    
    
}

@end
