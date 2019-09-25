//
//  ExamineReportViewController.m
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ExamineReportViewController.h"
#import "ExamineReportCell.h"
#import "ExanubeReportModel.h"
#import "ExamDetailReportViewController.h"
#import "XKNavigationController.h"
#import "XKArchiveTransetionDelegateModel.h"

@interface ExamineReportViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    BOOL isDoneLoadData;
}
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (nonatomic,strong)XKArchiveTransetionDelegateModel *archiveCoverDelegate;
@property (nonatomic, strong) UIImageView *nullImgeView;
@property (nonatomic, assign) NSInteger page;
@end

@implementation ExamineReportViewController

-(UIImageView *)nullImgeView
{
    if (!_nullImgeView) {
        
        _nullImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth /2.15, KScreenWidth /2.15)];
        _nullImgeView.center = CGPointMake(KScreenWidth/2, KScreenHeight/2 - KScreenWidth/2.15/2);
        _nullImgeView.image = [UIImage imageNamed:@"none"];
        _nullImgeView.alpha = 0;
        
    }
    return _nullImgeView;
}

-(XKArchiveTransetionDelegateModel *)archiveCoverDelegate{
    if (!_archiveCoverDelegate) {
        _archiveCoverDelegate=[[XKArchiveTransetionDelegateModel alloc]init];
    }
    return _archiveCoverDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataArr = [[NSMutableArray alloc]init];
    self.page = 1;
    //    [self loadData];
    
    //增加下拉刷新
    self.mytable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHeadData)];
    self.mytable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    
    //    [self.mytable.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.mytable.mj_header beginRefreshing];
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

#pragma mark - 请求数据
-(void)loadData
{
    NSString *memberID = [UserInfoTool getLoginInfo].MemberID;
    NSDictionary *dict = @{@"Token":[UserInfoTool getLoginInfo].Token,
                           @"MemberID":[NSNumber numberWithInteger:[memberID integerValue]],
                           @"PageIndex":[NSNumber numberWithInteger:self.page],
                           @"PageSize":@10};
    
    XKLOG(@"%@",dict);
//    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    
    [NetWorkTool postAction:checkHomeGetUserMedicalReportHistoryList params:dict finishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            if (self.page == 1) {
                [self->_dataArr removeAllObjects];
                
            }
            
            NSArray *arr = response.Result;
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[ExanubeReportModel  objectArrayWithKeyValuesArray:arr]];
            [self->_dataArr addObjectsFromArray:tempArr];
            
            self->isDoneLoadData = YES;
            
            [self.view addSubview:self.nullImgeView];
            
            [self.mytable reloadData];
            [self.mytable.mj_header endRefreshing];
            [self.mytable.mj_footer endRefreshing];
            
            if (self->_dataArr.count >= [[NSString stringWithFormat:@"%@",response.jsonDic[@"Rows"]] integerValue]) {
                [self.mytable.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            
            ShowErrorStatus(response.msg);
            [self.mytable.mj_header endRefreshing];
            [self.mytable.mj_footer endRefreshing];
        }
    }];
//    [ProtosomaticHttpTool protosomaticPostWithURLString:@"301" parameters:dict success:^(id json) {
//        XKLOG(@"检测报告301：%@",json);
//
//        NSDictionary *dic= (NSDictionary *)json;
//
//        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
//
//            [[XKLoadingView shareLoadingView] hideLoding];
//            if (self.page == 1) {
//                [_dataArr removeAllObjects];
//
//            }
//
//            NSArray *arr = dic[@"Result"];
//            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[ExanubeReportModel  objectArrayWithKeyValuesArray:arr]];
//            [_dataArr addObjectsFromArray:tempArr];
//
//            isDoneLoadData = YES;
//
//            [self.view addSubview:self.nullImgeView];
//
//            [self.mytable reloadData];
//            [self.mytable.mj_header endRefreshing];
//            [self.mytable.mj_footer endRefreshing];
//
//            if (_dataArr.count >= [[NSString stringWithFormat:@"%@",dic[@"Rows"]] integerValue]) {
//                [self.mytable.mj_footer endRefreshingWithNoMoreData];
//            }
//
//        }else{
//            [[XKLoadingView shareLoadingView] errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
//            [self.mytable.mj_header endRefreshing];
//            [self.mytable.mj_footer endRefreshing];
//        }
//
//    } failure:^(id error) {
//
//        XKLOG(@"%@",error);
//        [[XKLoadingView shareLoadingView] errorloadingText:error];
//        [self.mytable.mj_header endRefreshing];
//        [self.mytable.mj_footer endRefreshing];
//    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArr.count == 0) {
        self.nullImgeView.alpha = 1;
    }else{
        self.nullImgeView.alpha = 0;
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = @"cellid";
    ExamineReportCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ExamineReportCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataArr.count>0) {
        
        ExanubeReportModel *model = _dataArr[indexPath.row];
        model.cellIndex = indexPath.row;
        cell.examModel = model;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExanubeReportModel *model = _dataArr[indexPath.row];
    
    ExamDetailReportViewController *vc = [[ExamDetailReportViewController alloc]init];
//    Dateformat *dateFor = [[Dateformat alloc]init];
//    vc.title  = [dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",model.TestTime] withFormat:@"YYYY-MM-dd"];
    vc.title = [DateformatTool ymdStringFromString:[DateformatTool dateFromString:[NSString stringWithFormat:@"%@",model.TestTime]]];
    vc.PhysicalExaminationID = model.PhysicalExaminationID;//体检编号
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:vc];
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;//设置代理，代理需要初始化
    nav.modalPresentationStyle=UIModalPresentationCustom;//转场动画方法
    [self presentViewController:nav animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 106;
}

-(void)dealloc
{
    //    NSDictionary *dic = @{@"year":[NSNumber numberWithInteger:year],@"month":[NSNumber numberWithInteger:month],@"day":[NSNumber numberWithInteger:day],@"hour":[NSNumber numberWithInteger:hour],@"min":[NSNumber numberWithInteger:min],@"sec":[NSNumber numberWithInteger:sec],@"sumtime":dayStr};
//    Dateformat *deta = [[Dateformat alloc]init];
    NSDictionary *dic = [DateformatTool getDateTime];
    NSString *nowDay = [NSString stringWithFormat:@"%@%@%@",dic[@"year"],dic[@"month"],dic[@"day"]];
    
    NSUserDefaults  *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *dayTime = [userdefault objectForKey:@"reportDay"];
    NSString *timesCount = [userdefault objectForKey:@"timesCount"];
    //    NSLog(@"nowDay:%@ -- dayTime:%@ -- times :%@",nowDay,dayTime,timesCount);
    BOOL refresh = NO;
    
    if ([dayTime isEqualToString:nowDay]) {
        
        if (timesCount) {
            if ([timesCount integerValue] <1) {
                refresh = YES;
            }
        }else{
            //第一次赋值
            [userdefault setObject:@"0" forKey:@"timesCount"];
        }
        
    }else{
        [userdefault setObject:nowDay forKey:@"reportDay"];
        [userdefault setObject:@"0" forKey:@"timesCount"];
        refresh = YES;
    }
    
    dayTime = [userdefault objectForKey:@"reportDay"];
    timesCount = [userdefault objectForKey:@"timesCount"];
    //    NSLog(@"%@--%@",dayTime,timesCount);
    
    //刷新首页分数,当天小于两次
    if (isDoneLoadData && refresh) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"homeFresh1" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loadSpData" object:nil];
        
        timesCount = [NSString stringWithFormat:@"%li",[timesCount integerValue] + 1];
        [userdefault setObject:timesCount forKey:@"timesCount"];
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

