//
//  XKMultiFunctionCheckResultController.m
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//携康3.0版本pc300检测报告页面

#import "XKMultiFunctionCheckResultController.h"
#import "XKMultiFunctionResuiltsuccessUploadView.h"
#import "HealthRecordController.h"

@interface XKMultiFunctionCheckResultController ()<XKMultiFunctionCheckResultHeadViewDelegate,XKMultiFunctionResuiltsuccessUploadViewDelegate>
{
    XKMultiFunctionCheckResultHeadView *headView;//titleView
}
@property(strong,nonatomic)XKMultiFunctionResuiltsuccessUploadView *successView;
@property (nonatomic,strong)XKMultiFunctionCheckResultHeadView *headView;//头部试图
@property (nonatomic,strong)XKMultiFunctionCheckResultBottomView *botoomView;//头部试图
@property (nonatomic,strong)NSMutableArray *pressArray;//血压列表
@property (nonatomic,strong)NSMutableArray *listArray;
@property(copy,nonatomic)NSString *TestTime;//检测时间
@property(assign,nonatomic)NSInteger IsUpload;//是否上传
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation XKMultiFunctionCheckResultController
-(XKMultiFunctionResuiltsuccessUploadView *)successView
{
    if (!_successView) {
        _successView = [[[NSBundle mainBundle] loadNibNamed:@"XKMultiFunctionResuiltsuccessUploadView" owner:self options:nil] lastObject];
        _successView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
       
        _successView.delegate = self;
    }
    return _successView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self loadData];
    
    
}
//视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitle = @"多功能检测仪";
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor=[UIColor getColor:@"f2f2f2"];
    [self.view addSubview:self.tableView];
    //设置表格的基本属性
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor whiteColor];
    
    self.tableView.estimatedSectionHeaderHeight = 200;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self.tableView registerNib:[UINib nibWithNibName:@"XKMultiFunctionCheckResultCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XKMultiFunctionCheckResultSingleCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
   // [self loadData];
}

//收到内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//表格返回多少个组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//表格每个组返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.pressArray.count>0?self.listArray.count+1:self.listArray.count;
}

//表格cell配置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0&& self.pressArray.count>0) {
        XKMultiFunctionCheckResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
         cell.arrayModel = self.pressArray;

        cell.timeLab.text = [self.TestTime isEqualToString:@"--"]?@"--":[DateformatTool ymdStringFromString:[DateformatTool dateFromString:self.TestTime]];//[date DateFormatWithDate:[NSString stringWithFormat:@"%ld",self.TestTime] withFormat:@"YYYY-MM-dd"];
        return cell;
    }else{
        XKMultiFunctionCheckResultSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (self.pressArray.count>0) {
            cell.model = self.listArray[indexPath.row-1];
        }else{
            cell.model = self.listArray[indexPath.row];
        }
       
//        cell.timeLab.text = [date DateFormatWithDate:[NSString stringWithFormat:@"%ld",self.TestTime] withFormat:@"YYYY-MM-dd"];
        return cell;
    }
    
    return nil;
}
-(XKMultiFunctionCheckResultHeadView *)headView
{

    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"XKMultiFunctionCheckResultHeadView" owner:self options:nil] firstObject];
        _headView.delegate = self;
    }
    return _headView;
}

//表格组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    return self.headView;
}
-(XKMultiFunctionCheckResultBottomView *)botoomView
{
    
    if (!_botoomView) {
        _botoomView = [[[NSBundle mainBundle] loadNibNamed:@"XKMultiFunctionCheckResultBottomView" owner:self options:nil] firstObject];
        _botoomView.delegate = self;
    }
    return _botoomView;
}

//表格组尾部视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.botoomView;
}

//配置组底部视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
-(void)successUploadViewPushOtherController;
{

    
    HealthRecordController *record = [[HealthRecordController alloc]initWithType:pageTypeNormal];
    record.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:record animated:YES];

}
#pragma mark XKMultiFunctionCheckResultBottomViewDelegate
-(void)enterUploadView;
{
        NSLog(@"确认上传报告");
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    
    NSDictionary *dic = @{@"Mobile":[UserInfoTool getLoginInfo].Mobile,
                          @"Token":[UserInfoTool getLoginInfo].Token};
    [NetWorkTool postAction:checkHomePC300UpdateDataUrl params:dic finishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed)
        {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:self.successView];
            
            [self loadData];
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];

  
}

#pragma mark XKMultiFunctionCheckResultHeadViewDelegate  传值DeviceIdtag  
-(void)enterMainView:(int)DeviceIdtag DeviceClasstag:(int)DeviceClasstag Name:(NSString *)Name;
{
    XKDectingViewController *dect = [[XKDectingViewController alloc]initWithType:pageTypeNormal];
    dect.style = DeviceClasstag;
    XKHouseHoldModel *hmodel= [[XKHouseHoldModel alloc]init];
    hmodel.DeviceID = DeviceIdtag;
    hmodel.Name = Name;
    dect.model = hmodel;
    [self.navigationController pushViewController:dect animated:YES];

}
-(void)loadData{
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    
    NSDictionary *dic = @{@"Mobile":[UserInfoTool getLoginInfo].Mobile,
                          @"Token":[UserInfoTool getLoginInfo].Token};
    
    [NetWorkTool postAction:checkHomePC300GetReportUrl params:dic finishedBlock:^(ResponseObject *response) {
         [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed)
        {
            self.IsUpload = [response.Result[@"IsUpload"] integerValue];//是否上传(0未上传1已上传)注：如果为未上传“上传按钮”显示，否则隐藏
            
            self.pressArray = (NSMutableArray *)[ReportModel objectArrayWithKeyValuesArray:response.Result[@"xyList"]];
            
            self.listArray = (NSMutableArray *)[ReportModel objectArrayWithKeyValuesArray:response.Result[@"list"]];
            
            
            self.headView.dataArr = [XKMultiFunctionCheckResultModel objectArrayWithKeyValuesArray:response.Result[@"DeviceList"]];
            
            
            
            
            if ( self.IsUpload == 0) {//未上传
                
                
                self.botoomView.backgroundColor = kMainColor;
                self.TestTime =  [NSString stringWithFormat:@"%@",response.Result[@"TestTime"]];
                self.botoomView.upBtnIsOrNot = YES ;
            }else{//已上传
                self.TestTime =  @"--";
                self.botoomView.backgroundColor = [UIColor colorWithHexString:@"D4D4D4"];
                self.botoomView.upBtnIsOrNot = NO ;
                
                
            }
            
            NSLog(@"%@---%@",self.pressArray,self.listArray);
            
            [self.tableView reloadData];
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
    
}
@end
