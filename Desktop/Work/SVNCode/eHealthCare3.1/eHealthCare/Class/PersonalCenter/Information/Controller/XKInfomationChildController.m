//
//  XKInfomationChildController.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInfomationChildController.h"
#import "XKInforamationCell.h"
#import "XKInformationDetail.h"
#import "XKWiKIInfoModel.h"
@interface XKInfomationChildController ()
@property (strong, nonatomic)  UITableView *tableView;

/**
 数据源
 */
@property (nonatomic , strong) NSMutableArray * infoArr;

/**
 数据源空白页面
 */
@property (nonatomic, strong) UIImageView *nullImgeView;

/**
 页面索引
 */
@property (nonatomic,assign)NSInteger pageIndex;
@end

@implementation XKInfomationChildController
-(NSMutableArray *)infoArr
{

    if (!_infoArr) {
        _infoArr = [[NSMutableArray alloc]init];
    }
    return _infoArr;

}
-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.75, KScreenWidth /2.75)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
        _nullImgeView.image = [UIImage imageNamed:@"none_dataImage"];
        
        
    }
    return _nullImgeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageIndex=1;
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
   [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"XKInforamationCell" bundle:nil] forCellReuseIdentifier:@"XKInforamationCell"];
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    [self loadData:1 withIsFresh:YES];
    
}

-(void)freshLoad{
    
    [self loadData:1 withIsFresh:NO];
    
}

-(void)moreLoad{
    
    [self loadData:2 withIsFresh:NO];
    
}

-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf
{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=10;
    
    if (mothed==1) {//刷新
        
        pageSize=10;//self.infoArr.count>0?self.infoArr.count:8;
        self.pageIndex = 1;
        
    }else{//加载更多
        
        pageSize=10;
        
        self.pageIndex++;
        
    }
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"909" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TopicTypeID":@(_model.TypeID),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"909:%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
          
             NSArray *arr =  [XKWiKIInfoModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            if (mothed==1) {
                
                self.infoArr = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                  self.infoArr = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.infoArr addObjectsFromArray:arr];
                }
                
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
            
            
            if (self.infoArr.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
               
                
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.infoArr.count == 0) {
        return KScreenHeight;
    }
    return 0.05;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.infoArr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (self.infoArr.count == 0) {
        
        UIView *ivew = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [ivew addSubview:self.nullImgeView];
        
        return ivew;
    }
    
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 99;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"XKInforamationCell";
    XKInforamationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[XKInforamationCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.model = self.infoArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    XKInformationDetail *con = [[XKInformationDetail alloc]initWithType:pageTypeNormal];
    
//    con.planModelTypeMod = _model;
    
     con.myTitle = @"资讯详情";
     con.mod = self.infoArr[indexPath.row];
    con.didRefreshPageBlock = ^(BOOL isSuccess) {
        if (isSuccess == YES) {
            self.nullImgeView.alpha = 0;
            [self loadData:1 withIsFresh:YES];
        }
    };
    [self.navigationController pushViewController:con animated:YES];
    
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
