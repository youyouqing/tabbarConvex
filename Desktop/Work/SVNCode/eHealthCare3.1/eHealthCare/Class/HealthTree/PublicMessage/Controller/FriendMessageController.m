//
//  FriendMessageController.m
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "FriendMessageController.h"
#import "FriendTableViewCell.h"
#import "FamilyMemberObject.h"
#import "FamilyViewModel.h"
@interface FriendMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *familyDataArr;
@end

@implementation FriendMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"好友消息提醒";
    [self.view addSubview:self.tableView];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    self.titleLab.textColor = kMainTitleColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
    
    [self getHealthTreeFamilyMessageListData];
}
- (void)getHealthTreeFamilyMessageListData
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          };
    
    [FamilyViewModel gethometree_getFamilyResultUrlWithParams:dic FinishedBlock:^(ResponseObject *response) {
        NSLog(@"126:%@",response.Result);
        if (response.code == CodeTypeSucceed) {
       
            
            self.familyDataArr = [FamilyMemberObject mj_objectArrayWithKeyValuesArray:response.Result];
            
            
            [self.tableView reloadData];
            
        }
    }];
}
-(UITableView *)tableView
{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kbackGroundGrayColor;
        _tableView.estimatedRowHeight = 110;
        _tableView.rowHeight = UITableViewAutomaticDimension;
       _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.separatorColor=[UIColor clearColor];
    }
    return _tableView;
    
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.familyDataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

     return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        NSString *cellid = @"FriendTableViewCell";
        FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Fobject = self.familyDataArr[indexPath.section];
        return cell;
        
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 182;
    
}
- (void)agreeAddFamilybuttonClick:(FamilyMemberObject *)Fobject pass:(NSInteger)pass;
{
    
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"FamilyAddID":@(Fobject.FamilyAddID),
                          @"ReplyStatus":@(pass),
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          };
      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [FamilyViewModel gethometree_getFamilyAddMessageResultUrlWithParams:dic FinishedBlock:^(ResponseObject *response) {
        NSLog(@"125:%@",response.Result);
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
           
            [self getHealthTreeFamilyMessageListData];
            
            [self.tableView reloadData];
            
        }
    }];
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    return [[UIView alloc]init];
//
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return [[UIView alloc]init];
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 6.f;
//
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6.f;
    
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
