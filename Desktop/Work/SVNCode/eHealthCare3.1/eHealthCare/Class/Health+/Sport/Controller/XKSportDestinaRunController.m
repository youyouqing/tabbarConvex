//
//  XKSportDestinaRunController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "XKSportDestinaRunController.h"
#import "XKSportRunHeaderView.h"
#import "CountDownViewController.h"
#import "XKSportDestinationController.h"

@interface XKSportDestinaRunController ()
@property (nonatomic,strong) XKSportRunHeaderView *topView;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation XKSportDestinaRunController
-(XKSportRunHeaderView *)topView{
    if (!_topView) {
        _topView = [[[NSBundle mainBundle] loadNibNamed:@"XKSportRunHeaderView" owner:self options:nil] firstObject];
        _topView.delegate = self;
        _topView.x = 0;
        _topView.y = 0;
        _topView.width = KScreenWidth;
        _topView.height = KScreenHeight;
    }
    return _topView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.view.backgroundColor = kbackGroundColor;
     self.tableView.backgroundColor = kbackGroundColor;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    //给表格的头部尾部视图赋值
    self.tableView.tableHeaderView = self.topView;
    self.topView.destinaMod = self.destinaMod;
    
    if ([SportCommonMod shareInstance].Type == 1) {
        self.topView.runBgImage.image = [UIImage imageNamed:@"bg_target_run"];
    }else  if ([SportCommonMod shareInstance].Type == 2) {
        self.topView.runBgImage.image = [UIImage imageNamed:@"bg_target_run"];
    }else  if ([SportCommonMod shareInstance].Type == 3) {
        self.topView.runBgImage.image = [UIImage imageNamed:@"bg_target_climb"];
    }
    else  if ([SportCommonMod shareInstance].Type == 4) {
        self.topView.runBgImage.image = [UIImage imageNamed:@"bg_target_ride"];
    }
    
        //返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    //    [leftBtn setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];

    [leftBtn addTarget:self action:@selector(popToUpViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(34);
        make.width.height.mas_equalTo(40);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = Kfont(20);
    titleLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.myTitle;
    [self.tableView addSubview:titleLab];
    titleLab.text = @"目标";
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
        make.top.mas_equalTo(34);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(90);
    }];
}
-(void)backClickView
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark   XKSportRunHeaderViewDelegate
- (void)sportRunHeaderViewbuttonClick;
{
   
    if ([self.destinaMod.title isEqualToString:@"分钟"]) {
        [SportCommonMod shareInstance].isMinuteCount = YES;
        [SportCommonMod shareInstance].totalTime = [self.destinaMod.destinaDataStr floatValue];
    }else
    {
        [SportCommonMod shareInstance].isMinuteCount = NO;
        [SportCommonMod shareInstance].totalDistance = [self.destinaMod.destinaDataStr floatValue];
        
    }
    
    
    CountDownViewController *viewController = [[CountDownViewController alloc] initWithType:pageTypeNoNavigation];
    [self.navigationController pushViewController:viewController animated:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)sportReplaceDestinaHeaderViewbuttonClick;
{
//    XKSportDestinationController *sport = [[XKSportDestinationController alloc]initWithType:pageTypeNormal];
//    [self.navigationController pushViewController:sport animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
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