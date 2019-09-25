//
//  NewPublicViewController.m
//  eHealthCare
//
//  Created by xiekang on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewPublicViewController.h"
#import "PublicNoticeModel.h"
#import "NewPublicCell.h"
#import "NewPublicFrame.h"
//#import "PublicWebController.h"

@interface NewPublicViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *url;
    NSMutableArray *dataDicArr;
}
@property (nonatomic, strong) UITableView *mytable;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIImageView *nullImgeView;
@end

@implementation NewPublicViewController
-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
        _nullImgeView.image = [UIImage imageNamed:@"none_dataImage"];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isPublic) {
        self.myTitle = @"公告";
        url = @"117";
    }else{
        self.myTitle = @"健康消息";
        url = @"122";
    }
    self.nullImgeView.alpha=0;
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.titleLab.textColor = kMainTitleColor;
    [self.view addSubview:self.nullImgeView];
    self.mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.mytable.delegate = self;
    self.mytable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.mytable.dataSource = self;
    self.mytable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //增加下拉刷新
    self.mytable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHeadData)];
    self.mytable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [self.view addSubview:self.mytable];
    self.mytable.backgroundColor = kbackGroundGrayColor;
    //   返回：IOS端会自动下拉刷新。
    [self.mytable.mj_header beginRefreshing];
    
    //初始化数组
    self.dataArr  = [[NSMutableArray alloc]init];
    dataDicArr = [[NSMutableArray alloc]init];
}

-(void)getHeadData
{
    self.page = 1;
    [self loadData];
}

-(void)getMoreData
{
    self.page++;
    [self loadData];
}

#pragma mark - 获取数据
-(void)loadDataFromBase
{
    if ([[EGOCache globalCache] hasCacheForKey:@"public"]) {
        
        NSMutableArray *dicArr = (NSMutableArray *) [[EGOCache globalCache]objectForKey:@"public"];
        
        for (int i = 0; i < dicArr.count; i++) {
            NSDictionary *dic = (NSDictionary *)dicArr[i];
            [self dealWithPublicDicData:dic];
        }
        
        [self.mytable reloadData];
        self.page = 1;
    }
}
//解析数据
-(void)dealWithPublicDicData:(NSDictionary *)dic
{
    //公告和系统消息的数据处理
    NSMutableArray *tempArr = [NSMutableArray array];
    if ([url isEqualToString:@"117"]) {
        tempArr = (NSMutableArray *)[PublicNoticeModel objectArrayWithKeyValuesArray:dic[@"Result"]];
    }else{
        NSArray *arr = dic[@"Result"];
        for (NSDictionary *d in arr) {
            PublicNoticeModel *model = [[PublicNoticeModel alloc]init];
            model.NoticeUrl = d[@"NoticeUrl"];
            model.NoticeID = [NSString stringWithFormat:@"%@",d[@"NoticeID"]];
            model.NoticePicture = d[@""];
            model.NoticeTitle = d[@"NoticeTitle"];
            model.AuditTime = d[@"NoticeTime"];
            model.NoticeContent = d[@"NoticeContent"];
            model.NoticeReferer = [NSString stringWithFormat:@"%@",d[@"NoticeReferer"]];
            model.IsRead=[d[@"IsRead"] integerValue];
            model.isSystemMessage = YES;
            [tempArr addObject:model];
        }
    }
    
    for (PublicNoticeModel *model in tempArr) {
        NewPublicFrame *frame = [[NewPublicFrame alloc] init];
        frame.publicModel = model;
        [self.dataArr addObject:frame];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    
}

-(void)loadData
{
    //,@"MemberID":@41
    
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"PageIndex":[NSNumber numberWithInteger:self.page],@"PageSize":@5,@"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:url parameters:dict success:^(id json) {
        NSLog(@"公告--%@：%@",url,json);
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            
            if (self.page == 1) {
                [self.dataArr removeAllObjects];
                [dataDicArr removeAllObjects];
            }
            
            [self dealWithPublicDicData:dic];
            
            //储存数据，进行缓存
            [dataDicArr addObject:dic];
            
            [self.mytable.mj_header endRefreshing];
            [self.mytable.mj_footer endRefreshing];
            
            [self.mytable reloadData];
            
            if (self.dataArr.count == 0) {
                self.nullImgeView.alpha = 1;
            }else{
                self.nullImgeView.alpha = 0;
            }
            
            [[EGOCache globalCache]setObject:dataDicArr forKey:@"public"];//缓存
            
            if (self.dataArr.count >= [[NSString stringWithFormat:@"%@",dic[@"Rows"]] integerValue]) {
                [self.mytable.mj_footer endRefreshingWithNoMoreData];
            }
            
            //刷新未读数角标
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReadRefresh" object:nil];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            [self.mytable.mj_header endRefreshing];
            [self.mytable.mj_footer endRefreshing];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:error];
        [self.mytable.mj_header endRefreshing];
        [self.mytable.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"cell";
    NewPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NewPublicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%li",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    NewPublicFrame *frame  = (NewPublicFrame *)self.dataArr[indexPath.row];
    cell.publicFrame = frame;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewPublicFrame *frame  = (NewPublicFrame *)self.dataArr[indexPath.row];
    if (frame.publicModel.NoticeUrl.length > 0) {
        NSLog(@"查看全文");

        HealthWiKiViewController *web = [[HealthWiKiViewController alloc]initWithType:pageTypeNormal];
        
        web.urlString = [NSString stringWithFormat:@"%@",frame.publicModel.NoticeUrl];
        web.myTitle = self.myTitle;
        
        [self.navigationController pushViewController:web animated:YES];
        
        
        
        [self.mytable reloadData];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewPublicFrame *frame  = (NewPublicFrame *)self.dataArr[indexPath.row];
    return frame.cellHeight;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
