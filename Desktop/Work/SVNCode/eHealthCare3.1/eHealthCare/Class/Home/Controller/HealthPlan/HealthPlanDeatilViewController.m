//
//  HealthPlanDeatilViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/21.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthPlanDeatilViewController.h"
#import "PlanDirectoryView.h"

@interface HealthPlanDeatilViewController ()

@property (nonatomic, strong) PlanDirectoryView *planDirectoryView;//计划目录

@end

@implementation HealthPlanDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI
{
    [self.rightBtn setTitle:@"计划目录" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.rightBtn SetTheArcButton];
    self.rightBtn.backgroundColor = [UIColor whiteColor];
    [self.rightBtn addTarget:self action:@selector(popPlanDirectorView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Action

//弹出计划目录
- (void)popPlanDirectorView
{
    
}

#pragma mark Lazy load

- (PlanDirectoryView *)planDirectoryView
{
    if (!_planDirectoryView) {
        _planDirectoryView = [[PlanDirectoryView alloc]init];
    }
    return _planDirectoryView;
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
