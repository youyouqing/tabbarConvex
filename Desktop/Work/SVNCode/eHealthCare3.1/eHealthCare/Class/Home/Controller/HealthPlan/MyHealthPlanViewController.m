//
//  MyHealthPlanViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/21.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MyHealthPlanViewController.h"
#import "HealthPlanDeatilViewController.h"
#import "TodayHealthPlanViewController.h"
#import "PlanCompleteViewController.h"

#import "HealthPlanViewModel.h"

#import "HealthPlanCell.h"

static NSInteger CellJoinButtonTag = 100;

@interface MyHealthPlanViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyHealthPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageIndex = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pageIndex = 1;
    [self getMyHelathPlanData];
}

- (void)createUI
{
    self.view.backgroundColor = kLightGrayColor;

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(KWidth(16));
        make.right.mas_equalTo( - KWidth(16));
    }];
    
    //添加上拉和下拉
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.pageIndex = 1;
        [self getMyHelathPlanData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        self.pageIndex = self.pageIndex + 1;
        [self getMyHelathPlanData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark Action

//cell 上的按钮点击时间
- (void)cellButtonAction:(UIButton *)button
{
    NSDictionary *dic = self.dataArray[button.tag - CellJoinButtonTag];
    
    if ([dic[@"PlanStatus"] integerValue] == 0)
    {
        //加入健康计划
        NSDictionary *paramsDic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                                    @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                                    @"PlanMainID":dic[@"PlanMainID"]};
        
        [HealthPlanViewModel joinHealthPlanWithParams:paramsDic FinishedBlock:^(ResponseObject *response) {
            
            if (response.code == CodeTypeSucceed)
            {
                //改变数据源数据
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [mDic setObject:@(1) forKey:@"PlanStatus"];
                [self.dataArray replaceObjectAtIndex:(button.tag - CellJoinButtonTag) withObject:mDic];
                [self.tableView reloadData];
            }else
            {
                ShowErrorStatus(response.msg);
            }
        }];
        
    }else
    {
        if ([dic[@"PlanStatus"] integerValue] == 1)
        {
            //查看当日计划
            TodayHealthPlanViewController *today = [[TodayHealthPlanViewController alloc]initWithType:pageTypeNormal];
            
            today.dataDic = dic;
            today.myTitle = dic[@"PlanTitle"];
            
            [self.navigationController pushViewController:today animated:YES];
            
        }else if ([dic[@"PlanStatus"] integerValue] == 2 || [dic[@"PlanStatus"] integerValue] == 3 || [dic[@"PlanStatus"] integerValue] == 4)
        {
            //今日计划完成界面
            PlanCompleteViewController *plan = [[PlanCompleteViewController alloc]initWithType:pageTypeNormal];
            
            plan.MemResultID = dic[@"ResultID"];
            plan.myTitle = @"计划完成";
            
            [self.navigationController pushViewController:plan animated:YES];
        }
        
    }
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"HealthPlanCell";
    HealthPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[HealthPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.isMyPlan = YES;
    cell.dataDic = self.dataArray[indexPath.section];
    [cell.joinButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.joinButton.tag = CellJoinButtonTag + indexPath.section;
    
    return cell;
}

#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HealthPlanDeatilViewController *detail = [[HealthPlanDeatilViewController alloc]initWithType:pageTypeNormal];
    
    detail.dataDic = self.dataArray[indexPath.section];
    detail.myTitle = @"健康计划";
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KHeight(100);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return KHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark NetWorking

- (void)getMyHelathPlanData
{
    NSInteger pageSize = 10;
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"PageIndex":@(self.pageIndex),
                          @"PageSize":@(pageSize)};
    
    [HealthPlanViewModel getMyHealthPlanListWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            NSArray *array = response.Result;
            if (array.count > 0)
            {
                if (self.pageIndex == 1)
                {
                    self.dataArray = [NSMutableArray arrayWithArray:array];
                }else
                {
                    [self.dataArray addObjectsFromArray:array];
                }
                [self.tableView reloadData];
                [self.tableView hiddenPlaceHoldImage];
            }else
            {
                if (self.dataArray.count == 0)
                {
                    [self.tableView showPlaceHoldImageAtCenterOfView:healthPlanNoDataImage];
                }
            }
        }else
        {
            if (self.dataArray.count == 0)
            {
                [self.tableView showPlaceHoldImageAtCenterOfView:healthPlanNoDataImage];
            }
        }
    }];
}

#pragma mark Lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kLightGrayColor;
        _tableView.delaysContentTouches = NO;
    }
    return _tableView;
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
