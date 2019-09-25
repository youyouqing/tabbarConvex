//
//  BaseViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeViewController.h"
#import "Health+ViewController.h"
#import "MallViewController.h"
#import "PersonalCenterViewController.h"
#import "HealthTreeViewController.h"
@interface BaseViewController ()



@end

@implementation BaseViewController

- (id)initWithType:(pageType)pageType
{
    if (self = [super init]) {
        
        self.pageType = pageType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self createBaseViewUI];
  
    if (self.pageType < pageTypeNoNavigation) {
        
        self.headerView.hidden = NO;
    }else{
        self.headerView.hidden = YES;
    }
    
//    if ([self isKindOfClass:[HomeViewController class]] ||
//        [self isKindOfClass:[Health_ViewController class]] ||
//        [self isKindOfClass:[PersonalCenterViewController class]]
//        ||[self isKindOfClass:[HealthTreeViewController class]])
//    {
//        self.tabBarController.tabBar.hidden = NO;
//    }else
//    {
//        self.tabBarController.tabBar.hidden = YES;
//    }
//     self.view.frame = [UIScreen mainScreen].bounds;
}

#pragma mark- UI
- (void)createBaseViewUI{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = MainCOLOR;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(PublicY);
    }];
    self.headerView = headerView;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_white"] forState:UIControlStateHighlighted];
    
    [leftBtn addTarget:self action:@selector(popToUpViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.bottom.mas_equalTo(-2);
        make.width.height.mas_equalTo(40);
    }];
    self.leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerView addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    rightBtn.titleLabel.font = Kfont(16);
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
        make.height.mas_equalTo(40);
    }];
    
    if (self.pageType != pageTypeNormal)
    {
        leftBtn.hidden = YES;
        rightBtn.hidden = YES;
        
    }else
    {
        leftBtn.hidden = NO;
        rightBtn.hidden = NO;
    }
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = Kfont(20);
    titleLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.myTitle;
    [headerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.mas_equalTo(leftBtn.mas_right).mas_offset(12);
//        make.right.mas_equalTo(rightBtn.mas_left).mas_offset(12);
        make.width.mas_equalTo(190);
        make.centerX.mas_equalTo(headerView.mas_centerX);
        make.bottom.mas_equalTo(headerView.mas_bottom).offset(-2);
        make.height.mas_equalTo(40);
    }];
    self.titleLab = titleLab;
    
//    UIImageView *horLineView = [[UIImageView alloc] init];
//    horLineView.backgroundColor = [UIColor lightGrayColor];
//    [headerView addSubview:horLineView];
//    [horLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.mas_equalTo(0);
//        make.centerX.mas_equalTo(headerView.mas_centerX);
//        make.bottom.mas_equalTo(headerView.mas_bottom);
//        make.height.mas_equalTo(0.5);
//    }];
//
}

#pragma mark Action
- (void)popToUpViewController
{
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([self isKindOfClass:[HomeViewController class]] ||
//        [self isKindOfClass:[Health_ViewController class]] ||
//        [self isKindOfClass:[PersonalCenterViewController class]] ||[self isKindOfClass:[HealthTreeViewController class]])
//    {
//        self.tabBarController.tabBar.hidden = NO;
//    }else
//    {
//        self.tabBarController.tabBar.hidden = YES;
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set method
- (void)setMyTitle:(NSString *)myTitle
{
    _myTitle = myTitle;
    _titleLab.text = myTitle;
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
