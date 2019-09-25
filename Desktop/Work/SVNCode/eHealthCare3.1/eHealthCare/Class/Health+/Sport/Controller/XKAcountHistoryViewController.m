//
//  XKAcountHistoryViewController.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKAcountHistoryViewController.h"
#import "XKAcountHistoryBottomView.h"
#import "XKAcountHistoryHeadView.h"
#import "StepModel.h"

//暂代数据源的类
#import "DrinkData.h"

@interface XKAcountHistoryViewController ()<XKAcountHistoryHeadViewDelegate>

/**
 底部视图属性
 */
@property (nonatomic,strong) XKAcountHistoryBottomView *bottomView;
/**
 头部视图属性
 */
@property (nonatomic,strong) XKAcountHistoryHeadView *topView;

@property (nonatomic,strong) NSMutableArray *historyArray;

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation XKAcountHistoryViewController

/**
 底部视图懒加载
 */
-(XKAcountHistoryBottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"XKAcountHistoryBottomView" owner:self options:nil] firstObject];
        _bottomView.x = 0;
        _bottomView.y = 0;
        _bottomView.width = KScreenWidth;
        _bottomView.height = KScreenHeight/2;
    }
    return _bottomView;
}

/**
 头部视图懒加载
 */
-(XKAcountHistoryHeadView *)topView{
    if (!_topView) {
        _topView = [[[NSBundle mainBundle] loadNibNamed:@"XKAcountHistoryHeadView" owner:self options:nil] firstObject];
        _topView.delegate = self;
        _topView.x = 0;
        _topView.y = 0;
        _topView.width = KScreenWidth;
        _topView.height = KScreenHeight/2;
    }
    return _topView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //给表格的头部尾部视图赋值
    self.tableView.tableHeaderView = self.topView;
    self.tableView.tableFooterView = self.bottomView;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.left.mas_equalTo(10 );
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo( CGRectGetWidth(self.view.frame)-20);
    }];

    
    [self loadData];//获取数据
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    self.titleLab.textColor = kMainTitleColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
   
}

//加载数据
-(void)loadData{

    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"344" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID)} success:^(id json) {
        
        NSLog(@"344-----%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            self.historyArray = (NSMutableArray *)[StepModel objectArrayWithKeyValuesArray:json[@"Result"]];
            if (!self.step) {
                self.step = [[StepModel alloc] init];
            }
            StepModel *model = [[StepModel alloc]init];
            if (self.historyArray.count>=1) {
                model = self.historyArray[self.historyArray.count-1];
                
                self.step.StepOrder = model.StepOrder;
                self.step.CreateTime = model.CreateTime;
                self.step.SuggestContent = model.SuggestContent;
                self.step.completeDate = model.completeDate;
                self.step.weekDay = model.weekDay;
                self.step.dayTime = model.dayTime;
                self.historyArray[self.historyArray.count-1] = self.step;//替换今日本地最新的数据 就是网络太慢  刷新不过来导致的模型为空
                
                StepModel *stModel = self.historyArray[self.historyArray.count-1];
                self.myTitle = stModel.completeDate;
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
                
                for (StepModel *data in self.historyArray) {
                    [array addObject:@(data.StepCount)];
                }
                self.topView.dataArray = array;
                self.topView.orgionalArray = self.historyArray;
                self.bottomView.model = self.historyArray[self.historyArray.count-1];//刷新了2遍这个模型，这个应该最后刷新，否则会被self.topView.orgionalArray覆盖掉
                
            }
  
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
        }
        
    } failure:^(id error) {
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
    }];
    
}

/**
 头部视图的协议方法
 */
-(void)showCurrentDayData:(StepModel *)model{
    
    self.bottomView.model = model;
    
    if (model != nil) {
         self.myTitle = model.completeDate;
    }
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
