//
//  ArchiveSettingViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "ArchiveSettingViewController.h"
#import "AddFamilyViewModel.h"
#import "ArchiveSettingCell.h"
@interface ArchiveSettingViewController ()
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation ArchiveSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"健康档案设置";
    self.titleLab.textColor = kMainTitleColor;
     self.headerView.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view.backgroundColor = kbackGroundGrayColor;
    tableView.backgroundColor = kbackGroundGrayColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"ArchiveSettingCell" bundle:nil] forCellReuseIdentifier:@"ArchiveSettingCell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.left.mas_equalTo(0 );
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo( CGRectGetWidth(self.view.frame));
    }];
    self.tableView = tableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.familyArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellid = @"ArchiveSettingCell";
    ArchiveSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.famMod = self.familyArr[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50+10;
    
}
#pragma mark   删除操作
- (void)deleteFamilybuttonClick:(FamilyObject *)famMod;
{
    
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"MemberFamilyID":@(famMod.FamilyMemberID)
                              };
    [[XKLoadingView shareLoadingView]showLoadingText:nil];

    
    [NetWorkTool postAction:deleteUserFamilydDataResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        [[XKLoadingView shareLoadingView]hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            [self.familyArr removeObject:famMod];
            [self.tableView reloadData];
            NSLog(@"335%@",response.Result);
            
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