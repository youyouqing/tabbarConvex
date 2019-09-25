//
//  TodayHealthPlanViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/21.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TodayHealthPlanViewController.h"

#import "TodayPlanDetailHeadView.h"
#import "TodayPlanDetailView.h"
#import "PlanDirectoryView.h"

#import "HealthPlanViewModel.h"

@interface TodayHealthPlanViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSDictionary *todayDataDic;//当日计划的数据 从 getTodayPlanDataWithNetWorking 方法拉取

@property (nonatomic, strong) PlanDirectoryView *planDirectoryView;//计划目录
@property (nonatomic, strong) TodayPlanDetailHeadView *planHeaderView;//绿色头视图
@property (nonatomic, strong) TodayPlanDetailView *detailView;//每日计划详情

@property (nonatomic, strong) UIButton *joinButton;//悬浮视图上的按钮

/**进行中和已完成状态的UI*/
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *suspensionView;//最下面的悬浮视图

@end

@implementation TodayHealthPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getTodayPlanDataWithNetWorking];
    [self createUI];
}

- (void)createUI
{
    [self ongoingOrFinishedUI];
}

//进行中和完成类型的界面UI
- (void)ongoingOrFinishedUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo( - KHeight(60));
    }];

    //绿色头视图
    [scrollView addSubview:self.planHeaderView];
    [self.planHeaderView setBackgroundColor:kMainColor];
    [self.planHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth, KHeight(90)));
    }];
    
    //目录计划按钮的点击事件
    WEAKSELF
    self.planHeaderView.popBlock = ^{
        
        [weakSelf popThePlanDirectoryList];
    };
    
    //每日计划详情
    [scrollView addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.planHeaderView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //从detailView那边获取到自适应高度
    self.detailView.heightBlock = ^(CGFloat detailViewHeight) {
        
        scrollView.contentSize = CGSizeMake(KScreenWidth, detailViewHeight + KHeight(90));
    };
    
    //下面的悬浮视图
    UIView *suspensionView = [[UIView alloc]init];
    
    [self.view addSubview:suspensionView];
    self.suspensionView = suspensionView;
    [suspensionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(KHeight(60));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    
    lineView.backgroundColor = kSeperateLineColor;
    
    [suspensionView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    //完成按钮
    UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [joinButton addTarget:self action:@selector(joinButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [suspensionView addSubview:joinButton];
    self.joinButton = joinButton;
    
    [joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(suspensionView.mas_centerX);
        make.centerY.mas_equalTo(suspensionView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(160), KHeight(30)));
    }];
    
    //添加手势点击事件 让计划目录可以隐藏
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissPlanDirectoryView)];
    
    gesture.delegate = self;
    
    [scrollView addGestureRecognizer:gesture];
}

//对悬浮视图的按钮进行操作
- (void)reloadData
{
    if (self.planType == todayPlanTypeOngoing)
    {
        [self.joinButton setImage:[UIImage imageNamed:@"todayPlanDone"] forState:UIControlStateNormal];
        [self.joinButton setTitle:@"点击完成" forState:UIControlStateNormal];
        [self.joinButton setTitleColor:kMainColor forState:UIControlStateNormal];
        self.joinButton.titleLabel.font = Kfont(16);
        [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.suspensionView.mas_centerX);
            make.centerY.mas_equalTo(self.suspensionView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(KWidth(160), KHeight(30)));
        }];
        
    }else if (self.planType == todayPlanTypeUnFinished)
    {
        [self.joinButton setImage:[UIImage imageNamed:@"unFinishedDarkImage"] forState:UIControlStateNormal];
        [self.joinButton setTitle:@"未完成" forState:UIControlStateNormal];
        [self.joinButton setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
        self.joinButton.titleLabel.font = Kfont(16);
        [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.suspensionView.mas_centerX);
            make.centerY.mas_equalTo(self.suspensionView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(KWidth(160), KHeight(30)));
        }];
    }
    else if (self.planType == todayPlanTypeFinished)
    {
        [self.joinButton setImage:[UIImage imageNamed:@"todayPlanFinished"] forState:UIControlStateNormal];
        [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self.suspensionView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KWidth(80), KWidth(57)));
        }];
    }else
    {
        [self.joinButton setImage:[UIImage imageNamed:@"AlertSignal"] forState:UIControlStateNormal];
        [self.joinButton setTitle:@"尚未开始" forState:UIControlStateNormal];
        [self.joinButton setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
        self.joinButton.titleLabel.font = Kfont(16);
        [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.suspensionView.mas_centerX);
            make.centerY.mas_equalTo(self.suspensionView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(KWidth(160), KHeight(30)));
        }];
    }
}
#pragma mark Action
- (void)joinButtonAction
{
    if (self.planType == todayPlanTypeOngoing)
    {
        [self dismissPlanDirectoryView];
        [self finishTodayPlanWithNetWorking];
    }
}

- (void)loadData
{
    //计划目录数据源赋值
    self.planDirectoryView.dataArray = self.todayDataDic[@"PlanDetailCatalogueList"];
    
    //头部视图
    self.planHeaderView.indexOfPlanDay = self.todayDataDic[@"CurrentTitle"];
    
    //当日计划详情
    self.detailView.dataArray = self.todayDataDic[@"PlanDetailList"];
    
    [self reloadData];
}

//弹出计划目录
- (void)popThePlanDirectoryList
{
    if (self.planDirectoryView.hidden)
    {
        self.planDirectoryView.hidden = NO;
    }else
    {
        [self.view addSubview:self.planDirectoryView];
        WEAKSELF
        self.planDirectoryView.choseBlock = ^(NSString *planDetailID){
            
            [weakSelf getTheDayOfPlanDetailWithNetWorking:planDetailID];
        };
        
        [self.planDirectoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.planHeaderView.mas_bottom);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(KWidth(115), KScreenHeight - KHeight(90) - KHeight(60) - (PublicY)));
        }];
    }
}

//判断计划状态
- (void)judgeThePlanState:(NSDictionary *)dic
{
    
    if ([dic[@"CurrentDay"] intValue] == 1)
    {
        if ([dic[@"PlanDetailStatus"] integerValue] == 1)
        {
            self.planType = todayPlanTypeFinished;

        }else
        {
            self.planType = todayPlanTypeOngoing;
        }
    }else
    {
        if ([dic[@"PlanDetailStatus"] integerValue] == 1)
        {
            self.planType = todayPlanTypeFinished;
        }else if ([dic[@"PlanDetailStatus"] integerValue] == 2)
        {
            self.planType = todayPlanTypeUnFinished;
        }else
        {
            self.planType = todayPlanTypeInFuture;
        }
    }
}

- (void)dismissPlanDirectoryView
{
    if (_planHeaderView)
    {
        self.planDirectoryView.hidden = YES;
    }
}

#pragma mark NetWorking

//拉取当日计划数据
- (void)getTodayPlanDataWithNetWorking
{
    ShowNormailMessage(@"加载中...");
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"PlanMainID":self.dataDic[@"PlanMainID"]};
    
    [HealthPlanViewModel getTodayHealthPlanWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        DismissHud();
        if (response.code == CodeTypeSucceed)
        {
            NSDictionary *result = [NSDictionary dictionaryWithDictionary:response.Result];
            if (result.count > 0)
            {
                self.todayDataDic = [NSDictionary dictionaryWithDictionary:result];
                [self hiddenPlaceHoldImage];
                
                NSArray *currentArray = self.todayDataDic[@"PlanDetailCatalogueList"];
                NSDictionary *currentDic = [currentArray objectAtIndex:[self.todayDataDic[@"Sort"] intValue] - 1];
                [self judgeThePlanState:currentDic];
                [self loadData];
            }else
            {
                [self showPlaceHoldImageAtCenterOfViewController:healthPlanNoDataImage];
            }
        }else
        {
            [self showPlaceHoldImageAtCenterOfViewController:healthPlanNoDataImage];
        }
    }];
}

//完成当日计划
- (void)finishTodayPlanWithNetWorking
{
    ShowNormailMessage(@"完成中...");
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"PlanMainID":self.dataDic[@"PlanMainID"],
                          @"PlanDetailID":self.todayDataDic[@"PlanDetailID"]};
    
    [HealthPlanViewModel finishTodayPlanWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        DismissHud();
        if (response.code == CodeTypeSucceed)
        {
            self.planType = todayPlanTypeFinished;
            [self getTodayPlanDataWithNetWorking];
            [self loadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

//获取对应日期的计划详情
- (void)getTheDayOfPlanDetailWithNetWorking:(NSString *)planDetailID
{
    ShowNormailMessage(@"请稍等...");
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"PlanDetailID":planDetailID};
    
    [HealthPlanViewModel getTodayPlanDetailWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        DismissHud();
        if (response.code == CodeTypeSucceed)
        {
            NSArray *array = response.Result;
            if (array.count > 0)
            {
                
                //对当前页面的数据和UI进行操作
                self.detailView.dataArray = array;
                
                NSDictionary *detailDic = [array firstObject];
                
                NSArray *currentArray = self.todayDataDic[@"PlanDetailCatalogueList"];
                NSDictionary *currentDic = [currentArray objectAtIndex:[detailDic[@"Sort"] intValue] - 1];
                
                //给标题先传值
                self.planHeaderView.indexOfPlanDay = detailDic[@"PlanDetailTitle"];
                
                //判断计划状态
                [self judgeThePlanState:currentDic];
                
                [self reloadData];

            }else
            {
                ShowErrorStatus(@"服务器睡着了...");
            }
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

#pragma mark Lazy load

//绿色头视图
- (TodayPlanDetailHeadView *)planHeaderView
{
    if (!_planHeaderView) {
        _planHeaderView = [[TodayPlanDetailHeadView alloc]init];
    }
    return _planHeaderView;
}

//计划目录
- (PlanDirectoryView *)planDirectoryView
{
    if (!_planDirectoryView) {
        _planDirectoryView = [[PlanDirectoryView alloc]initWithFrame:CGRectZero];
    }
    
    return _planDirectoryView;
}

//当日计划详情
- (TodayPlanDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[TodayPlanDetailView alloc]init];
    }
    return _detailView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.planDirectoryView setHidden:YES];
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
