//
//  HealthExamineController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthExamineController.h"
#import "HealthPlanView.h"
#import "HealthTopScrollHeaderView.h"
#import "HealthTopScrollHeaderView.h"
#import "Health+ViewController.h"
#import "ExamineReportCell.h"
#import "HealthExamineView.h"
#import "ExamDetailReportViewController.h"
#import "CheerYourselfUpViewController.h"
#import "TrainWithMusicViewController.h"
#import "ShareView.h"
#import "EPluseFooterView.h"
#import "EPluseTemperView.h"
#import "EPluseWeightQView.h"
#import "EPluseHeaderView.h"
#import "EPluseCell.h"
#import "EPluseSugarView.h"
#import "NewTrendDetailController.h"
#import "SportViewController.h"
#import "ProtosomaticHttpTool.h"
#import "HealthRecordViewModel.h"
#import "FamilyObject.h"
#import "AddFamilyViewController.h"
#import "PhysicalList.h"
#import "HomeInspectionListModel.h"
#import "XKHouseHoldModel.h"
@interface HealthExamineController ()<UITableViewDelegate,UITableViewDataSource>
@property(assign,nonatomic) NSInteger  userMemberID;
@property (nonatomic, strong) NSArray *homeArr;//绑定设备ID
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UITableView *ePlusetableView;
///页码
@property (nonatomic, assign) NSInteger pageIndex;
/**
 区头 头部试图
 */
@property (nonatomic,strong)HealthExamineView *headView;
@property (strong, nonatomic) EPluseFooterView *FooterView;
@property (strong, nonatomic)  NSArray *dataArray;
@property (nonatomic, strong) NSArray *PhysicalList;//根据用户ID获取最新的居家检测信息体检数据明细信息
@property (strong, nonatomic)  NSMutableArray *ExanubeReportdataArray;
@property (strong, nonatomic) HealthPlanView *planView;
@property (nonatomic, strong)HealthTopScrollHeaderView *HeaderTopScrollView;
@property (nonatomic, strong) UIView *nullImgeView;

@end

@implementation HealthExamineController
-(void)dealloc{
    
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(HealthTopScrollHeaderView *)HeaderTopScrollView
{
    
    if (!_HeaderTopScrollView) {
        _HeaderTopScrollView = [[[NSBundle mainBundle] loadNibNamed:@"HealthTopScrollHeaderView" owner:self options:nil] firstObject];
        _HeaderTopScrollView.delegate = self;
        _HeaderTopScrollView.left=0;
        _HeaderTopScrollView.top=PublicY;
        _HeaderTopScrollView.width=KScreenWidth;
        
        _HeaderTopScrollView.height= KHeight(180)-(PublicY);
    }
    return _HeaderTopScrollView;
}
-(UIView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.planView.frame),KScreenWidth, KScreenHeight-KHeight(180)-(KHeight(45))) ];
        _nullImgeView.backgroundColor =  kbackGroundGrayColor;
        UIImageView *noDataImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0 ,CGRectGetHeight(self.planView.frame), KScreenWidth/2.0, KScreenWidth/2.15 ) ];
         noDataImageV.center = CGPointMake(KScreenWidth/2, (KScreenHeight - (PublicY))/2 - KScreenWidth/2.15/2);
         noDataImageV.image = [UIImage imageNamed:@"none_dataImage"];
        [_nullImgeView addSubview:noDataImageV];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"健康监测";
    self.pageIndex = 1;
    _ExanubeReportdataArray = [[NSMutableArray alloc]init];
    self.view.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.HeaderTopScrollView];
    [self getHealthSportCategoryArray];
    self.view.backgroundColor =  kbackGroundGrayColor;
    
    /*居家检测测量后检测报告要刷新  测试2019，3，29号测试*/
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_loadNewTopics) name:@"freshHealthDataU" object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getRecordFamilyPersonWithNetWorking];
    [self loadHomeTestData:self.userMemberID];
    
}
#pragma mark  HealthTopScrollHeaderView代理
-(void)addFamilyTools;
{
    
    AddFamilyViewController *detail = [[AddFamilyViewController alloc]initWithType:pageTypeNormal];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark Private Methoud
- (void)addSubViewController
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,KHeight(180), KScreenWidth, KScreenHeight - (PublicY))];
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * self.dataArray.count,KScreenHeight - (PublicY) );// KScreenHeight - (PublicY) - KHeight(45)
    
    [self.view addSubview:scrollView];
    
    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = self.view.frame.size.width / self.dataArray.count;
    HealthPlanView *planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, KHeight(180),KScreenWidth, KHeight(45))];
    planView.tapAnimation = YES;
    planView.headView = headView;
    planView.titleArray = self.dataArray;
    planView.backgroundColor = [UIColor whiteColor];

    UIImageView *bottomImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iv_damgan_yinying"]];
    [planView addSubview:bottomImage];
    bottomImage.frame =CGRectMake(0, planView.height-2, planView.width, 2);
    
    __weak typeof (scrollView)weakScrollView = scrollView;
    [planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
        
        //将两个scrollView联动起来
        [weakScrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(weakScrollView.frame), 0.0, CGRectGetWidth(weakScrollView.frame),CGRectGetHeight(weakScrollView.frame)) animated:animation];
        
    }];
   
    [self.view addSubview:planView];
    self.planView = planView;
    
    for (int i = 0; i < self.dataArray.count; i++)
    {
        
        if (i == 0) {
            //            ExamineReportViewController *subVC = [[ExamineReportViewController alloc]initWithType:pageTypeNoNavigation];
            //
            //            [scrollView addSubview:subVC.view];
            //            [self addChildViewController:subVC];
            //
            //            subVC.view.frame = CGRectMake(0 + i * KScreenWidth,CGRectGetHeight(self.planView.frame), CGRectGetWidth(scrollView.frame), KScreenHeight - (PublicY) - KHeight(45)-(self.planView.frame.size.height)-(self.HeaderTopScrollView.frame.size.height));
            
            self.tableView= [[UITableView alloc]initWithFrame: CGRectMake(0 + i * KScreenWidth,CGRectGetHeight(self.planView.frame), CGRectGetWidth(scrollView.frame), KScreenHeight-KHeight(180)-(KHeight(45)) ) style:UITableViewStyleGrouped];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.backgroundColor = kbackGroundGrayColor;
            self.view.backgroundColor =  kbackGroundGrayColor;
            [scrollView addSubview:self.tableView];
            self.tableView.estimatedRowHeight = 110;
            self.tableView.rowHeight = UITableViewAutomaticDimension;
            self.tableView.showsVerticalScrollIndicator=NO;
            self.tableView.showsHorizontalScrollIndicator=NO;
            self.tableView.separatorColor=[UIColor clearColor];
            [self.tableView registerNib:[UINib nibWithNibName:@"ExamineReportCell" bundle:nil] forCellReuseIdentifier:@"ExamineReportCell"];
            self.userMemberID  = [UserInfoTool getLoginInfo].MemberID;
          

            
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTopics)];
          
               [scrollView addSubview:self.nullImgeView];
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreTopics)];
              [self getHealthPlanListWithNetWorking:[UserInfoTool getLoginInfo].MemberID mothed:1];
        }else
        {
            //            Health_ViewController *subVC = [[Health_ViewController alloc]initWithType:pageTypeNoNavigation];
            //             subVC.isHealthPluse = NO;
            //
            //            [scrollView addSubview:subVC.view];
            //            [self addChildViewController:subVC];
            //
            //            subVC.view.frame = CGRectMake(0 + i * KScreenWidth,CGRectGetHeight(self.planView.frame), CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame)-(self.planView.frame.size.height)-(self.HeaderTopScrollView.frame.size.height));
            self.ePlusetableView= [[UITableView alloc]initWithFrame: CGRectMake(0 + i * KScreenWidth,CGRectGetHeight(self.planView.frame), CGRectGetWidth(scrollView.frame), KScreenHeight-KHeight(180)-(KHeight(45))) style:UITableViewStylePlain];
            self.ePlusetableView.delegate = self;
            self.ePlusetableView.dataSource = self;
            [scrollView addSubview:self.ePlusetableView];
            self.ePlusetableView.estimatedRowHeight = 110;
            self.ePlusetableView.backgroundColor = kbackGroundGrayColor;
            self.ePlusetableView.rowHeight = UITableViewAutomaticDimension;
            self.ePlusetableView.showsVerticalScrollIndicator=NO;
            self.ePlusetableView.showsHorizontalScrollIndicator=NO;
            self.ePlusetableView.separatorColor=[UIColor clearColor];
            [self.ePlusetableView registerNib:[UINib nibWithNibName:@"EPluseCell" bundle:nil] forCellReuseIdentifier:@"EPluseCell"];
          
        }
    }
    
    if (self.SelectTab) {
        [self.planView moveToIndex:self.SelectTab];
        [scrollView setContentOffset:CGPointMake(KScreenWidth*self.SelectTab, 0)];
    }
}
#pragma mark NetWorking

- (void)getHealthSportCategoryArray
{
    
    
    self.dataArray = @[@"检测报告",@"居家测量"];
    [self addSubViewController];
    [self hiddenPlaceHoldImage];
    
}
#pragma mark  家庭成员
- (void)getRecordFamilyPersonWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    [[XKLoadingView shareLoadingView]showLoadingText:nil];

    [HealthRecordViewModel getRecordFamilyPersonWithParmas:dic FinishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.HeaderTopScrollView.userMemberID = self.userMemberID;
            self.HeaderTopScrollView.familyArr = [FamilyObject mj_objectArrayWithKeyValuesArray:response.Result];
            NSLog(@"326%@",self.HeaderTopScrollView.familyArr);
            [self.tableView reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}
#pragma mark  居家监测
-(void)loadHomeTestData:(NSInteger)MemberID{
    
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"MemberID":@(MemberID)};
    [[XKLoadingView shareLoadingView]showLoadingText:nil];

    [NetWorkTool postAction:checkHomeTestGetReportUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        [[XKLoadingView shareLoadingView] hideLoding];

        if (response.code == CodeTypeSucceed) {
            NSLog(@"815---------%@",response.Result);
            self.PhysicalList = (NSMutableArray *)[PhysicalList mj_objectArrayWithKeyValuesArray:response.Result[@"PhysicalDetailList"]];
           
            
            self.homeArr =  [XKHouseHoldModel mj_objectArrayWithKeyValuesArray:response.Result[@"HomeInspectionList"]];
            
             [self.ePlusetableView reloadData];
        }else{
            
            ShowErrorStatus(response.msg);
        }
    }];

}
-(void)replaceRelationData:(NSInteger )dataInt;//切换数据
{
    self.userMemberID  = dataInt;
    self.pageIndex = 1;
    [self getHealthPlanListWithNetWorking:self.userMemberID mothed:self.pageIndex];
    [self loadHomeTestData:dataInt];
}
- (void)_loadNewTopics
{
    
    [self getHealthPlanListWithNetWorking:self.userMemberID mothed:1];
    
}

- (void)_loadMoreTopics
{
    
     [self getHealthPlanListWithNetWorking:self.userMemberID mothed:2];
    
}
//获取列表数据
- (void)getHealthPlanListWithNetWorking:(NSInteger)MemberID mothed:(NSInteger)mothed
{
    NSInteger pageSize=10;
    if (mothed==1) {//刷新
        
        pageSize= 10;//self.dataArray.count>8?self.dataArray.count:8;
        self.pageIndex = 1;
    }else{//加载更多
        
        pageSize=10;
        
        self.pageIndex++;
        
    }
    NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                           
                           @"MemberID":@(MemberID),
                           @"PageIndex":@(self.pageIndex),
                           @"PageSize":@(10)};
    
    NSLog(@"301-------%@",dict);
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"301" parameters:dict success:^(id json) {
        NSLog(@"检测报告301：%@",json);
        [[XKLoadingView shareLoadingView] hideLoding];
        if ([[NSString stringWithFormat:@"%@",json[@"Basis"][@"Status"]] isEqualToString:@"200"])
        {
            NSArray *array = json[@"Result"];
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[ExanubeReportModel  mj_objectArrayWithKeyValuesArray:array]];
            if (mothed==1) {
                
                self.ExanubeReportdataArray = (NSMutableArray *)tempArr;
                
            }else{
                    if (self.pageIndex == 1)
                    {
                        self.ExanubeReportdataArray = tempArr;
                    }else
                    {
                        [self.ExanubeReportdataArray addObjectsFromArray:tempArr];
                    }
            }
//            if (self.ExanubeReportdataArray.count == 0)
//            {
//                UIImageView *imgview = [self.tableView viewWithTag:10090];
//                if (imgview) {
//                    [imgview removeFromSuperview];
//                }
//                [self.tableView showPlaceHoldImageAtCenterOfView:healthPlanNoDataImage];
//            }else
//                [self.tableView hiddenPlaceHoldImage];
            
            if (self.ExanubeReportdataArray.count == 0) {
                self.nullImgeView.alpha = 1;
            }else{
                self.nullImgeView.alpha = 0;
            }

            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            if (self.ExanubeReportdataArray.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                if (self.pageIndex > 1) {
                    self.pageIndex --;
                }
                
            }
            //            if (self.ExanubeReportdataArray.count == 0)
            //            {
            //                [self.tableView showPlaceHoldImageAtCenterOfView:healthPlanNoDataImage];
            //            }else
            //                [self.tableView hiddenPlaceHoldImage];
            //            if (self.pageIndex == 1) {
            //                [self.ExanubeReportdataArray removeAllObjects];
            //
            //            }
            //            [self.ExanubeReportdataArray addObjectsFromArray:tempArr];
            //            [self.tableView reloadData];
        }else
        {
//            if (self.ExanubeReportdataArray.count == 0)
//            {
//                UIImageView *imgview = [self.tableView viewWithTag:10090];
//                if (imgview) {
//                    [imgview removeFromSuperview];
//                }
//                [self.tableView showPlaceHoldImageAtCenterOfView:healthPlanNoDataImage];
//            }
            if (self.ExanubeReportdataArray.count == 0) {
                self.nullImgeView.alpha = 1;
            }else{
                self.nullImgeView.alpha = 0;
            }
        }
    }
      failure:^(id error) {
          [[XKLoadingView shareLoadingView] errorloadingText:error];
    }];
}
#pragma mark ScrollView Delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (![scrollView isKindOfClass:[UITableView class]]) {
//        float offset = scrollView.contentOffset.x;
//        offset = offset/CGRectGetWidth(scrollView.frame);
//        [self.planView moveToIndex:offset];
//        NSInteger tempIndex = [self.planView changeProgressToInteger:offset];
//        if (tempIndex == 1) {
//              [self loadHomeTestData:self.userMemberID];
//        }else
//            self.pageIndex = 1;
//           [self getHealthPlanListWithNetWorking:self.userMemberID];
//    }
//
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView moveToIndex:offset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        [self.planView endMoveToIndex:offset];
    }
    if (![scrollView isKindOfClass:[UITableView class]]) {
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        NSInteger tempIndex = [self.planView changeProgressToInteger:offset];
        if (tempIndex == 1) {
            [self loadHomeTestData:self.userMemberID];
        }else
            self.pageIndex = 1;
        [self getHealthPlanListWithNetWorking:self.userMemberID mothed:self.pageIndex];
    }

}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.ePlusetableView) {
        return 6;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.ePlusetableView) {
        if (section == 0) {
            return 0;
        }
        return 0;
    }else
    {
        return self.ExanubeReportdataArray.count;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.ePlusetableView) {
        if (indexPath.section == 0) {
            return 117+5;
        }
        else
            return 0.01;
    }else
    {
        return 88+20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.ePlusetableView) {
        
        NSString *cellid = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    }else
    {
        NSString *cellid = @"ExamineReportCell";
        ExamineReportCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.examModel =  self.ExanubeReportdataArray[indexPath.row];
        return cell;
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.ePlusetableView) {
        XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
        if (section == 1){
            EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
            headV.titleLab.text=@"血压(mmHg)";
            headV.delegate = self;
            for (XKHouseHoldModel *hmode in  self.homeArr) {
                if ([headV.titleLab.text containsString:hmode.Name]) {
                    mode = hmode;
                    break;
                }
            }
            headV.moreLab.text = (mode.IsBind==1?@"去测量":@"去测量");
            if (self.userMemberID  == [UserInfoTool getLoginInfo].MemberID) {
                headV.isUserMemberIdPauseHiden = NO;
            }else
                headV.isUserMemberIdPauseHiden = YES;

            return headV;
        }else if (section == 2){
            EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
            headV.titleLab.text=@"体温(℃)";
            headV.delegate = self;
            headV.arrowImg.hidden = NO;
            for (XKHouseHoldModel *hmode in  self.homeArr) {
                if ([headV.titleLab.text containsString:hmode.Name]) {
                    mode = hmode;
                    break;
                }
            }
            headV.moreLab.text = (mode.IsBind==1?@"去测量":@"去测量");
            if (self.userMemberID  == [UserInfoTool getLoginInfo].MemberID) {
                headV.isUserMemberIdPauseHiden = NO;
            }else
                headV.isUserMemberIdPauseHiden = YES;
            return headV;
        }
        else if (section == 3){
            EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
            headV.titleLab.text=@"体重(kg)";
            headV.delegate = self;
            for (XKHouseHoldModel *hmode in  self.homeArr) {
                if ([headV.titleLab.text containsString:hmode.Name]) {
                    mode = hmode;
                    break;
                }
            }
            headV.moreLab.text = (mode.IsBind==1?@"去测量":@"去测量");
            if (self.userMemberID  == [UserInfoTool getLoginInfo].MemberID) {
                headV.isUserMemberIdPauseHiden = NO;
            }else
                headV.isUserMemberIdPauseHiden = YES;
            return headV;
        }
        else if (section == 4){
            EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
            headV.titleLab.text=@"血糖(mmol/L)";
            headV.delegate = self;
            for (XKHouseHoldModel *hmode in  self.homeArr) {
                if ([headV.titleLab.text containsString:hmode.Name]) {
                    mode = hmode;
                    break;
                }
            }
            headV.moreLab.text = (mode.IsBind==1?@"去测量":@"去测量");
            if (self.userMemberID  == [UserInfoTool getLoginInfo].MemberID) {
                headV.isUserMemberIdPauseHiden = NO;
            }else
                headV.isUserMemberIdPauseHiden = YES;
            return headV;
        }
        else if (section == 5) {
            EPluseHeaderView *headV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseHeaderView" owner:self options:nil]  firstObject];
            headV.titleLab.text=@"血脂(mmol/L)";
            headV.delegate = self;
            for (XKHouseHoldModel *hmode in  self.homeArr) {
                if ([headV.titleLab.text containsString:hmode.Name]) {
                    mode = hmode;
                    break;
                }
            }
            headV.moreLab.text = (mode.IsBind==1?@"去测量":@"去测量");
            if (self.userMemberID  == [UserInfoTool getLoginInfo].MemberID) {
                headV.isUserMemberIdPauseHiden = NO;
            }else
                headV.isUserMemberIdPauseHiden = YES;
            return headV;
        }
        else {
            UIView *headV=[[UIView alloc]init];
            return headV;
        }
    }else
    {
        
        UIView *headV=[[UIView alloc]init];
        return headV;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.ePlusetableView) {
        
    }else
    {
        ExamDetailReportViewController *Examine = [[ExamDetailReportViewController alloc]initWithType:pageTypeNormal];
        
        ExanubeReportModel *model =  self.ExanubeReportdataArray[indexPath.row];
       
        Examine.PhysicalExaminationModel = model;
        FamilyObject *objFamily = [[FamilyObject alloc]init];
        for (FamilyObject *objF in  self.HeaderTopScrollView.familyArr) {
            if ( objF.FamilyMemberID == self.userMemberID) {
                objFamily = objF;
                
                break;
            }
        }
        Examine.personal = objFamily;
        [self.navigationController pushViewController:Examine animated:YES];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.ePlusetableView) {
        if (section == 0) {
            return 0.01;
        }else  if (section <=5) {
            return 45+5;
        }
        else
        {
            
            return 0.01;
        }
    }else
    {
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.ePlusetableView) {
        if (section == 0){
            return 0.01;//UITableViewAutomaticDimension;
        }
        else if (section == 1||section == 4)
        {
            
            return 292;
        }
        else if (section == 5)
        {
            
            return 370;
        }
        else
        {
            return 282;
            
        }
    }else
    {
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == self.ePlusetableView) {
        if (section == 1){
            EPluseSugarView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseSugarView" owner:self options:nil]  firstObject];
            footerV.isSugar = NO;
            footerV.PhysicalMod = self.PhysicalList;
            return footerV;
        }
        else if (section == 3){
            EPluseWeightQView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseWeightQView" owner:self options:nil]  firstObject];
            footerV.PhysicalMod = self.PhysicalList;
            return footerV;
        }
        else if (section == 2){
            EPluseTemperView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseTemperView" owner:self options:nil]  firstObject];
              footerV.PhysicalMod = self.PhysicalList;
            return footerV;
        }
        else if (section == 4){
            EPluseSugarView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseSugarView" owner:self options:nil]  firstObject];
            footerV.isSugar = YES;
            footerV.PhysicalMod = self.PhysicalList;
            return footerV;
        }
        else if (section == 5){
            EPluseFooterView *footerV=[[[NSBundle mainBundle]loadNibNamed:@"EPluseFooterView" owner:self options:nil]  firstObject];
             footerV.PhysicalModeld = self.PhysicalList;
            return footerV;
        }
        else {
            UIView *headV=[[UIView alloc]init];
            return headV;
        }
    }else
    {
        UIView *headV=[[UIView alloc]init];
        return headV;
    }
    
    
}
- (void)buttonClickEPluseHeaderViewAtIndex:(NSString *)url title:(NSString *)title index:(NSInteger)tag;
{
    if (self.userMemberID != [UserInfoTool getLoginInfo].MemberID) {
        return;
        
    }
    if (self.homeArr.count<=0) {//防止用户还没得到数据就直接进入下一个页面了
        return;
    }
    XKHouseHoldModel *mode = [[XKHouseHoldModel alloc]init];
    for (XKHouseHoldModel *hmode in  self.homeArr) {
        if ([title containsString:@"血压"]&&[hmode.Name isEqualToString:@"血压"]) {
            mode = hmode;
            mode.DeviceClass = 6;
            break;
        }
        else if ([title containsString:@"体温"]&&[hmode.Name isEqualToString:@"体温"]) {
            mode = hmode;
            mode.DeviceClass = 12;
            break;
        }
        else  if ([title containsString:@"体重"]&&[hmode.Name isEqualToString:@"体重"]) {
            mode = hmode;
            mode.DeviceClass = 7;
            break;
        }
        else if ([title containsString:@"血糖"]&&[hmode.Name isEqualToString:@"血糖"]) {
            mode = hmode;
            mode.DeviceClass = 8;
            break;
        }
        else if ([title containsString:@"血脂"]&&[hmode.Name isEqualToString:@"血脂"]) {
            mode = hmode;
            mode.DeviceClass = 9;
            break;
        }
    }
    XKDectingViewController *connection=[[XKDectingViewController alloc]initWithType:pageTypeNormal];
    connection.style = mode.DeviceClass;
    connection.model = mode;
    connection.isReload = ^(BOOL Reload) {
        NSLog(@"----刷新%i",Reload);
        if (Reload == YES) {
            [self.ePlusetableView reloadData];

        }
    };
    
    [[NSUserDefaults standardUserDefaults]setObject:@"freshHealthDataU" forKey:@"freshHealthDataU"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    connection.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:connection animated:YES];
}

#pragma mark   EPluseDelegate
- (void)sportEPluseCellbuttonClick:(NSString *)titleStr headline:(NSString *)headline;{
    if ([titleStr isEqualToString:@"去运动"]) {
        SportViewController *sport = [[SportViewController alloc]initWithType:pageTypeNormal];
        [self.navigationController pushViewController:sport animated:YES];
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
