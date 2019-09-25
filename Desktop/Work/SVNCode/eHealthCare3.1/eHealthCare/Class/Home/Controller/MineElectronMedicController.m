//
//  MineElectronMedicController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//我的电子病历

#import "MineElectronMedicController.h"
#import "MineElectronicMedicCell.h"
#import "XKMedicalRecordDetailController.h"
#import "XKAddMedicalRecordController.h"
@interface MineElectronMedicController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
/**
 便是当前页数
 */
@property (nonatomic,assign) NSInteger pageIndex;

/**
 数据源数组
 */
@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 电子病历类型
 */
@property (nonatomic,strong) NSArray *typeArray;
@end

@implementation MineElectronMedicController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadType];
    [self loadData:1 withIsFresh:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"我的电子病历";
    self.titleLab.textColor = kMainTitleColor;
     self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_medicalcase_add"] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view.backgroundColor = kbackGroundGrayColor;
    tableView.backgroundColor = kbackGroundGrayColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"MineElectronicMedicCell" bundle:nil] forCellReuseIdentifier:@"MineElectronicMedicCell"];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);//CGRectMake(10, 10+PublicY, KScreenWidth-20, KScreenHeight-PublicY-20)
        make.left.mas_equalTo(0 );
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo( KScreenWidth);
    }];
    self.tableView = tableView;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTopics)];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreTopics)];
   
}
-(void)clickEdit
{
    
    XKAddMedicalRecordController *addRecord = [[XKAddMedicalRecordController alloc]initWithType:pageTypeNormal];
    addRecord.myTitle = @"添加病历";
    addRecord.typeArray = self.typeArray;
    addRecord.MemberID = [UserInfoTool getLoginInfo].MemberID;
    [self.navigationController pushViewController:addRecord animated:YES];
    
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
    
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellid = @"MineElectronicMedicCell";
    MineElectronicMedicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
      cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XKMedicalRecordDetailController *detail = [[XKMedicalRecordDetailController alloc]initWithType:pageTypeNormal];
     detail.myTitle = @"查看病历";
    detail.MemberID = [UserInfoTool getLoginInfo].MemberID;
    detail.typeArray = self.typeArray;
    detail.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 事件处理
- (void)_loadNewTopics
{
    
    [self loadData:1 withIsFresh:NO];
    
}

- (void)_loadMoreTopics
{
    
    [self loadData:2 withIsFresh:NO];
    
}
#pragma mark   请求数据变更
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=8;
    
    if (mothed==1) {//刷新
        
        pageSize=8;//self.dataArray.count>8?self.dataArray.count:8;
        self.pageIndex = 1;
        
    }else{//加载更多
        
        pageSize=8;
        
        self.pageIndex++;
        
    }
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
     NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)};
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"928" parameters:dic success:^(id json) {
        NSLog(@"----928获取用户病历列表-----%@",dic);
       
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            NSArray *arr =  [XKPatientModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.dataArray = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.dataArray = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.dataArray addObjectsFromArray:arr];
                }
                
            }
            if (self.dataArray.count > 0)
            {
               
                [self.tableView hiddenPlaceHoldImage];
                
            }else
            {
                UIImageView *imgview = [self.tableView viewWithTag:10090];
                if (imgview) {
                    [imgview removeFromSuperview];
                }
                [self.tableView showPlaceHoldImageAtCenterOfView:healthPlanNoDataImage];
              
            }
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            
            if (self.dataArray.count >= [[json objectForKey:@"Rows"] integerValue]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        [self.tableView.mj_header endRefreshing];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}
/**
 加载电子病历类型方法
 */
-(void)loadType{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"927" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token} success:^(id json) {
         [[XKLoadingView shareLoadingView] hideLoding];
        NSLog(@"927-------------%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            self.typeArray = [XKPatientTypeModel objectArrayWithKeyValuesArray:json[@"Result"]];
           
           
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:@"亲，网速不给力哇~"];
        
    }];
    
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
