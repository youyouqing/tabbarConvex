//
//  TestReportViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TestReportViewController.h"

#import "TestReportTableViewCell.h"

#import "TestReportViewModel.h"

#import <MJRefresh/MJRefresh.h>

static NSString *testReportListCell = @"testReportListCell";

@interface TestReportViewController () <UITableViewDelegate,UITableViewDataSource>

///页码
@property (nonatomic, assign) int pageNum;

///一页多少个数据
@property (nonatomic, assign) int dataCount;

///数据源
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TestReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

#pragma mark UI
- (void)createUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.left.mas_equalTo(KWidth(12));
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo( - KWidth(12));
    }];
}

#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testReportListCell];
    
    if (!cell) {
        cell = [[TestReportTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:testReportListCell];
    }
    
    return cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KHeight(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark NetWorking
- (void)getTestReportListData
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@"",
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"PageIndex":@(self.pageNum),
                          @"PageSize":@(self.dataCount)};
    
    [TestReportViewModel getTestReportListWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
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