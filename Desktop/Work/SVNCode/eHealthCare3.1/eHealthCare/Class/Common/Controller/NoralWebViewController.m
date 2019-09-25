//
//  NomalWebViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/31.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "NoralWebViewController.h"
#import "ShareView.h"
#import "PayMoneyModel.h"
#import "LocationTool.h"
#import "CommonViewModel.h"
#import "HealthRecordController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebView+LVShot.h"
#import "UIImage+LVManager.h"
#import "UIView+LVShot.h"
#import "BreathTrainViewController.h"
#import "XKDectingViewController.h"
#import "SportViewController.h"
#import "XKInfomationViewController.h"
#import "XKMusicViewController.h"
#import "XKHealthIntegralTrendRewardController.h"
#import "MallViewController.h"
#import "HomeViewModel.h"
#import "QuietController.h"
#import "XKInformationDetail.h"
#import "XKTopicHomeController.h"
#import "HealthExamineController.h"
@interface NoralWebViewController () <LocationToolDelegate,WKUIDelegate,WKNavigationDelegate>
{
     UIScrollView *storeScrollView;
     UIImageView *storeImage;
}
///进行二次跳转获取到的url
@property (nonatomic, strong) NSURL *webUrl;

///定位
@property (nonatomic, strong) LocationTool *location;


@property (nonatomic,strong) UIImage *resultingImage;//约定好的树和喝水分享的截图
@end

@implementation NoralWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    config.preferences.minimumFontSize = 0.0f;
   
     self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *))
    {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//不加这句会导致向下偏移状态栏的高度
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }

    [[LVManager share] asyn_tailorImageWithimageName:[UIImage imageNamed:@""]  CompletedBlock:^(UIImage *newImage) {
        
        
    }];
    [self loadUrl];
 
}
-(void)showScreenShot:(UIImage*)image{
    if(storeScrollView!=nil){
        [storeScrollView removeFromSuperview];
        storeScrollView = nil;
    }
    if(storeScrollView==nil){
        storeScrollView = [UIScrollView new];
    }
    
    storeScrollView.contentSize = CGSizeMake(KScreenWidth/2, KScreenHeight/2*3);
    storeScrollView.frame =CGRectMake(0, 0, KScreenWidth/2, KScreenHeight/2);
    storeScrollView.center = self.view .center;
    storeScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:storeScrollView];
    
    storeImage = [UIImageView new];
    storeImage.image = image;
    [storeScrollView addSubview:storeImage];
    storeImage.frame = CGRectMake(0, 0, KScreenWidth/2, KScreenHeight/2*3);
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.webView removeObserver:self forKeyPath:@"title"];
}

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
            
            if (![self.appointmentTitle isEqualToString:@"预约挂号"]) {
                self.myTitle = self.webView.title;
            }
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
//    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark 重写父类方法
//重写左侧返回按钮的点击事件
- (void)webViewGoBack{
    
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }else
    {
        [self closeButtonAction];
    }
}
-(void)goTaskTaskTypeID:(NSInteger)TaskTypeID{
    /**
     Int32
     每日任务类型（1、签到任务 2、测量任务 3、舒缓心情任务 4、健康计划任务 5、健康小工具任务 6、养生小知识任务 7、运动任务8视力9柔韧度10拳头威力 11色彩感觉）
     */
    //    if (indexPath.section == 0) {//判断是福利任务还是每日任务
    
    NSLog(@"---_每日任务  2、福利任务即完善档案，TypeID 任务分类   如 1、签");
    switch (TaskTypeID) {
        case 1:
        {
            
        }
            break;
            //        case 2:
            //        {
            //            HouseholdCheckHomeController *connection=[[HouseholdCheckHomeController alloc]initWithType:pageTypeNormal];
            //            [self.navigationController pushViewController:connection animated:YES];
            //        }
            //            break;
            //        case 3:
            //        {
            //            /* 健康+》开始深呼吸里要判断当天是否有这个任务，如果有才调用任务接口，没有则不调用*/
            //            BreathTrainViewController *breath = [[BreathTrainViewController alloc]initWithType:pageTypeNoNavigation];
            //
            //            [self.navigationController pushViewController:breath animated:YES];
            //        }
            //            break;
            //        case 4://健康计划任务
            //        {
            //            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
            //            web.isNewHeight = YES;
            //            web.urlString = kHealthPlanUrl;
            //            web.myTitle = @"健康计划";
            //            web.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:web animated:YES];
            //
            //        }
            //            break;
            //        case 5://健康小工具任务
            //        {
            //            NSInteger pageSize = 8;
            //            NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
            //                                  @"PageIndex":@(1),
            //                                  @"PageSize":@(pageSize)};
            //            [HomeViewModel getHealthTestWithParams:dic FinishedBlock:^(ResponseObject *response) {
            //
            //                if (response.code == CodeTypeSucceed) {
            //
            //
            //                    NSArray *headViewArray = response.Result[@"FixedList"];
            //
            //                    NSMutableArray *headViewDataArray = [NSMutableArray arrayWithArray:headViewArray];
            //
            //                    ReadyTestViewController *test = [[ReadyTestViewController alloc]initWithType:pageTypeNormal];
            //
            //                    test.myTitle = @"健康自测";
            //
            //                    for (NSDictionary *dic in headViewDataArray)
            //                    {
            //
            //                        test.dataDic = dic;
            //                        break;
            //
            //                    }
            //                    [self.navigationController pushViewController:test animated:YES];
            //
            //                }
            //            }];
            //            //                CheckController *check = [[CheckController alloc] init];
            //            //                [self.navigationController pushViewController:check animated:YES];
            //        }
            //            break;
            //        case 6://跳转到健康资讯查看详情页
            //        {
            //            //展示当天任务是否完成
            //            XKInfomationViewController *info = [[XKInfomationViewController alloc]initWithType:pageTypeNormal];
            //            [self.navigationController pushViewController:info animated:YES];
            //        }
            //            break;
            //        case 7:
            //        {
            //            SportViewController *sport = [[SportViewController alloc]init];
            //            [self.navigationController pushViewController:sport animated:YES];
            //
            //        }
            //            break;
            //        case 8:
            //        {

            //
            //        }
            //            break;
            //        case 12://12对应安静调节
            //        {
            //            /**
            //             加载正念、早安、晚安数据、
            //             */
            //            [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
            //            NSDictionary *dic = @{@"Token":[SingleTon shareInstance].token,
            //                                  @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
            //            [ProtosomaticHttpTool protosomaticPostWithURLString:@"962" parameters:dic success:^(id json) {
            //
            //                NSLog(@"获取加载健康+数据962--:%@",json);
            //                if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            //                    //广告信息
            //                    [[XKLoadingView shareLoadingView] hideLoding];
            //                    NSArray *array = [MusicTrainModel objectArrayWithKeyValuesArray:json[@"Result"]];
            //
            //
            //                    NSMutableArray *mindFulnessArr = [NSMutableArray arrayWithCapacity:0];
            //
            //                    for (NSInteger i=0; i<array.count; i++) {
            //                        MusicTrainModel *model = array[i];
            //                        if (model.EaseType == 3 && model.MindfulnessType == 1) {//安静莫想
            //                            [mindFulnessArr addObject:model];
            //
            //                        }
            //                    }
            //                    XKMusicViewController *pluse = [[XKMusicViewController alloc]initWithType:pageTypeNormal];
            //                    pluse.musicArray = mindFulnessArr;
            //                    [self.navigationController pushViewController:pluse animated:YES];
            //                }else{
            //                    [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            //                }
            //            } failure:^(id error) {
            //                NSLog(@"%@",error);
            //                [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
            //            }];
            //
            //        }
            //            break;
            //        case 13://13对应缓解压力
            //        {
            //            /**
            //             加载正念、早安、晚安数据、
            //             */
            //            [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
            //            NSDictionary *dic = @{@"Token":[SingleTon shareInstance].token,
            //                                  @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
            //            [ProtosomaticHttpTool protosomaticPostWithURLString:@"962" parameters:dic success:^(id json) {
            //
            //                NSLog(@"获取加载健康+数据962--:%@",json);
            //                if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            //                    //广告信息
            //                    [[XKLoadingView shareLoadingView] hideLoding];
            //                    NSArray *array = [MusicTrainModel objectArrayWithKeyValuesArray:json[@"Result"]];
            //
            //                    NSMutableArray *mindFulnessArr = [NSMutableArray arrayWithCapacity:0];
            //
            //                    for (NSInteger i=0; i<array.count; i++) {
            //                        MusicTrainModel *model = array[i];
            //                        if (model.EaseType == 3 && model.MindfulnessType == 2) {//缓解压力
            //                            [mindFulnessArr addObject:model];
            //
            //                        }
            //                    }
            //                    XKMusicViewController *pluse = [[XKMusicViewController alloc]init];
            //                    //                                pluse.model = model;
            //
            //                    pluse.musicArray = mindFulnessArr;
            //                    [self.navigationController pushViewController:pluse animated:YES];
            //                }else{
            //                    [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            //                }
            //            } failure:^(id error) {
            //                NSLog(@"%@",error);
            //                [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
            //            }];
            //
            //        }
            //            break;
            //        case 14://14对应正念训练
            //        {
            //            /**
            //             加载正念、早安、晚安数据、
            //             */
            //            [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
            //            [ProtosomaticHttpTool protosomaticPostWithURLString:@"962" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberId":@([UserInfoTool getLoginInfo].MemberID)} success:^(id json) {
            //
            //                NSLog(@"获取加载健康+数据962--:%@",json);
            //                if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            //                    //广告信息
            //                    [[XKLoadingView shareLoadingView] hideLoding];
            //                    NSArray *array = [MusicTrainModel objectArrayWithKeyValuesArray:json[@"Result"]];
            //                    NSMutableArray *mindFulnessArr = [NSMutableArray arrayWithCapacity:0];
            //
            //                    for (NSInteger i=0; i<array.count; i++) {
            //                        MusicTrainModel *model = array[i];
            //                        if (model.EaseType == 3 && model.MindfulnessType == 3) {//正念训练
            //                            [mindFulnessArr addObject:model];
            //
            //                        }
            //                    }
            //                    XKMusicViewController *pluse = [[XKMusicViewController alloc]init];
            //                    //                                pluse.model = model;
            //
            //                    pluse.musicArray = mindFulnessArr;
            //                    [self.navigationController pushViewController:pluse animated:YES];
            //
            //                }else{
            //                    [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            //                }
            //            } failure:^(id error) {
            //                NSLog(@"%@",error);
            //                [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
            //            }];
            //
            //        }
            //            break;
            //        default:
            //            break;
    }
    
}
#pragma mark --WKWebView WKNavigation Delegate
//重写WKWebView的delegate方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    NSLog(@"---scheme--%@---%@",scheme,url.query);
    if (!self.location) {
        //开始定位
        LocationTool *location = [[LocationTool alloc] init];
        location.delegate = self;
        self.location = location;
    }
    
//    [self startLocationServer];
    
    //给web传输地理信息
    if ([scheme containsString:@"xkapp"])
    {
        self.webUrl = url;
       
        [self startLocationServer];
       
    }
    
    if ([scheme containsString:@"healthtrees"]) {

        [self addImageWithImage:YES];
    }
    if ([scheme containsString:@"goHealthTree"]) {
         [self goTaskTypeID:16];//做任务在百科里面跳转到健康树,消除上部分的返回头
    }
    if ([scheme containsString:@"drinkwater"]) {
        
       

//         self.topView.hidden = YES;
//        NSLog(@"--------drinkWater分享--%@",self.topView);
//        self.topView.shareImageView.image = [self screenView:webView];
         [self addImageWithImage:NO];
        
    }
    if ([scheme containsString:@"healthplan"]) {

        [self shareUrlAction:nil containShare:NO shareTempIsSuccess:NO];
    }
    //分享   goTask?TaskType=1&TypeID=1（TaskType 1、每日任务  2、福利任务即完善档案，TypeID 任务分类   如 1、签到等）
    if ([scheme containsString:@"gotask"]) {
        NSString *temp =  [NSString decodeFromPercentEscapeString:url.query];
        NSDictionary *dicTemp = [temp mj_JSONObject];
        if ([dicTemp[@"TaskType"] integerValue]== 2) {
            HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
            [self.navigationController pushViewController:record animated:YES];
        }
//        if ([dicTemp[@"TaskType"] integerValue]== 1&&[dicTemp[@"TypeID"] integerValue]==0) {
//
//
////            HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
////            [self.navigationController pushViewController:record animated:YES];
//        }
        else  if ([dicTemp[@"TaskType"] integerValue]== 1)
        {
           
            [self goTaskTypeID:[dicTemp[@"TypeID"] integerValue]];
            
        }
        NSLog(@"TaskType---%@",temp);
    }
    
    if ([scheme containsString:@"gogame"]) {
        NSString *temp =  [NSString decodeFromPercentEscapeString:url.query];
        NSDictionary *dicTemp = [temp mj_JSONObject];
       
        if ([dicTemp[@"GameID"] integerValue]== 1)
        {
            
            [self goTaskTypeID:8];
            
        }
        if ([dicTemp[@"GameID"] integerValue]== 2)
        {
            
            [self goTaskTypeID:11];
            
        }
        if ([dicTemp[@"GameID"] integerValue]== 3)
        {
            
            [self goTaskTypeID:9];
            
        }
        if ([dicTemp[@"GameID"] integerValue]== 4)
        {
            
           [self goTaskTypeID:10];
            
        }
        NSLog(@"TaskType---%@",temp);
    }
    
    
    if ([scheme containsString:@"GoStrategy"]) {
        NSString *temp =  [NSString decodeFromPercentEscapeString:url.query];
        NSDictionary *dicTemp = [temp mj_JSONObject];
        if ([dicTemp[@"TaskType"] integerValue]== 2) {
            HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
            [self.navigationController pushViewController:record animated:YES];
        }
        if ([dicTemp[@"TypeID"] integerValue]==0) {
            
            
            HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
            [self.navigationController pushViewController:record animated:YES];
        }
        NSLog(@"---%@",temp);
    }
    if ([scheme containsString:@"share"]) {

        NSString *temp =  [NSString decodeFromPercentEscapeString:url.query];
        NSDictionary *dicTemp = [temp mj_JSONObject];
        [self shareUrlAction:dicTemp containShare:NO shareTempIsSuccess:NO];
    }
    //支付
    if ([scheme containsString:@"pay"]) {
        
        [self getPayData:url];
    }
     if ([scheme  hasPrefix:@"goback"]) {
         NSString *temp =  [NSString decodeFromPercentEscapeString:url.query];
         if ([temp isEqualToString:@"t=1"]) {
             [[NSUserDefaults standardUserDefaults]setInteger:0+1000 forKey:[NSString stringWithFormat:@"RemindCell%i",0]];
             [[NSUserDefaults standardUserDefaults]synchronize];
         }
         if ([temp isEqualToString:@"t=2"]) {
             [[NSUserDefaults standardUserDefaults]setInteger:1+1000 forKey:[NSString stringWithFormat:@"RemindCell%i",1]];
             [[NSUserDefaults standardUserDefaults]synchronize];
         }
         if ([temp isEqualToString:@"t=3"]) {
             [[NSUserDefaults standardUserDefaults]setInteger:2+1000 forKey:[NSString stringWithFormat:@"RemindCell%i",2]];
             [[NSUserDefaults standardUserDefaults]synchronize];
         }
        [self popController];
    }
    if ([scheme  hasPrefix:@"goapphealthtree"]) {
      
        [self.navigationController popToRootViewControllerAnimated:YES];
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
- (UIImage *)getImage {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenWidth, [UIApplication sharedApplication].keyWindow.height), NO, 0);  //NO，YES 控制是否透明
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}
- (void)addImageWithImage:(BOOL)shareTempIsSuccess {
    __weak typeof(self) weakSelf = self;
    
     [self.view DDGScreenShotWithCompletionHandle:^(UIImage *screenShotImage)  {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
      
        UIImage *image1 = screenShotImage;
        UIImage *image2 = [UIImage imageNamed:@"iv_share_qdcode"];
        
        UIGraphicsBeginImageContext(image1.size);

        [image1 drawInRect:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];

        [image2 drawInRect:CGRectMake(0,(KScreenHeight - (KScreenWidth*220/750.0)), KScreenWidth, KScreenWidth*220/750.0)];
        
        strongSelf.resultingImage = UIGraphicsGetImageFromCurrentImageContext();//screenShotImage;//
        
        UIGraphicsEndImageContext();
        
         [strongSelf shareUrlAction:nil containShare:YES shareTempIsSuccess:shareTempIsSuccess];
    }];
   
    
   
}
#pragma mark Action
//分享
- (void)shareUrlAction:(NSDictionary *)dicTemp containShare:(BOOL)containShare shareTempIsSuccess:(BOOL)isTreeShare
{
    ShareModel *model = [[ShareModel alloc]init];
    if (dicTemp!=nil) {
        model.shareUrl = [NSString stringWithFormat:@"%@",dicTemp[@"url"]];
        model.shareTitle = dicTemp[@"title"];
        model.shareContent = dicTemp[@"content"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dicTemp[@"imagePath"]]]];
        if (image) {
            model.shareImageArray = @[image];
        }else
        {
            model.shareImageArray = @[[UIImage imageNamed:@"qrcode"]];
            
        }
    }else if (containShare == YES)
    {
       
        model.shareImageArray = @[self.resultingImage];
        
    }
   else
        model.shareImageArray = @[[self getImage]];
    [ShareView shareActionOfShareUseFor:shareUseForShareContent shareType:shareUrl WithViewcontroller:self ShareModel:model Block:^(NSInteger tag) {
//        if (tag ==1) {//分享成功时调用js数据
            NSString *sendString = [NSString stringWithFormat:@"RemindHtml(\"iiiii\")"];
            [self.webView evaluateJavaScript:sendString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"sharetree success or %@-2--%@",error,response);
            }];
//        }

        if (isTreeShare == YES) {
           

            XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];//分享健康树
            [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(16)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(16)} isPopView:NO];
        }
    } shareTree:isTreeShare];
}
- (void)popController
{
//    if ([self.webView canGoBack])
//    {
//        [self.webView goBack];
//    }else
//    {
        [self.navigationController popViewControllerAnimated:YES];
//    }
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

//启动定位服务
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
       NSLog(@"response-2--%@",response);
    }];
}

-(void)goTaskTypeID:(NSInteger )TaskType{
    switch (TaskType) {
        case 1:
        {
         
        }
            break;
    case 2:
        {
            HealthExamineController *Examine = [[HealthExamineController alloc]initWithType:pageTypeNormal];
            Examine.SelectTab = 1;
            [self.navigationController pushViewController:Examine animated:YES];
        }
        break;
    case 3:
        {
            /* 健康+》开始深呼吸里要判断当天是否有这个任务，如果有才调用任务接口，没有则不调用*/
            BreathTrainViewController *breath = [[BreathTrainViewController alloc]initWithType:pageTypeNoNavigation];
            [self.navigationController pushViewController:breath animated:YES];
        }
        break;
    case 4://健康计划任务
        {
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
            web.isNewHeight = YES;
            web.urlString = kHealthPlanUrl;
            web.myTitle = @"健康计划";
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            
        }
        break;
    case 5://健康小工具任务
        {
            NSInteger pageSize = 8;
            NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                                  @"PageIndex":@(1),
                                  @"PageSize":@(pageSize)};
            [[XKLoadingView shareLoadingView]showLoadingText:nil];
            [HomeViewModel getHealthTestWithParams:dic FinishedBlock:^(ResponseObject *response) {
                [[XKLoadingView shareLoadingView] hideLoding];
                if (response.code == CodeTypeSucceed) {
                    
                    
                    NSArray *headViewArray = response.Result[@"FixedList"];
                    
                    NSMutableArray *headViewDataArray = [NSMutableArray arrayWithArray:headViewArray];
                    
                    ReadyTestViewController *test = [[ReadyTestViewController alloc]initWithType:pageTypeNormal];
                    
                    test.myTitle = @"健康自测";
                    
                    for (NSDictionary *dic in headViewDataArray)
                    {
                        
                        test.dataDic = dic;
                        break;
                        
                    }
                    [self.navigationController pushViewController:test animated:YES];
                    
                }
            }];
         
        }
        break;
    case 6://发表健康话题
        {
            //展示当天任务是否完成
            XKTopicHomeController *info = [[XKTopicHomeController alloc]initWithType:pageTypeNormal];
            [self.navigationController pushViewController:info animated:YES];
        }
        break;
    case 7:
        {
            SportViewController *sport = [[SportViewController alloc]init];
            [self.navigationController pushViewController:sport animated:YES];
            
        }
        break;
    case 8:
        {
            /**
             视力测试
             */
            SensoryTestViewController *test = [[SensoryTestViewController alloc]initWithType:pageTypeNoNavigation];
            test.testType = sensoryTypeVision;
            [self.navigationController pushViewController:test animated:YES];
         
        }
        break;
    case 9:
        {
            /**
             柔韧度测试
             */
            SensoryTestViewController *test = [[SensoryTestViewController alloc]initWithType:pageTypeNoNavigation];
            //柔韧度测试
            test.testType = sensoryTypeFist;
            [self.navigationController pushViewController:test animated:YES];
          
            
        }
        break;
    case 10:
        {
            /**
             挥拳测试
             */
            SensoryTestViewController *test = [[SensoryTestViewController alloc]initWithType:pageTypeNoNavigation];
            //柔韧度测试
            test.testType = sensoryTypeFlexibility;
            [self.navigationController pushViewController:test animated:YES];
         
        }
        break;
    case 11:
        {
            /**
             色觉测试
             */
            NSLog(@"色觉测试");
            SensoryTestViewController *test = [[SensoryTestViewController alloc]initWithType:pageTypeNoNavigation];
            //柔韧度测试
            test.testType = sensoryTypeColorVision;
            [self.navigationController pushViewController:test animated:YES];
            //                ColourSenseController *sense = [[ColourSenseController alloc] init];
            //                [self.navigationController pushViewController:sense animated:YES];
            
        }
        break;
    case 12://12对应安静调节
        {
            /**
             加载正念、早安、晚安数据、
             */
            [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
            NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                                  @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"962" parameters:dic success:^(id json) {
                
                NSLog(@"获取加载健康+数据962--:%@",json);
                if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
                    //广告信息
                    [[XKLoadingView shareLoadingView] hideLoding];
                    NSArray *array = [MusicTrainModel objectArrayWithKeyValuesArray:json[@"Result"]];
                    
                    
                    NSMutableArray *mindFulnessArr = [NSMutableArray arrayWithCapacity:0];
                    
                    for (NSInteger i=0; i<array.count; i++) {
                        MusicTrainModel *model = array[i];
                        if (model.EaseType == 3 ) {//安静莫想
                            [mindFulnessArr addObject:model];
                            
                        }
                    }
                    XKMusicViewController *pluse = [[XKMusicViewController alloc]initWithType:pageTypeNormal];
                    pluse.musicArray = mindFulnessArr;
                    [self.navigationController pushViewController:pluse animated:YES];
                }else{
                    [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
                }
            } failure:^(id error) {
                NSLog(@"%@",error);
                [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
            }];
            
        }
        break;
    case 13://13自然音乐
        {
            //                /**
            //                 加载正念、早安、晚安数据、
            //                 */
            QuietController *train = [[QuietController alloc]initWithType:pageTypeNormal];
            train.isQuietOrMusic = NO;
            [self.navigationController pushViewController:train animated:YES];
        }
        break;
    case 14://14喝水
        {
            
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNoNavigation];
            web.isNewHeight = YES;
            web.urlString =kHealthDrinkUrl;
            web.myTitle = @"喝水";
            [self.navigationController pushViewController:web animated:YES];
            
        }
        break;
    case 15://阅读健康百科
        {
            HealthWiKiViewController *web = [[HealthWiKiViewController alloc]initWithType:pageTypeNormal];
            web.urlString = kHealthBaiKeUrl;
            web.myTitle = @"健康百科";
            //                web.isNewHeight = YES;
            [self.navigationController pushViewController:web animated:YES];
            
        }
        break;
    case 16://分享健康树
        {
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
            web.isNewHeight = YES;
            web.urlString = kHealthTreeUrl;
            [self.navigationController pushViewController:web animated:YES];
            
        }
        break;
    case 17://评论健康资讯
        {
         
            XKInfomationViewController *info = [[XKInfomationViewController alloc]init];
            [self.navigationController pushViewController:info animated:YES];
            
        }
        break;
    case 18://健康资讯分享
        {
            XKInfomationViewController *info = [[XKInfomationViewController alloc]init];
            [self.navigationController pushViewController:info animated:YES];
            
        }
        break;
    default:
        break;
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
