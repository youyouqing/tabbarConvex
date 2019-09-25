//
//  XKHealthIntegralRewardController.m
//  NM
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 mac. All rights reserved.
//携康健康积分k值趋势视图控制器

#import "XKHealthIntegralTrendRewardController.h"
#import "XKHealthIntegralKTrendModel.h"
#import "XKHealthIntegralTrendRewardView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface XKHealthIntegralTrendRewardController ()

@property(strong,nonatomic)XKHealthIntegralTrendRewardView *rewardView;
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation XKHealthIntegralTrendRewardController

-(XKHealthIntegralTrendRewardView *)rewardView
{
    
    if (!_rewardView) {
        _rewardView = [[NSBundle mainBundle]loadNibNamed:@"XKHealthIntegralTrendRewardView" owner:nil options:nil].firstObject;
        _rewardView.x = 0;
        _rewardView.y = 0;
        _rewardView.width = KScreenWidth;
        _rewardView.height = KScreenHeight;
    }
    return _rewardView;
}

/**
 视图加载完成的方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
   
 
   
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    self.titleLab.textColor = kMainTitleColor;
    self.view.backgroundColor = kbackGroundGrayColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
//    self.topDrawView.layer.cornerRadius = 6;
//    self.topDrawView.layer.masksToBounds = YES;
    
  
    

    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.rewardView;
    
    [self loadKData];
}
-(UITableView *)tableView
{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=[UIColor getColor:@"f2f2f2"];
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
    
}

/**
 加载k值走势方法
 */
-(void)loadKData{
    [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
    //获取首页健康计划、热门话题数据
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"937" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberId":@([UserInfoTool getLoginInfo].MemberID),@"DaybookType":@(2)} success:^(id json) {
        NSLog(@"获取k值走势信息937--:%@",json);
        if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            [[XKLoadingView shareLoadingView] hideLoding];
            
            self.rewardView.dataArray = [XKHealthIntegralKTrendModel mj_objectArrayWithKeyValuesArray:json[@"Result"]];
       
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:json[@"Basis"][@"Msg"]];
        }
    } failure:^(id error) {
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:@"亲，网速不给力哇~"];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 每个组有多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

/**
 每个cell设置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [UITableView alloc]ini
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
