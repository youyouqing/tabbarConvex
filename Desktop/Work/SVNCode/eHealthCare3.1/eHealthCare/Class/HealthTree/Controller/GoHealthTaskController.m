//
//  GoHealthTaskController.m
//  eHealthCare
//
//  Created by John shi on 2018/11/12.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "GoHealthTaskController.h"
#import "XKHealthIntegralTaskCell.h"
#import "XKHealthIntegralTaskListModel.h"
#import "GoHealthTopView.h"
#import "XKHealthIntegralSignSuccessView.h"
#import "XKHealthIntegralSginModel.h"
#import "HouseholdCheckHomeController.h"
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
@interface GoHealthTaskController ()
/**
 保存数据实体
 */
@property (nonatomic,strong) XKHealthIntegralTaskListModel *taskListModel;
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) GoHealthTopView *taskHead;

@end

@implementation GoHealthTaskController
-(GoHealthTopView *)taskHead{
    if (!_taskHead) {
        _taskHead = [[[NSBundle mainBundle] loadNibNamed:@"GoHealthTopView" owner:self options:nil] firstObject];
        _taskHead.height = 104;
    }
    
    return _taskHead;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadTaskData];//视图将要出现的时候刷新数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"今日健康行为";
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    self.titleLab.textColor = kMainTitleColor;
    self.view.backgroundColor = kbackGroundGrayColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.taskHead;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKHealthIntegralTaskCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_trend"] forState:UIControlStateNormal];
   
    [self.rightBtn addTarget:self action:@selector(clickKTrend) forControlEvents:UIControlEventTouchUpInside];
}
-(UITableView *)tableView
{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=[UIColor getColor:@"f2f2f2"];
         _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
    
}
- (void)clickKTrend {
    NSLog(@"k值走势的点击方法");
    XKHealthIntegralTrendRewardController *trend = [[XKHealthIntegralTrendRewardController alloc] initWithType:pageTypeNormal];
    trend.myTitle = @"K值走势";
    trend.dataModel =  self.taskListModel;
    [self.navigationController pushViewController:trend animated:YES];
}
/**
 加载任务列表的方法
 */
-(void)loadTaskData{
    [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
    //获取首页健康计划、热门话题数据
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"939" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberId":@([UserInfoTool getLoginInfo].MemberID)} success:^(id json) {
        
        NSLog(@"获取当日任务详情信息939--:%@",json);
        if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            //广告信息
            [[XKLoadingView shareLoadingView] hideLoding];
//            //数据转化并刷新列表
            self.taskListModel = [XKHealthIntegralTaskListModel objectWithKeyValues:json[@"Result"]];
            self.taskHead.listModel = self.taskListModel;
            NSLog(@"%li---%li",self.taskListModel.DailyQuestList.count,self.taskListModel.WelfareTaskList.count);
            [self.tableView reloadData];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
        }
    } failure:^(id error) {
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
    }];
}
#pragma mark - Table view data source 返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return self.taskListModel.DailyQuestList.count;
}

/**
 每个组有多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 1;

}

/**
 每个cell设置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XKHealthIntegralTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dailyModel = self.taskListModel.DailyQuestList[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/**
 根据   每日任务类型（1、签到任务 2、测量任务 3、舒缓心情任务 4、健康计划任务 5、健康小工具任务 6、养生小知识任务 7、运动任务）
 福利任务类型（1、完善个人档案 2、完善家庭成员档案3、检测报告4、预约健康体检 5、分享阅读 6、关联设备 7、购买商品 8、评论健康资讯）
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     Int32
     每日任务类型（1、签到任务 2、测量任务 3、舒缓心情任务 4、健康计划任务 5、健康小工具任务 6、养生小知识任务 7、运动任务8视力9柔韧度10拳头威力 11色彩感觉）
     */
//    if (indexPath.section == 0) {//判断是福利任务还是每日任务

        XKHealthIntergralDailyQuestListModel *dailyTask = self.taskListModel.DailyQuestList[indexPath.section];
        if (dailyTask.Iscomplete == 1) {//已完成
            //            [SVProgressHUD showSuccessWithStatus:@"该任务已完成"];
            return;
        }
        switch (dailyTask.TaskTypeID) {
            case 1:
            {
                [self popTaskView:dailyTask];
            }
                break;
            case 2:
            {
//                HouseholdCheckHomeController *connection=[[HouseholdCheckHomeController alloc]initWithType:pageTypeNormal];
//                [self.navigationController pushViewController:connection animated:YES];可以删除这个页面
//
                
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
//                CheckController *check = [[CheckController alloc] init];
//                [self.navigationController pushViewController:check animated:YES];
            }
                break;
            case 6://发表健康话题
            {
                //展示当天任务是否完成
//               XKInfomationViewController *info = [[XKInfomationViewController alloc]initWithType:pageTypeNormal];
//                [self.navigationController pushViewController:info animated:YES];
//
                
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
//                EyeTestViewController *eyeTest = [[EyeTestViewController alloc] init];
//                [self.navigationController pushViewController:eyeTest animated:YES];
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
//                LigamentController *touch = [[LigamentController alloc] init];
//                [self.navigationController pushViewController:touch animated:YES];

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
//                ShakeFistController *fist = [[ShakeFistController alloc] init];
//                [self.navigationController pushViewController:fist animated:YES];

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
//                [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
//                NSDictionary *dic = @{@"Token":[SingleTon shareInstance].token,
//                                      @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
//                [ProtosomaticHttpTool protosomaticPostWithURLString:@"962" parameters:dic success:^(id json) {
//
//                    NSLog(@"获取加载健康+数据962--:%@",json);
//                    if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
//                        //广告信息
//                        [[XKLoadingView shareLoadingView] hideLoding];
//                        NSArray *array = [MusicTrainModel objectArrayWithKeyValuesArray:json[@"Result"]];
//
//
//                        NSMutableArray *mindFulnessArr = [NSMutableArray arrayWithCapacity:0];
//
//                        for (NSInteger i=0; i<array.count; i++) {
//                            MusicTrainModel *model = array[i];
//                            if (model.EaseType == 1 ||model.EaseType == 2) {//安静莫想
//                                [mindFulnessArr addObject:model];
//
//                            }
//                        }
//                        TrainWithMusicViewController *train = [[TrainWithMusicViewController alloc]initWithType:pageTypeNoNavigation];
//                         train.model = topicArr[trainType];
//                        [self.navigationController pushViewController:pluse animated:YES];
//                    }else{
//                        [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
//                    }
//                } failure:^(id error) {
//                    NSLog(@"%@",error);
//                    [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
//                }];
//
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
                web.isFromGoHealthTaskJumpView = YES;
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
//                XKInformationDetail *plan=[[XKInformationDetail alloc]init];
//                plan.mod = [[XKWiKIInfoModel alloc]init];
//                plan.mod.LinkUrl = model.LinkUrl;
//                plan.mod.WikiID = model.ID;
//                [self.navigationController pushViewController:plan animated:YES];
                XKInfomationViewController *info = [[XKInfomationViewController alloc]init];
                [self.navigationController pushViewController:info animated:YES];
                
            }
                break;
            case 18://健康资讯分享
            {
//                XKInformationDetail *plan=[[XKInformationDetail alloc]init];
//                plan.mod = [[XKWiKIInfoModel alloc]init];
//                plan.mod.LinkUrl = model.LinkUrl;
//                plan.mod.WikiID = model.ID;
//                [self.navigationController pushViewController:plan animated:YES];
                XKInfomationViewController *info = [[XKInfomationViewController alloc]init];
                [self.navigationController pushViewController:info animated:YES];
            }
                break;
            default:
                break;
        }

//    }

//    /*TaskTypeID
//     Int32
//     福利任务类型（1、完善个人档案 2、完善家庭成员档案3、预约健康体检(客户端无) 4、查看检测报告 5、关联设备 6、购买商品 7、健康资讯评论）8、分享健康树
//     */
//    if (indexPath.section == 1) {//福利任务判断
//        XKXKHealthIntergralDailyPlanHealthDetailListModel *planModel = self.taskListModel.WelfareTaskList[indexPath.row];
//        if (planModel.Iscomplete == 1) {//已完成
//            //            [SVProgressHUD showSuccessWithStatus:@"该任务已完成"];
//            return;
//        }
//        switch (planModel.TaskTypeID) {
//            case 1:
//            {
//                ArchiveViewController *archview = [[ArchiveViewController alloc] init];
//                //                archview.isHistoryReport = YES;
//                [self.navigationController pushViewController:archview animated:YES];
//                //                EditArchiveController *edit = [[EditArchiveController alloc] init];
//                //                [self.navigationController pushViewController:archview animated:YES];
//            }
//                break;
//            case 2:
//            {
//                FamilyMemberViewController  *familyVC = [[FamilyMemberViewController alloc]init];
//
//                [self.navigationController pushViewController:familyVC animated:YES];
//            }
//                break;
//            case 3:
//            {
//                AdvertisementController *sement=[[AdvertisementController alloc]init];
//                sement.title = @"免费体检预约";
//                sement.webUrlStr = XKMedicalAppointmentURL;
//                /**
//                 http://192.168.1.6:8021/ReportOverall/AppointmentPhysicalActive?themeID=1
//                 http://api.xiekang.net/ReportOverall/AppointmentPhysicalActive?themeID=1
//                 */
//                [self.navigationController pushViewController:sement animated:YES];
//                //                ArchiveViewController *archview = [[ArchiveViewController alloc] init];
//                //                [self.navigationController pushViewController:archview animated:YES];
//            }
//                break;
//            case 4:
//            {
//                ArchiveViewController *archview = [[ArchiveViewController alloc] init];
//                archview.isHistoryReport = YES;
//                [self.navigationController pushViewController:archview animated:YES];
//                //                XKHealthyCheck *hCheck = [[XKHealthyCheck alloc] init];
//                //                 [self.navigationController pushViewController:hCheck animated:YES];
//            }
//                break;
//            case 5://关联设备
//            {
//                HouseholdCheckHomeController *dect = [[HouseholdCheckHomeController alloc]init];
//                //                dect.style = XKDetectBloodPressureStyle;
//                [self.navigationController pushViewController:dect animated:YES];
//                //                XKTopicHomeController *topic = [[XKTopicHomeController alloc] init];
//                //                [self.navigationController pushViewController:topic animated:YES];
//            }
//                break;
//            case 6://购买商品
//            {
//                //                http://192.168.1.6:8026/Mall/Index?Token= ''&OSType=2
//                XKHealthMallHome *sement=[[XKHealthMallHome alloc]init];
//                //                sement.title = @"商城";
//                //                sement.webUrlStr = XKTaskListBuyURL;
//                /**
//                 http://192.168.1.6:8021/ReportOverall/AppointmentPhysicalActive?themeID=1
//                 http://api.xiekang.net/ReportOverall/AppointmentPhysicalActive?themeID=1
//                 */
//                sement.isTask = YES;
//                [self.navigationController pushViewController:sement animated:YES];
//                //                HouseholdCheckHomeController *house = [[HouseholdCheckHomeController alloc] init];
//                //
//                //                [self.navigationController pushViewController:house animated:YES];
//                NSLog(@"调整到商城页面 ---  商城页面暂时没出");
//
//            }
//                break;
//            case 7://健康资讯评论
//            {
//                XKInfomationViewController *info = [[XKInfomationViewController alloc]init];
//                [self.navigationController pushViewController:info animated:YES];
//            }
//                break;
//            case 8://分享
//            {
//                XKHealthIntegralShardController *shard = [[XKHealthIntegralShardController alloc] init];
//                shard.dataModel = self.taskListModel;
//                [self.navigationController pushViewController:shard animated:YES];
//
//            }
//                break;
//
//            default:
//                break;
//        }
//
//    }

}

/**
 每个cell高度设置
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6.f;
}

/**签到成功视图的协议方法*/
-(void)clickToMall{
  
//    XKHealthMallHome *sement=[[XKHealthMallHome alloc]init];
//
//    /**
//     http://192.168.1.6:8021/ReportOverall/AppointmentPhysicalActive?themeID=1
//     http://api.xiekang.net/ReportOverall/AppointmentPhysicalActive?themeID=1
//     */
//    sement.isTask = YES;
//    [self.navigationController pushViewController:sement animated:YES];
    
    MallViewController *mall = [[MallViewController alloc]initWithType:pageTypeNormal];
    [self.navigationController pushViewController:mall animated:NO];
}

#pragma mark    弹出弹窗签到成功
-(void)popTaskView:(XKHealthIntergralDailyQuestListModel *)md
{
   
    //加载视图并赋值数据
    XKHealthIntegralSignSuccessView *sv = [[[NSBundle mainBundle] loadNibNamed:@"XKHealthIntegralSignSuccessView" owner:self options:nil] firstObject];
    sv.frame =  [UIScreen mainScreen].applicationFrame;
    [[UIApplication sharedApplication].delegate.window addSubview:sv];
    sv.delegate = self;
    //先调用940 在调用942 完成页面展示
    [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
    NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"TypeID":@(md.TaskTypeID),@"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"940" parameters:dict success:^(id json) {

        NSLog(@"940--:%@",json);

        /**给k值康币lab赋值*/
        sv.kCountLab.text = [NSString stringWithFormat:@"%li",md.KValue];
        sv.kangCountLab.text = [NSString stringWithFormat:@"%li",md.KCurrency];

        if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            [[XKLoadingView shareLoadingView] hideLoding];

            [[XKLoadingView shareLoadingView] showLoadingText:@"加载中"];
            NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"TopNumber":@(3),@"Days":@(md.Days)};
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"942" parameters:dict success:^(id json) {
                NSLog(@"942--:%@",json);

                if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
                    [[XKLoadingView shareLoadingView] hideLoding];

                    //签到成功之后重新加载数据
                    [self loadTaskData];

                    NSArray *array = [XKHealthIntegralSginModel objectArrayWithKeyValuesArray:json[@"Result"][@"ReplyHotProductList"]];

                    XKHealthIntegralSginModel *model1 = array[0];
                    sv.tomarroyCountLab.text = [NSString stringWithFormat:@" 明日签到+%li康币",[json[@"Result"][@"Integral"] integerValue]];
                    [sv.signEquipmentImgOne sd_setImageWithURL:[NSURL URLWithString:model1.ImgUrl]];
                    sv.signEquipmentLabOne.text = model1.ProductName;

                    XKHealthIntegralSginModel *model2 = array[1];
                    [sv.signEquipmentImgTwo sd_setImageWithURL:[NSURL URLWithString:model2.ImgUrl]];
                    sv.signEquipmentLabTwo.text = model2.ProductName;

                    XKHealthIntegralSginModel *model3 = array[2];
                    [sv.signEquipmentImgThree sd_setImageWithURL:[NSURL URLWithString:model3.ImgUrl]];
                    sv.signEquipmentLabThree.text = model3.ProductName;

                    md.Iscomplete = 1;//设置为任务完成
                    [self.tableView reloadData];

                    NSLog(@"签到成功😆😆😆😆😆😆😆😆😆");

                }else{
                    [[XKLoadingView shareLoadingView] errorloadingText:@"签到失败"];
                }
            } failure:^(id error) {
                NSLog(@"%@",error);
                [[XKLoadingView shareLoadingView] errorloadingText:@"签到失败"];
            }];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"签到失败"];
        }
    } failure:^(id error) {
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:@"签到失败"];
    }];
    
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
