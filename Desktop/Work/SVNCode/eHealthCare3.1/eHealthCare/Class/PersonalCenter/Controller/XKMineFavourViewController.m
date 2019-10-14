//
//  XKMineFavourViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMineFavourViewController.h"
#import "XKInforamationCell.h"
#import "XKInformationDetail.h"
#import "XKInfomationChildController.h"
#import "XKInfomationViewController.h"
#import "XKMineWiKiModel.h"
@interface XKMineFavourViewController ()
@property (nonatomic , strong) NSMutableArray * infoArr;

@property (nonatomic,assign)NSInteger pageIndex;

@property (nonatomic, strong) UIImageView *nullImgeView;

@property (strong, nonatomic)  UITableView *tableView;


@end

@implementation XKMineFavourViewController





-(NSMutableArray *)infoArr
{
    
    if (!_infoArr) {
        _infoArr = [[NSMutableArray alloc]init];
    }
    return _infoArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex=1;
    
    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0,PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kbackGroundGrayColor;
    self.view.backgroundColor =  kbackGroundGrayColor;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.estimatedRowHeight =0.0;
    //        打开自动计算行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKInforamationCell" bundle:nil] forCellReuseIdentifier:@"XKInforamationCell"];
    
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshLoad)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreLoad)];
    [self loadData:1 withIsFresh:YES];
    
  
    
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
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"922" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"%@",json);
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 99;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *cellid = @"XKInforamationCell";
    XKInforamationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    XKWiKIInfoModel *model = self.infoArr[indexPath.row];
    cell.favourModel = model;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (self.infoArr.count == 0) {
        return KScreenHeight;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{

    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (self.infoArr.count == 0) {
        
        UIView *ivew = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [ivew addSubview:self.nullImgeView];
        
        
        
        UIButton *go = [UIButton buttonWithType:UIButtonTypeCustom];
        //        CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)
        go.frame = CGRectMake((KScreenWidth-110)/2.0, self.nullImgeView.frame.origin.y+self.nullImgeView.frame.size.height, 110, 30);
        
        [go setTitle:@"去看资讯" forState:UIControlStateNormal];
        
        [go setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [go setBackgroundColor:kMainColor];
        
        go.titleLabel.font = [UIFont systemFontOfSize:14.f];
        
        [go addTarget:self action:@selector(clickGOInfomartion) forControlEvents:UIControlEventTouchUpInside];
        
        go.layer.cornerRadius = go.frame.size.height/2.0;
        
        go.clipsToBounds = YES;
        
        [ivew addSubview:go];
        
        return ivew;
    }
    
    
    return [[UIView alloc]init];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    XKInformationDetail *con = [[XKInformationDetail alloc]initWithType:pageTypeNormal];
    
    XKWiKIInfoModel *model = self.infoArr[indexPath.row];
    //    少了咨询的链接
    
    
    con.mod = model;
    
    [self.navigationController pushViewController:con animated:YES];
    
}
-(void)clickGOInfomartion
{
    
    
    XKInfomationViewController *plan=[[XKInfomationViewController alloc]initWithType:pageTypeNormal];
//    plan.isOther = YES;
    [self.navigationController pushViewController:plan animated:YES];
    
}@end