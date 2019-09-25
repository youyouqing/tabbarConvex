//
//  PersonalCenterViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "XKMineFavourViewController.h"
#import "XKFolloeRecordTableViewController.h"
#import "ProFileTopView.h"
#import "ProfileCell.h"
#import "SettingsController.h"
#import "MineSuggestView.h"
#import "MineContactView.h"
#import "HealthExamineController.h"
#import "HealthRecordController.h"
#import "JudgeReportController.h"
#import "MineElectronMedicController.h"
@interface PersonalCenterViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat tagRowHight;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic,strong) ProFileTopView *topView;
@property (nonatomic,strong) NSMutableArray *profileMessageArray;
@property (nonatomic,strong) NSMutableDictionary *contactDic;

@end

@implementation PersonalCenterViewController
#define headRect CGRectMake(0,0,self.view.bounds.size.width,190)
#define VCWidth self.view.bounds.size.width
#define VCHeight self.view.bounds.size.height
#define navHeight 44 //上推留下的高度
-(ProFileTopView *)topView{
    
    if (!_topView) {
        
        _topView=[[[NSBundle mainBundle]loadNibNamed:@"ProFileTopView" owner:self options:nil]firstObject];
        _topView.frame = CGRectMake(0, 0, KScreenWidth,392);
        _topView.delegate = self;
        
    }
    return _topView;
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-(kTabbarHeight));//+NavigationBarHeight+StatusBarHeight
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = kbackGroundGrayColor;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainColor;
    //数据源
    NSDictionary *dict1=@{@"img":@"icon_tijianbaogao",@"remark":@"体检报告",@"hiddenLine":@"0",@"viewTag":@"0"};
    NSDictionary *dict2=@{@"img":@"icon_zicebaogao",@"remark":@"自测报告",@"hiddenLine":@"0",@"viewTag":@"1"};
    NSDictionary *dict3=@{@"img":@"icon_jiankangdangan",@"remark":@"健康档案",@"hiddenLine":@"0",@"viewTag":@"2"};
    NSDictionary *dict4=@{@"img":@"icon_my_familyfile",@"remark":@"家人档案",@"hiddenLine":@"0",@"viewTag":@"3"};
    NSDictionary *dict5=@{@"img":@"icon_dianzibingli",@"remark":@"电子病历",@"hiddenLine":@"1",@"viewTag":@"4"};
    NSDictionary *dict6=@{@"img":@"icon_my_order",@"remark":@"我的订单",@"hiddenLine":@"1",@"viewTag":@"5"};
    
    NSDictionary *dict7=@{@"img":@"icon_my_familyfile",@"remark":@"系统设置",@"hiddenLine":@"2",@"viewTag":@"6"};
    NSDictionary *dict8=@{@"img":@"icon_my_suggestion",@"remark":@"意见反馈",@"hiddenLine":@"2",@"viewTag":@"7"};
    NSDictionary *dict9=@{@"img":@"icon_my_customerservice",@"remark":@"联系客服",@"hiddenLine":@"2",@"viewTag":@"8"};
    
    
    NSDictionary *dict10=@{@"img":@"icon_suifangjilu",@"remark":@"随访记录",@"hiddenLine":@"1",@"viewTag":@"9"};
    NSDictionary *dict11=@{@"img":@"icon_wodeshoucang",@"remark":@"我的收藏",@"hiddenLine":@"1",@"viewTag":@"10"};
    NSDictionary *dict12=@{@"img":@"icon_my_familyfile",@"remark":@"手机换绑",@"hiddenLine":@"2",@"viewTag":@"11"};
    
    NSDictionary *dict13=@{@"img":@"icon_my_card",@"remark":@"我的卡券",@"hiddenLine":@"1",@"viewTag":@"12"};
    
    NSDictionary *dict14=@{@"img":@"icon_my_appointment",@"remark":@"我的预约",@"hiddenLine":@"1",@"viewTag":@"13"};
    //数组初始化
    self.profileMessageArray = [NSMutableArray array];
     self.tableView.tableHeaderView = self.topView;
    self.topView.arr = @[dict1,dict2,dict5,dict3,dict11,dict10];
    [self.profileMessageArray addObject:@[dict14,dict6,dict13,dict8,dict9]];
    [self.view addSubview:self.tableView];
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCell"];
    [self loadData];//获取终端信息，邮件，电话等
    
    self.contactDic = [[NSMutableDictionary alloc]init];
    self.contactDic[@"FourPhone"] = @"";
    self.contactDic[@"Email"] = @"";
    
//    //跳转到在线客服
//    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(clickChatService) name:@"chatToMine" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(frsheUsermssge:) name:@"freshU" object:nil];
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"205" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token} success:^(id json) {

        NSLog(@"%@",json);

        [[NSUserDefaults standardUserDefaults] setObject:json[@"Result"] forKey:@"feedbackMessage"];

    } failure:^(id error) {

        NSLog(@"%@",error);

    }];
    //刷新个人中心数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadInfoData) name:@"reNameLoad" object:nil];
    
    //刷新个人中心数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadInfoData) name:@"reGetUserMsgl" object:nil];
    
}
/**
 我的消息点击
 */
- (void)clickMianMessage:(id)sender {
    self.topView.editYesOrNO = NO;
    [self.topView.nameLal resignFirstResponder];
//    NSLog(@"我的消息点击");
//
//    XKMianMessageController *mine=[[XKMianMessageController alloc]initWithStyle:UITableViewStylePlain];
//
//    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:mine];
//
//    nav.transitioningDelegate=(id)self.modelDelegate;
//
//    nav.modalPresentationStyle=UIModalPresentationCustom;
//
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self  requestMessageLab];
//    });
//
//    [self  presentViewController:nav animated:YES completion:nil];
//
    
}

-(void)frsheUsermssge:(NSNotification *)noti{
    
  
    
    self.topView.freshDic=noti.object;
    
}

//注销通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [user objectForKey:@"XKPersonmineInfo"];
    if (dic.count != 0) {
        self.topView.dic = dic;
    }
    
    [self loadInfoData];//获取个人信息
    
  
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    CGFloat sectionHeaderHeight = 392;
//
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//
//    }
//    CGFloat offset_Y = scrollView.contentOffset.y + headRect.size.height-navHeight-navHeight;
//
//    if  (offset_Y < 0) {
//
//        _topView.backgroundView.contentMode = UIViewContentModeScaleToFill;
//
//        _topView.backgroundView.frame = CGRectMake(offset_Y*0.5 , -navHeight, VCWidth - offset_Y, headRect.size.height - offset_Y);
//    }else if (offset_Y > 0 && offset_Y <= (headRect.size.height-navHeight-navHeight)) {
//
//        _topView.backgroundView.contentMode = UIViewContentModeTop;
//
//        CGFloat y = navHeight* offset_Y/(headRect.size.height-navHeight-navHeight)-navHeight;
//
//        _topView.backgroundView.frame = CGRectMake(0 ,y , VCWidth , headRect.size.height -(navHeight + y) - offset_Y);
//
//
////        CGFloat width = offset_Y*(40-(VCWidth / 4))/(headRect.size.height-navHeight-navHeight)+(VCWidth / 4);
////        _topView.headView.frame =CGRectMake(0, 0, width,width);
////        _topView.headView.layer.cornerRadius =width*0.5;
////        _topView.headView.center = _myView.backgroundView.center;
////
////        _topView.signLabel.frame =CGRectMake(0, CGRectGetMaxY(_myView.headView.frame), VCWidth, 40);
////
////        _topView.signLabel.alpha = 1 - (offset_Y*3 / (headRect.size.height-navHeight-navHeight) /2);
//    }else if(offset_Y > (headRect.size.height-navHeight-navHeight)) {
//        _topView.backgroundView.contentMode = UIViewContentModeTop;
//
//        CGFloat y = navHeight* (headRect.size.height-navHeight-navHeight)/(headRect.size.height-navHeight-navHeight)-navHeight;
//
//        _topView.backgroundView.frame = CGRectMake(0 ,y , VCWidth , headRect.size.height -(navHeight + y) - (headRect.size.height-navHeight-navHeight));
//
//
////        CGFloat width = (headRect.size.height-navHeight-navHeight)*(40-(VCWidth / 4))/(headRect.size.height-navHeight-navHeight)+(VCWidth / 4);
////        _topView.headView.frame =CGRectMake(0, 0, width,width);
////        _topView.headView.layer.cornerRadius =width*0.5;
////        _topView.headView.center = _myView.backgroundView.center;
////
////        _topView.signLabel.frame =CGRectMake(0, CGRectGetMaxY(_myView.headView.frame), VCWidth, 40);
////
////        _topView.signLabel.alpha = 1 - ((headRect.size.height-navHeight-navHeight)*3 / (headRect.size.height-navHeight-navHeight) /2);
//    }
}

#pragma mark - 获取头像等基础信息
-(void)loadInfoData
{
    NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,
                           @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};

    //注释的原因是因为每次进来都要请求，如果网络不好的情况下需要等待12秒很影响体验
    //    [[XKLoadingView shareLoadingView] showLoadingText:@"加载中"];

    [ProtosomaticHttpTool protosomaticPostWithURLString:@"135" parameters:dict success:^(id json) {
        NSLog(@"我的个人信息135换新头像：%@",json);
        //        [[XKLoadingView shareLoadingView] hideLoding];
        NSDictionary *dic=(NSDictionary *)json;
        //        [dic removeObjectForKey:dic[@"Basis"][@"Model"]];//删除没用的信息
        NSLog(@"%@",dic);
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            //            self.topView.dic = dic;

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:dic forKey:@"XKPersonmineInfo"];
            self.topView.dic = dic;//给个人中心头部赋值

            UserInfoModel *model = [UserInfoTool getLoginInfo];
            model.HeadImg = dic[@"Result"][@"HeadImg"];
            model.NickName = [((NSString *)dic[@"Result"][@"NickName"]) length] == 0 ? @"": (NSString *)dic[@"Result"][@"NickName"];
            NSNumber *age = dic[@"Result"][@"Age"];
//            NSString  *ageStr = (age == nil)?@"年龄不详":[NSString stringWithFormat:@"%@ 岁",age];
             model.Age = [age integerValue];
            [UserInfoTool saveLoginInfo:model];
        }else{
            NSLog(@"我的个人信息135：%@----%@",dict,json);
            //             [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
        }

    } failure:^(id error) {

        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
    }];

}


//获取联系客服中的--邮件，电话数据
-(void)loadData
{
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"Type":@4};

    [ProtosomaticHttpTool protosomaticPostWithURLString:@"201" parameters:dict success:^(id json) {
        NSLog(@"%@",json);
        NSDictionary *dic=[json objectForKey:@"Basis"];
        if ([[NSString stringWithFormat:@"%@",dic[@"Status"]] isEqualToString:@"200"]) {
            NSDictionary *resultDic = [json objectForKey:@"Result"];
            self.contactDic[@"FourPhone"] = resultDic[@"FourPhone"];
            self.contactDic[@"Email"] = resultDic[@"Email"];
        }else{

        }

    } failure:^(id error) {
        NSLog(@"%@",error);

    }];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.profileMessageArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.profileMessageArray[section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.messageDict=self.profileMessageArray[indexPath.section][indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 49;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.01;
}

//选中cell的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {

//         http://192.168.1.6:8021/ReportOverall/AppointmentPhysicalActive?themeID=1
        //我的订单
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
        web.urlString = [NSString stringWithFormat:@"%@/ReportOverall/AppointmentPhysicalActive?Token=%@&OSType=2&Version=%@",MallUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        web.myTitle = @"我的预约";
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        

    }else if (indexPath.row==3){
        //意见反馈
        MineSuggestView *suggestView = [[[NSBundle mainBundle]loadNibNamed:@"MineSuggestView" owner:self options:nil] lastObject];
        suggestView.alpha = 0;
        suggestView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:suggestView];

        [UIView animateWithDuration:0.25 animations:^{
            suggestView.alpha = 1;
        }];

    }

    else if(indexPath.row==4){
        //联系客服
        MineContactView *contactView = [[[NSBundle mainBundle]loadNibNamed:@"MineContactView" owner:self options:nil] lastObject];
        contactView.alpha = 0;
        contactView.dic = self.contactDic;//邮箱和电话传值
        contactView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:contactView];

        [UIView animateWithDuration:0.25 animations:^{
            contactView.alpha = 1;
        }];

    }
    else if (indexPath.row == 1)
    {

      
            //我的订单
            NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
            
            web.urlString = XKMyOderURL;
            web.myTitle = @"我的订单";
              web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];

     

    }
    else if (indexPath.row == 4)
    {
        NSString *itunesurl = @"itms-apps://itunes.apple.com/cn/app/id1164831524?mt=8&action=write-review";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
    }
    else if(indexPath.row == 2){//现金券
        
        
        
        
        HealthWiKiViewController *web = [[HealthWiKiViewController alloc]initWithType:pageTypeNormal];
        
        web.urlString = XKCashCouponURL;
        web.myTitle = @"我的卡券";
         web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }
}

#pragma mark - 点击btton的响应事件
-(void)clickBtnProFileTopView:(NSInteger)viewTag;
{
    NSLog(@"%li",viewTag);
    [self.topView.nameLal resignFirstResponder];
    self.topView.editYesOrNO = NO;
    if (viewTag == 0) {
       
        HealthExamineController *Examine =[[HealthExamineController alloc]initWithType:pageTypeNormal];
        Examine.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Examine animated:YES];
        
    }else if(viewTag == 6){
        SettingsController *settring = [[SettingsController alloc]initWithType:pageTypeNormal];
        settring.myTitle = @"系统设置";
         settring.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settring  animated:YES ];
    }
   
    else if(viewTag == 1){
        //评测报告
        JudgeReportController *judgeReport = [[JudgeReportController alloc]init];
        judgeReport.myTitle = @"评测报告";
         judgeReport.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:judgeReport animated:YES];
    }

    else if(viewTag == 10){
        XKMineFavourViewController *orderVC =[[XKMineFavourViewController alloc]initWithType:pageTypeNormal];
        orderVC.myTitle = @"我的收藏";
       orderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderVC  animated:YES ];
    }
    else if(viewTag == 9){//随访

        XKFolloeRecordTableViewController *orderVC =[[XKFolloeRecordTableViewController alloc]init];
        orderVC.myTitle = @"随访记录";
         orderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderVC  animated:YES ];
        
    }else if (viewTag == 2)
    {
        HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
         record.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:record animated:YES];
        
    }else if (viewTag == 4)
    {
        
        MineElectronMedicController *detail = [[MineElectronMedicController alloc]initWithType:pageTypeNormal];
         detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
        
    }
   
    else if (viewTag == 787878)
    {
        
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
        web.isNewHeight = YES;
        web.urlString = kMyKCurrenyUrl;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
        
    }
}

#pragma mark -- 接收通知，进入客服页面

-(void)clickChatService
{
    
//    UserModel *user=[UserInfoTool getLoginInfo];
//    //判断用户是否注册环信
//    if (user.EasemobRegister == 1) {
//        //**已经注册环信，登录
//        BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
//        NSLog(@"%@,%@", user.UserAccount, @"888888");
//        if (!isAutoLogin) {
//            EMError *error = [[EMClient sharedClient] loginWithUsername:user.UserAccount   password:@"888888"]; //密码暂时默认888888
//
//            //判断环信是否登录成功
//            if (error==nil) {
//                NSLog(@"登录成功");
//                //设置自动登录
//                [[EMClient sharedClient].options setIsAutoLogin:YES];
//                [self toChat];
//
//            }else{
//                NSLog(@"登录失败code :%u ，%@ ",error.code,error.errorDescription);
//                [[XKLoadingView shareLoadingView] errorloadingText:@"客服繁忙，请稍等"];
//            }
//
//        }else{
//
//            [self toChat];
//
//        }
//
//    }else{
//        //**未注册环信，调注册接口
//        [self loadJudgeEase];
//
//    }
}

-(void)toChat
{
    /**
     Basis =     {
     Msg = "\U64cd\U4f5c\U6210\U529f";
     Sign = "";
     Status = 200;
     };
     Result =     {
     Age = 21;
     HeadImg = "";
     NickName = "";
     ServiceAccount = wangw003;
     };
     **/
//    //从135接口获得客服id
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dic = [user objectForKey:@"XKPersonmineInfo"];
//    NSString *easeId = dic[@"Result"][@"ServiceAccount"];
//    if (easeId == nil ||easeId.length == 0) {
//        return;
//    }
//    //在线客服
//    ChatViewController *vc = [[ChatViewController alloc] initWithConversationChatter:easeId conversationType:EMConversationTypeChat];
//    vc.isOnline = YES;
//    vc.title = @"客服";
//    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:vc];
//    nav.transitioningDelegate=(id)self.modelDelegate;
//    nav.modalPresentationStyle=UIModalPresentationCustom;
//    [self presentViewController:nav animated:YES completion:nil];
    
}
-(void)loadJudgeEase
{
//    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
//
//    [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中..."];
//    [ProtosomaticHttpTool protosomaticPostWithURLString:@"103" parameters:dict success:^(id json) {
//        NSLog(@"环信注册接口-- 103：%@",json);
//        NSDictionary *dic=(NSDictionary *)json;
//
//        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
//            [[XKLoadingView shareLoadingView] hideLoding];
//
//            //改变登录数据缓存中 --环信注册的标识字段为1
//            NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[UserInfoTool getLoginInfoDic]];
//            [userDic setObject:@1 forKey:@"EasemobRegister"];
//            [UserCaches setUserCache:userDic];
//
//            UserModel *user=[UserInfoTool getLoginInfo];
//            EMError *error = [[EMClient sharedClient] loginWithUsername:user.UserAccount   password:@"888888"]; //密码暂时默认888888 md5加密
//
//            //判断环信是否登录成功
//            if (error==nil) {
//                NSLog(@"登录成功");
//                //设置自动登录
//                [[EMClient sharedClient].options setIsAutoLogin:YES];
//                [self toChat];
//
//            }else{
//                NSLog(@"登录失败code :%u ，%@ ",error.code,error.errorDescription);
//                [[XKLoadingView shareLoadingView] errorloadingText:@"客服繁忙，请稍等"];
//            }
//
//        }else{
//            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
//        }
//
//    } failure:^(id error) {
//
//        NSLog(@"%@",error);
//        [[XKLoadingView shareLoadingView] errorloadingText:error];
//    }];
//
}

@end
