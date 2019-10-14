//
//  HomeViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HomeViewController.h"
#import "HealthRecordController.h"
#import "HealthExamineController.h"
#import "HomeViewModel.h"
#import "MedicTableViewCell.h"
#import "InformationCell.h"
#import "HealthRecordController.h"
#import "XKNewHomeInSectionHeadView.h"
#import "SportViewController.h"
#import "XKNewHomeHeadView.h"
#import "XKMyPlanLookCell.h"
#import "AdvertiseModel.h"
#import "MallViewController.h"
#import "BreathTrainViewController.h"
#import "TrainWithMusicViewController.h"
#import "MusicTrainViewModel.h"
#import "XKInfomationViewController.h"
#import "QuietController.h"
#import "XKHomePlanModel.h"
#import "XKNewModel.h"
#import "WikiTypeList.h"
#import "WikiEncyTypeList.h"
#import "XKInformationDetail.h"
#import "XKHealthIntegralTaskSuccessView.h"
#import "XKNewHomeHealthPlanCell.h"
#import "HealthPlanTableViewCell.h"
#import "HealthPlanTopCell.h"
@interface HomeViewController ()
{
    int informationWikiListCount;//资讯分类的列表的数
    
}
@property (strong, nonatomic) XKNewHomeHeadView *headView;
@property (strong, nonatomic)  UITableView *tableView;
///百科分类列表
@property (nonatomic, strong) NSArray *WikiEncyTypeListArray;

///健康计划
@property (nonatomic, strong) NSArray *HealthPlanListArray;

///健康资讯
@property (nonatomic, strong) NSArray *WikiListArray;

//资讯分类列表
@property (nonatomic, strong) NSArray *WikiTypeList;


@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *udf=[NSUserDefaults standardUserDefaults];
    
    NSArray *imgArr=[udf objectForKey:@"homePageImge"];
    
    imgArr=[AdvertiseModel objectArrayWithKeyValuesArray:imgArr];
    self.headView.imgArray=imgArr;
  
//    //拉去首页数据
    [self getHotTopicHealthPlanAndMoreWithNetWorking:NO];

}
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    self.WikiEncyTypeListArray = [NSMutableArray arrayWithCapacity:0];
    self.HealthPlanListArray = [NSMutableArray arrayWithCapacity:0];
    self.WikiListArray = [NSMutableArray arrayWithCapacity:0];
    self.WikiTypeList = [NSMutableArray arrayWithCapacity:0];
//    [self getHotTopicHealthPlanAndMoreWithNetWorking:YES];
    
   
}

#pragma mark UI
- (void)createUI
{

    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-(kTabbarHeight)) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView= self.headView;
    _tableView.bounces = NO;

    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MedicTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XKNewHomeHealthPlanCell" bundle:nil] forCellReuseIdentifier:@"HomeHealthPlan"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XKMyPlanLookCell" bundle:nil] forCellReuseIdentifier:@"XKMyPlanLookCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationCell" bundle:nil] forCellReuseIdentifier:@"InformationCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HealthPlanTableViewCell" bundle:nil] forCellReuseIdentifier:@"HealthPlanTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HealthPlanTopCell" bundle:nil] forCellReuseIdentifier:@"HealthPlanTopCell"];
  
  
}


#pragma mark NetWorking
- (void)getHotTopicHealthPlanAndMoreWithNetWorking:(BOOL)reload
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"PageIndex":@1,
                          @"PageSize":@4};
      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HomeViewModel getHotTopicHealthPlanAndMoreWithParams:dic FinishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.WikiEncyTypeListArray = (NSMutableArray *)[WikiEncyTypeList mj_objectArrayWithKeyValuesArray:response.Result[@"WikiEncyTypeList"]];
            
            self.HealthPlanListArray = (NSMutableArray *)[XKHomePlanModel mj_objectArrayWithKeyValuesArray:response.Result[@"HealthPlanList"]];// response.Result[@"HealthPlanList"];
            
            self.WikiListArray = (NSMutableArray *)[XKNewModel  mj_objectArrayWithKeyValuesArray:response.Result[@"WikiList"]];
            
            self.WikiTypeList = (NSMutableArray *)[WikiTypeList  mj_objectArrayWithKeyValuesArray:response.Result[@"WikiTypeList"]];
            
            self.headView.imgArray=[AdvertiseModel mj_objectArrayWithKeyValuesArray:response.Result[@"AdvertiseList"]];
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            [ud setValue:response.Result[@"AdvertiseList"] forKey:@"homePageImge"];
            informationWikiListCount = self.WikiListArray.count;
//              (InformationCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//            InformationCell *cell =   [self.tableView dequeueReusableCellWithIdentifier:@"InformationCell" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//            NSInteger pos = [ud integerForKey:@"posTitles"];
////            if(reload){
//                //            (InformationCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//                NSLog(@"cell.superview---%@",cell.superview);
//                cell.WikiTypeList1 = (NSMutableArray *)[WikiTypeList  objectArrayWithKeyValuesArray:response.Result[@"WikiTypeList"]];
//
////            }
//            if (cell) {
//                 [cell replaceData:self.WikiListArray[pos]];
//            }
//
             [self.tableView reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return self.HealthPlanListArray.count>0?(self.HealthPlanListArray.count):1;
    }
    else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   
   if (indexPath.section==0) {
     
       if (self.HealthPlanListArray.count > 0) {
           if (indexPath.row == 0&& self.HealthPlanListArray.count>1) {
               NSString *cellid = @"HealthPlanTopCell";
               HealthPlanTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
               cell.planModel = self.HealthPlanListArray[indexPath.row];
               cell.delegate = self;
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               return cell;
           }else if (indexPath.row == self.HealthPlanListArray.count-1&& self.HealthPlanListArray.count>1)
           {
               NSString *cellid = @"HealthPlanTableViewCell";
               HealthPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
               cell.planModel = self.HealthPlanListArray[indexPath.row];
               cell.delegate = self;
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
               UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth, KHeight(126)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
               maskTwoLayer.frame = corTwoPath.bounds;
               maskTwoLayer.path=corTwoPath.CGPath;
               cell.layer.mask=maskTwoLayer;
               return cell;
               
           }
           else
           {
           NSString *cellid = @"XKMyPlanLookCell";
           XKMyPlanLookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           XKHomePlanModel *mod  = self.HealthPlanListArray[indexPath.row];
           if (self.HealthPlanListArray.count-1 == indexPath.row&& self.HealthPlanListArray.count == 1) {
               mod.isMiddle = YES;
               cell.planModel = mod;
           }else
               cell.planModel = mod;
           CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
           UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth, KHeight(126)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
           maskTwoLayer.frame = corTwoPath.bounds;
           maskTwoLayer.path=corTwoPath.CGPath;
           cell.layer.mask=maskTwoLayer;
           
           cell.delegate = self;
           return cell;
           }
       }else{
           
           XKNewHomeHealthPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHealthPlan" forIndexPath:indexPath];
           cell.selectionStyle=UITableViewCellSelectionStyleNone;
           cell.isEmpty = YES;
           cell.delegate = self;
            return cell;
       }
    }
    else  if (indexPath.section==2)
    {
        InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];//最好在xib文件中设置id
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"InformationCell" owner:nil options:nil].firstObject;
        }

        cell.WikiList = self.WikiListArray;
        cell.WikiTypeList1 = self.WikiTypeList;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    else
    {
        MedicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.WikiEncyTypeList = self.WikiEncyTypeListArray;
        return cell;
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康计划";
       headV.delegate = self;
        return headV;
    }else if (section == 1){
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康百科";
        headV.delegate = self;
        headV.arrowImg.hidden = NO;
        return headV;
    }
    else{
        XKNewHomeInSectionHeadView *headV=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeInSectionHeadView" owner:self options:nil]  firstObject];
        headV.titleLab.text=@"健康资讯";
         headV.delegate = self;
        return headV;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section<=2) {
        return 45+5;
    }
    else
    {
        
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
       NSInteger count = (self.WikiListArray.count+1)/2;
        
          return (((KScreenWidth-25*2-10)/2.0)*246/158.0+5.0)*count+KHeight(45)+KHeight(29)+6.0;
//        return (KHeight(246)+29)*count+KHeight(45);
    }
    if (indexPath.section==1) {
        
      return  self.WikiEncyTypeListArray.count>1?(153):(0.01);
        
    }
    if(indexPath.section==0){
        if (indexPath.row !=0&& self.HealthPlanListArray.count>1&&indexPath.row !=self.HealthPlanListArray.count-1){
            
            return KHeight(126)-10;
        }else
        {
            if (self.HealthPlanListArray.count-1 == indexPath.row&& self.HealthPlanListArray.count == 1)
                return KHeight(126);
            
        }
        return KHeight(126);
    }
    else{
        return  218*(KScreenWidth-36)/716+30.0;//KHeight(126);
    }
    
}

-(XKNewHomeHeadView *)headView{
    
    if (!_headView) {
        
        _headView=[[[NSBundle mainBundle]loadNibNamed:@"XKNewHomeHeadView" owner:self options:nil]firstObject];
        _headView.left=0;
        _headView.top=0;
        _headView.width=KScreenWidth;
        
//        if (IS_IPHONE5) {//13工具部分比之前多了13个像素点
//            _headView.height=(759);//原来banner图高度是150  现在iPhone5的改为115
//        }else if (IS_IPHONE6){
//            _headView.height=809;//原来banner图高度是150  现在iPhone5的改为135
//        }else{
//            _headView.height=839;
//        }
        int healthLiveHeightCons = 0;
        if (IS_IPHONE5) {
           healthLiveHeightCons = 258;
        }else if (IS_IPHONE6){
            healthLiveHeightCons = 258+20;
        }else{
            healthLiveHeightCons = 258+40;
        }
        _headView.height = KScreenWidth*332/750.0+5+347+6+healthLiveHeightCons;
        _headView.delegate = self;
    }
    
    return _headView;
    
}


#pragma mark HealthTestHeadView Delegate
- (void)buttonClickAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < 4)
    {
        if (buttonIndex == 1) {
            BreathTrainViewController *breath = [[BreathTrainViewController alloc]initWithType:pageTypeNoNavigation];
            breath.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:breath animated:YES];
        }
        else  if (buttonIndex == 3)
        {
            
          [self getMorningEverningAndMindfulnessListWithNetworking:3];
        }
        else  if (buttonIndex == 2)
        {
            
            [self getMorningEverningAndMindfulnessListWithNetworking:buttonIndex];
        }
        else  if (buttonIndex == 0)
        {
            
            SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
            sport.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sport animated:YES];
        }
//        if (self.headViewDataArray.count == 0)
//        {
//            [AlertView showMessage:@"正在拉取数据,请稍后重试" withTitle:@"提示" sureButtonTitle:@"确定"];
//            return;
//        }

    }else
    {
        SensoryTestViewController *test = [[SensoryTestViewController alloc]initWithType:pageTypeNoNavigation];
        
        if (buttonIndex == 4)
        {
            //视力测试
            test.testType = sensoryTypeVision;
        }
        
        if (buttonIndex == 5)
        {
            //色觉测试
            test.testType = sensoryTypeColorVision;
        }
        
        if (buttonIndex == 6)
        {
            //柔韧度测试
            test.testType = sensoryTypeFist;
        }
        
        if (buttonIndex == 7)
        {
            //挥拳测试
            test.testType = sensoryTypeFlexibility;
        }
        test.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:test animated:YES];
    }
}
- (void)buttonClickMainAtIndex:(NSString *)url title:(NSString *)title index:(NSInteger)tag;
{
    
    if (tag == 3) {
        XKInfomationViewController *info = [[XKInfomationViewController alloc]initWithType:pageTypeNormal];
//        info.myTitle = title;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }else if (tag == 2)
    {
        //健康百科
        HealthWiKiViewController *web = [[HealthWiKiViewController alloc]initWithType:pageTypeNormal];
        web.urlString = url;
        web.myTitle = @"健康百科";
//        web.isNewHeight = YES;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
        
    }
    else if (tag == 4)
    {
        NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
        web.urlString = kHealthPlanUrl;
        web.myTitle = @"我的计划";
        web.hidesBottomBarWhenPushed = YES;
        web.isNewHeight = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }

}
- (void)refreshCell:(NSArray *)modelArr;
{
    self.WikiListArray = [[NSMutableArray alloc]initWithArray:modelArr];
    if (self.WikiListArray.count!= informationWikiListCount) {
         [self.tableView reloadData];
    }
    informationWikiListCount = self.WikiListArray.count;
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2] ] withRowAnimation:UITableViewRowAnimationBottom];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]atScrollPosition:UITableViewScrollPositionBottom animated:NO];

}


-(void)buttonClickController:(NSString *)nameController urlString:(NSString *)url title:(NSString *)title;
{
    
//    Class classCon = NSClassFromString(nameController);
   
    id classCon = [[NSClassFromString(nameController) alloc]init];
    if ([classCon isKindOfClass:[NoralWebViewController class]]) {
        
        //调理养生。 健康体检。在线问诊 预约挂号
        NoralWebViewController *web = classCon;
        web.urlString = url;
        web.myTitle = title;
        if ([title isEqualToString:@"预约挂号"]) {
            web.appointmentTitle = @"预约挂号";
        }else
            web.appointmentTitle = @"";
        
         web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }
   else if ([classCon isKindOfClass:[HealthExamineController class]])
    {
        
        HealthExamineController *Examine = [[HealthExamineController alloc]initWithType:pageTypeNormal];
        Examine.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Examine animated:YES];
    }
    
    else  if ([classCon isKindOfClass:[HealthRecordController class]])
    {
        HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
        record.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:record animated:YES];
    }
    else  if ([classCon isKindOfClass:[MallViewController class]])
    {
        MallViewController *mall = [[MallViewController alloc]initWithType:pageTypeNormal];
        mall.homeAdvisterUrlStr = url;
         mall.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mall animated:YES];
    }else if ([classCon isKindOfClass:[HealthWiKiViewController class]])
    {
        
        HealthWiKiViewController *web = [[HealthWiKiViewController alloc]initWithType:pageTypeNormal];
        
        web.urlString = url;
        web.myTitle = title;
         web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }
    
}
#pragma mark NetWorking
- (void)getMorningEverningAndMindfulnessListWithNetworking:(NSInteger)trainType;
{
    
    QuietController *train = [[QuietController alloc]initWithType:pageTypeNormal];
    train.isQuietOrMusic = (trainType == 2)?YES:NO;
    train.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:train animated:YES];
    
  
}

#pragma mark  MedicTableViewCell 点击进入每个百科或者是咨询的详情页
-(void)XKMedicTableViewCellJoinAction:(NSInteger )cellIndex  mod:(WikiEncyTypeList *)WikiEncyTypeListMod;
{
    
    HealthWiKiViewController *web = [[HealthWiKiViewController alloc]initWithType:pageTypeNormal];
//    /AppComm/WikiList?CategoryID=2&ClassId=2&ClassName=
    web.urlString = [NSString stringWithFormat:@"%@&CategoryID=%i&ClassId=2&ClassName=%@",kHealthBaiKeWikiUrl,WikiEncyTypeListMod.CategoryID,WikiEncyTypeListMod.CategoryName];
    web.myTitle = @"健康百科";
    web.hidesBottomBarWhenPushed = YES;
//    web.isNewHeight = YES;阅读健康百科
//    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
//    [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(15)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(15)}];
    [self.navigationController pushViewController:web animated:YES];
    
}
#pragma mark  健康资讯
- (void)InformationCellClick:(XKNewModel *)model;
{
    
    XKInformationDetail *info=[[XKInformationDetail alloc]init];
    info.mod =[[XKWiKIInfoModel alloc]init];
    info.mod.WikiID = model.ID;
    info.mod.WikiName = model.WikiName;
    info.mod.LinkUrl = model.LinkUrl;
    info.hidesBottomBarWhenPushed = YES;
    /*刷新阅读人数*/
//    [self loadHealthData:YES];
    [self.navigationController pushViewController:info animated:YES];
    
}
#pragma  amrk   添加计划
-(void)XKMyPlanLookCellJoinAction:(XKHomePlanModel *)cellModel;
{
    
    [self enterPalnData:cellModel.PlanMainID memPlanID:cellModel.MemPlanID PlanTypeID:cellModel.PlanTypeID];
    
}
-(void)HealthPlanTableViewCellJoinAction:(XKHomePlanModel *)cellModel;
{
    
   [self enterPalnData:cellModel.PlanMainID memPlanID:cellModel.MemPlanID PlanTypeID:cellModel.PlanTypeID];
    
}
-(void)HealthPlanTopCellJoinAction:(XKHomePlanModel *)cellModel;{
    
    [self enterPalnData:cellModel.PlanMainID memPlanID:cellModel.MemPlanID PlanTypeID:cellModel.PlanTypeID];
    
}
//1、饮食 2、运动 3、调理
-(void)enterPalnData:(NSInteger )planMainID memPlanID:(NSInteger )memPlanID PlanTypeID:(NSUInteger)PlanTypeID; {
    NSString *tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanMainIDUrl,(long)planMainID,memPlanID];
    if (PlanTypeID == 1) {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanMainIDUrl,(long)planMainID,memPlanID];
    }else if (PlanTypeID == 2)
    {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanSportIDUrl,(long)planMainID,memPlanID];
    }else
    {
        tempUrlStr = [NSString stringWithFormat:@"%@&planMainID=%li&memPlanID=%i",kHealthPlanNurseIDUrl,(long)planMainID,memPlanID];
        
    }
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    web.urlString = tempUrlStr;
    web.myTitle = @"我的计划";
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}
-(void)XKNewHomeHealthPlanCellbuttonClick
{
    
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.urlString = kHealthPlanUrl;
    web.myTitle = @"我的计划";
    web.hidesBottomBarWhenPushed = YES;
    web.isNewHeight = YES;
    [self.navigationController pushViewController:web animated:YES];
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