//
//  AppDelegate.m
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AppDelegate.h"
#import "QingNiuSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "UMMobClick/MobClick.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "advertisementController.h"
#import "XKRemoteMessageController.h"
#import <BaiduTraceSDK/BaiduTraceSDK.h>
#import "FriendMessageController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "VersionHelp.h"
#import "HealthRecordController.h"
#import "GoHealthTaskController.h"
#import "HealthRecordController.h"
#import "XKGoSportRemindView.h"
#import "BaseNavigationViewController.h"
//微信SDK头文件
#import "WXApi.h"
#import "SportViewController.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate () <WXApiDelegate,JPUSHRegisterDelegate>
@property (nonatomic,strong)VersionHelp *help;
@end

@implementation AppDelegate
//获取当前时间戳  （以毫秒为单位）
+(NSTimeInterval )getNowTimeTimestamp3{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSTimeInterval timeSp =  (long)[datenow timeIntervalSince1970]*1000;
    NSLog(@"获取当前时间戳%f",timeSp);
    return timeSp;
}
#pragma mark -检查版本更新的情况
-(void)takeServericeVersion{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    
    NSTimeInterval interval = [AppDelegate getNowTimeTimestamp3];//[[NSDate date] timeIntervalSince1970] * 1000;//获取的时间戳
    //
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    //读取缓存信息
    self.help=[VersionHelp getSystemVersion];
    
    NSInteger lastTime=[defaults objectForKey:@"preJionTimeInterval"]?[[defaults objectForKey:@"preJionTimeInterval"] integerValue]:0;
    
    NSInteger newHourInterver=(self.help.IntervalTime?self.help.IntervalTime:0);
    
    NSInteger reusltTimeInterval=interval-(lastTime+newHourInterver*60*60*1000);
    
    if (self.help&&self.help.Status==2) {
        
        [self makeUpagetVersion];
        
    }else{
        if (reusltTimeInterval>=0) {//通过时间戳判断 大于重新调用接口获取数据
            NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@" ",@"VersionType":@"1",@"VersionNo":appCurVersion};
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"202" parameters:dict success:^(id json) {
                
                NSLog(@"-----202%@",json);
                
                if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                    
                    NSMutableDictionary *dict=[json objectForKey:@"Result"];
                    
                    if (![dict objectForKey:@"UpdateLog"]) {
                        
                        dict[@"UpdateLog"]=@"无";
                        
                    }
                    
                    if (![dict objectForKey:@"UploadAddress"]) {
                        dict[@"UploadAddress"]=@"无";
                    }
                    
                    //缓存信息
                    [VersionHelp setSystemVersion:dict];
                    
                    //读取缓存信息
                    self.help=[VersionHelp getSystemVersion];
                    
                    if (self.help.Status!=0) {
                        
                        if (self.help.Status==1) {//普通更新
                            
                            UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"发现新版本" message:self.help.UpdateLog preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *action1=[UIAlertAction actionWithTitle:@"忽略此版本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            
                            
                            UIAlertAction *aciton2=[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                
                                UIApplication *app = [UIApplication sharedApplication];
                                
                                // 2.创建要打开的应用程序的URL
                                NSURL *url = [NSURL URLWithString:self.help.UploadAddress];
                                
                                // 3.判断是否可以打开另一个应用
                                if ([app canOpenURL:url]) {
                                    // 能，就打开
                                    [app openURL:url];
                                }else{
                                    //                                NSLog(@"打开应用失败");
                                }
                                
                            }];
                            
                            [alertCon addAction:action1];
                            
                            [alertCon addAction:aciton2];
                            
                            [self.window.rootViewController presentViewController:alertCon animated:YES completion:nil];
                            NSTimeInterval interval1 = [AppDelegate getNowTimeTimestamp3];//[[NSDate date] timeIntervalSince1970] * 1000;//获取的时间戳
                            [defaults setObject:@(interval1) forKey:@"preJionTimeInterval"];//储存上一次上进来的时间戳
                            
                        }
                        if (self.help.Status==2) {//强制更新
                            [self makeUpagetVersion];
                        }
                    }
                }
            } failure:^(id error) {
                
                NSLog(@"516516%@",error);
                
            }];
        }
    }
}

/*强制更新**/
-(void)makeUpagetVersion{
    
    UIAlertController *alertCont=[UIAlertController alertControllerWithTitle:@"发现新版本" message:self.help.UpdateLog preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        UIApplication *app = [UIApplication sharedApplication];
        
        // 2.创建要打开的应用程序的URL
        NSURL *url = [NSURL URLWithString:self.help.UploadAddress];
        
        // 3.判断是否可以打开另一个应用
        if ([app canOpenURL:url]) {
            // 能，就打开
            [app openURL:url];
            
            [VersionHelp removeVersion];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"preJionTimeInterval"];
            
        }
        
    }];
    
    [alertCont addAction:action];
    
    [self.window.rootViewController presentViewController:alertCont animated:YES completion:nil];
    
}
- (BOOL)validateWithStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}
- (void)changeAppIconWithName:(NSString *)iconName {
    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
            return;
        }
        
        if ([iconName isEqualToString:@""]) {
            iconName = nil;
        }
        [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"更换app图标发生错误了 ： %@",error);
            }
        }];
   }
}
- (void)backToPrimaryIconAction {
   
    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
            return;
        }
        
        if ([UIApplication sharedApplication].alternateIconName != nil) {//已经被替换掉了图标
            [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
                if (!error) {
                    NSLog(@"成功还原图标");
                }else{
                    NSLog(@"error:%@",error);
                }
            }];
        }
    }else
        NSLog(@"error:还原图标");
  
  
    
}

-(void)updateAppicon
//{
//    
////    BOOL isCurrent =  [self validateWithStartTime:@"2019-02-04" withExpireTime:@"2019-02-18"];
////    NSLog(@"----isCurrent-%d",isCurrent);
////     if ([[UIDevice currentDevice].systemVersion floatValue] < 10.3) {
////         return ;
////     }
//
//    if ( [self validateWithStartTime:@"2019-02-04" withExpireTime:@"2019-02-18"]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self changeAppIconWithName:@"icon_SpringFestival"];
//            
//        });
//        
//    }else  if ( [self validateWithStartTime:@"2019-02-19" withExpireTime:@"2019-02-22"]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self changeAppIconWithName:@"icon_LanternFestival"];
//            
//        });
//    }
//    else  if ([self validateWithStartTime:@"2019-03-05" withExpireTime:@"2019-03-11"])
//    {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self changeAppIconWithName:@"icon_Women’sDay"];
//            
//        });
//    }
//    else
//    {
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            [self backToPrimaryIconAction];
//        });
//    }
//    
//    
//}
{
    
    //    BOOL isCurrent =  [self validateWithStartTime:@"2019-02-04" withExpireTime:@"2019-02-18"];
    //    NSLog(@"----isCurrent-%d",isCurrent);
    //     if ([[UIDevice currentDevice].systemVersion floatValue] < 10.3) {
    //         return ;
    //     }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager]; manager.requestSerializer = [AFHTTPRequestSerializer serializer]; manager.requestSerializer.timeoutInterval = 15;//请求超时 manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy; //缓存策略 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];//支持类型
    //设置请求接口
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://xialuote.cthai.cn/wechat/index/is_alert"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
          if ([self validateWithStartTime:@"2019-03-05" withExpireTime:@"2019-03-11"])
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self changeAppIconWithName:@"icon_Women’sDay"];
                    
                });
            }
            else
            {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self backToPrimaryIconAction];
                });
            }
            
        } else {
            
            NSDictionary *t = responseObject;
            if ([t[@"data"] integerValue] == 1) {
               if ([self validateWithStartTime:@"2019-03-05" withExpireTime:@"2019-03-11"])
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"替换APPicon" message:nil preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        
                        
                        UIAlertAction *aciton2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            
                            [self changeAppIconWithName:@"icon_Women’sDay"];
                        }];
                        
                        [alertCon addAction:action1];
                        
                        [alertCon addAction:aciton2];
                        UIImageView *viewe = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 35.0, 35.0)];
                        
                        viewe.image = [UIImage imageNamed:@"icon_Women’sDay@3x.png"];
                        
                        [alertCon.view addSubview:viewe];
                        [self.window.rootViewController presentViewController:alertCon animated:YES completion:nil];
                        
                    });
                }
                else
                {
                    //dzc http://xialuote.cthai.cn/wechat/index/is_alert
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self backToPrimaryIconAction];
                    });
                }
                
            }else{
               if ([self validateWithStartTime:@"2019-03-05" withExpireTime:@"2019-03-11"])
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self changeAppIconWithName:@"icon_Women’sDay"];
                        
                    });
                }
                else
                {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self backToPrimaryIconAction];
                    });
                }
            }
            
            
            
            
        }
        
    }];
    
    [dataTask resume];
    
    
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     NSLog(@"familyNames：%@",[UIFont familyNames]);//Hobo Std Impact
    // Override point for customization after application launch.
//     [NSThread sleepForTimeInterval:1.0];
    //第三方注册
    [self registerShareSDK];
    
    //百度地图注册
    [self registerBaiduMap];
    
    //注册微信
    [WXApi registerApp:@"wxb45ba06b1c5b2292"];
    
//    [self updateAppicon];//更新app icon
    [self UMengData];
   
    
    [QingNiuSDK setLogFlag:YES];
    
    //注册轻牛APP szxkwlkjyxgs2017061521
    [QingNiuSDK registerApp:@"szxkwlkjyxgs2017061521" registerAppBlock:^(QingNiuRegisterAppState qingNiuRegisterAppState) {
        NSLog(@"%ld",(long)qingNiuRegisterAppState);
    }];
    
    
     [self takeServericeVersion];//版本跟新

    //注册通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
        
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)  categories:nil];
        
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert) categories:nil];
        
    }
    //判断是否由远程消息通知触发应用程序启动
    if (launchOptions) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
            NSDictionary *pushInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
            
            //获取推送详情，收到通知滑动进入应用弹出
            NSString *pushString = [NSString stringWithFormat:@"%@",[pushInfo  objectForKey:@"aps"]];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"完成发送" message:pushString delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    NSLog(@"isProduction----%d",isProduction);
    //获取registerID
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRegisterIdFromJPush:) name:kJPFNetworkDidLoginNotification object:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"resCode : %d,registrationID: %@",resCode,registrationID);
        
        
        NSString * registerId = [JPUSHService registrationID];
        NSLog(@"registerId = %@",registerId);
        
    }];
    //根据registerid获取推送的相关内容
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerIdPushSuccess:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    

    
    return YES;
}
#pragma mark - 根据registerId进行推送看是否推送成功
- (void)registerIdPushSuccess:(NSNotification *)notification
{
    NSLog(@"registerIdPushSuccess:%@",[notification userInfo]);
    
    NSDictionary * userInfo = [notification userInfo];
    
    NSDictionary *aps = [userInfo valueForKey:@"n_builder_id"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"n_title"]; //播放的声音
    
    NSDictionary *extras = [userInfo valueForKey:@"n_extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    
    
}
#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"展示通知前进行处理");
    
    
    
    completionHandler(UNNotificationPresentationOptionAlert);
}
#pragma mark - 通知方法
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required -    DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
//    [[EMClient sharedClient] bindDeviceToken:deviceToken];
    
    NSString *token = [NSString stringWithFormat:@"%@", [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]];
    NSLog(@"极光推送 token is:%@", deviceToken);
    //这里应将device token发送到服务器端
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"注册极光失败 to get token, error:%@", error_str);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    
    
    
    /* eg.
     key: aps, value: {
     alert = "\U8fd9\U662f\U4e00\U6761\U6d4b\U8bd5\U4fe1\U606f";
     badge = 1;
     sound = default;
     }
     */
    //在线状态下，提示框通知
    //    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"远程推送" message:[NSString stringWithFormat:@"didReceive消息：%@",userInfo[@"aps"][@"alert"]] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    //    [alert show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

//极光推送应用内推送
#pragma mark - 获取registerId
-(void)getRegisterIdFromJPush:(NSNotification *)notification
{
    NSString * registerId = [JPUSHService registrationID];
}

#pragma mark   //将要进入后台
- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents]; // 让后台可以处理多媒体的事件
    NSLog(@"%s",__FUNCTION__);
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil]; //后台播放
    
}
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    //    [userInfo setValue:body forKey:@"messagebody"];
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        //        [rootViewController addNotificationCount];
        
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth)];
        
        v.backgroundColor=[UIColor clearColor];
        
        [self.window addSubview:v];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [v removeFromSuperview];
        });
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reciviRomteMesssage" object:userInfo];
        
        
        
    }
    else {
        // 判断为本地通知
        
    }
    NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"userInfo:---%@",userInfo);
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  //推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    //    [userInfo setValue:@"22" forKey:@"22"];
    //    [userInfo setValue:body forKey:@"messagebody"];
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        //        [rootViewController addNotificationCount];
        
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth)];
        
        v.backgroundColor=[UIColor clearColor];
        
        [self.window addSubview:v];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [v removeFromSuperview];
        });
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reciviRomteMesssage" object:userInfo];
        NSDictionary *dict=userInfo;
        
        NSString *messageUrl=dict[@"n_url"];
        
         NSInteger messageType1=[userInfo[@"n_content_type"] integerValue];
        
        TabbarController *tab = (TabbarController *)self.window.rootViewController;
        
        BaseNavigationViewController *nav =  tab.viewControllers[tab.selectedIndex];
        
        NSLog(@"%@-----tab.viewControllers-----%@",tab.viewControllers,nav);
        if (messageType1==1) {
            XKRemoteMessageController *romote = [[XKRemoteMessageController alloc]initWithType:pageTypeNormal];
            romote.messageBody=dict[@"aps"][@"alert"];
             romote.myTitle=@"健康消息";
             romote.hidesBottomBarWhenPushed = YES;
             [nav pushViewController:romote animated:YES];
        }else if (messageType1==2){
            if ([messageUrl containsString:@"HealthRemindType="]) {
                NSArray *tempA = [messageUrl componentsSeparatedByString:@"HealthRemindType="];
                if (tempA.count>1) {
                    [self goHealthRemindType:[tempA[1] intValue] text:dict[@"n_title"]];//messageType
                }
            }else
            {
                NSLog(@"---messageUrl----%@",messageUrl);
                AdvertisementController *romote = [[AdvertisementController alloc]initWithType:pageTypeNormal];
                romote.webUrlStr=messageUrl;//userInfo[@"n_url"];
                romote.myTitle=@"健康消息";
                romote.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:romote animated:YES];
            }
           
        }
        else if (messageType1==11){
//            在线咨询 春月医生
//            XKAdviserListConsultViewController *romote = [[XKAdviserListConsultViewController alloc]initWithType:pageTypeNormal];
//            romote.webUrlStr=userInfo[@"n_url"];
//            romote.myTitle=@"在线咨询";
           
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
            web.urlString = XKOnlineConsultantUrl;
            web.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:web animated:YES];
        }
    

    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        
        
        
        
    }
    NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    
    
    completionHandler();  // 系统要求执行这个方法
}
- (void) longTimeTask:(NSTimer *)timer{
    
    // 系统留给的我们的时间
    NSTimeInterval time =[[UIApplication sharedApplication] backgroundTimeRemaining];
//    NSLog(@"系统留给的我们的时间 = %.02f Seconds", time);
    
}
#pragma mark - 停止timer
-(void)endTask
{
    
    if (_timer != nil||_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
        
        //结束后台任务
        [[UIApplication sharedApplication] endBackgroundTask:_taskId];
        _taskId = UIBackgroundTaskInvalid;
        
        NSLog(@"停止timer");
    }
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s",__FUNCTION__);
    
    NSLog(@"applicationDidEnterBackground");
    self.taskId =[application beginBackgroundTaskWithExpirationHandler:^(void) {
        //当申请的后台时间用完的时候调用这个block
        //此时我们需要结束后台任务，
        [self endTask];
    }];
    // 模拟一个长时间的任务 Task
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(longTimeTask:)
                                               userInfo:nil
                                                repeats:YES];
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 11){
//        [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
        NSLog(@"ios11清除角标");
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.badge = @(-1);
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"clearBadge" content:content trigger:nil];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification) {
            NSLog(@"清除本地");
            NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:0.01];
            notification.fireDate = fireDate;
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.repeatInterval = 0;
            notification.alertBody = nil;
            notification.applicationIconBadgeNumber = -99;
            notification.soundName = nil;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            
//            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//            localNotification.fireDate = [NSDate date];
//            localNotification.applicationIconBadgeNumber = -1;
//            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        

        }
    }
}
//- (UIViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}

-(void)goHealthRemindType:(NSInteger)RemindType text:(NSString *)remindFriendText{
    TabbarController *tab = (TabbarController *)self.window.rootViewController;
    BaseNavigationViewController *nav =  tab.viewControllers[tab.selectedIndex];
      NSLog(@"viewController--------%@",nav);
    if (RemindType == 1) {

        XKGoSportRemindView *sv = [[[NSBundle mainBundle] loadNibNamed:@"XKGoSportRemindView" owner:self options:nil] firstObject];
        sv.friendRemindLab.text = [NSString stringWithFormat:@"%@",remindFriendText.length>0?remindFriendText:@"您的好友提醒您:"];
        sv.frame =  [UIScreen mainScreen].applicationFrame;
        [[UIApplication sharedApplication].delegate.window addSubview:sv];
        sv.delegate = self;
    }
     else if (RemindType == 2||RemindType == 3||RemindType == 4)
     {
         
         NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
         web.isNewHeight = YES;
         web.urlString = (RemindType == 2)?kHealthDrinkUrl:(RemindType == 3)?kHealthPlanUrl:kHealthMedicnaeUrl;
         web.myTitle = @"";
         web.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:web animated:YES];
     }
     else if (RemindType == 5||RemindType == 13)//5   7    8    9
     {
         NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
         web.isNewHeight = YES;
         web.urlString = (RemindType == 5)?kHealthSitDownUrl:kHealthSitDownUrl;
         web.myTitle = @"";
         web.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:web animated:YES];
         
     }
     else if (RemindType == 6)//5   7    8    9 
     {
         FriendMessageController *VC = [[FriendMessageController alloc]initWithType:pageTypeNormal];
         VC.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:VC animated:YES];
         
     }
     else if (RemindType == 7||RemindType == 8||RemindType == 9)//5   7    8    9
     {
         NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
         web.isNewHeight = YES;
         web.urlString = (RemindType == 7)?kHealthDrinkUrl:(RemindType == 8)?kHealthMedicnaeUrl:kHealthPlanUrl;
         web.myTitle = @"";
         web.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:web animated:YES];
         
     }
     else if (RemindType == 10)
     {
         HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
         record.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:record animated:YES];
         
     }
   
     else if (RemindType == 11)
     {
         GoHealthTaskController *go = [[GoHealthTaskController alloc]initWithType:pageTypeNormal];
         go.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:go animated:YES];
         
     }
     else if (RemindType == 12)
     {
         NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
         web.isNewHeight = YES;
         web.urlString = kHealthTreeUrl;
         web.hidesBottomBarWhenPushed = YES;
         [nav pushViewController:web animated:YES];
         
     }//
    
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
     NSLog(@"进入前台");
    //App即将进入前台,将小红点清除
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}

// TVUAnywhereTool中的类，在此为了方便写到一块儿了
//- (UIView *)createSnapShotView
//{
//    UIView *myBanner = [[UIView alloc] init];
//    myBanner.backgroundColor = [UIColor clearColor];
//    myBanner.width = KScreenWidth;
//    myBanner.height = KScreenHeight;
//
//    return myBanner;
//}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    if (_backgroundView != nil) {
//        [_backgroundView removeFromSuperview];
//        _backgroundView = nil;
//    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    //支付宝支付流程的通知
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 123== %@",resultDic);
            if ([resultDic[@"resultStatus"] integerValue] == 9000) {//支付成功
                
                ShowSuccessStatus(@"支付成功");
            }else{//支付失败
                ShowErrorStatus(@"支付失败");
            }
            
        }];
    }
    
    if ([url.host isEqualToString:@"IntegratedAlipay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 123== %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark 注册第三方
- (void)registerShareSDK
{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"911441283"
                                           appSecret:@"1b54455e4ec0b3a368cd88a727d84b09"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxb45ba06b1c5b2292"
                                       appSecret:@"f297543d7cfa72161e1c055a212352e9"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105128572"
                                      appKey:@"qWj5E1EB7S9ODiWt"
                                    authType:SSDKAuthTypeBoth];
                 break;
                                                 default:
                   break;
                   }
                   }];
}

- (void)registerBaiduMap
{
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:baiduMapAppKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // 设置鹰眼SDK的基础信息
    // 每次调用startService开启轨迹服务之前，可以重新设置这些信息。
    BTKServiceOption *basicInfoOption = [[BTKServiceOption alloc] initWithAK:baiduMapAppKey mcode:MCODE serviceID:serviceID keepAlive:FALSE];
    [[BTKAction sharedInstance] initInfo:basicInfoOption];
}
-(void)UMengData
{
//友盟
UMConfigInstance.appKey = @"5875e20265b6d66125000d40";
UMConfigInstance.channelId = @"App Store";
[MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化友盟SDK！
[MobClick setLogEnabled:YES];
}
@end