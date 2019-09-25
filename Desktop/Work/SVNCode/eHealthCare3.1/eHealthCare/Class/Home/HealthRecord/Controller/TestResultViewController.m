//
//  TestResultViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/8.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TestResultViewController.h"
#import "ReadyTestViewController.h"
#import "HealthTreeViewController.h"
#import "CheckResult.h"
@interface TestResultViewController ()

@end

static NSInteger restetButtonAndTestOtherButtonTag = 100;

@implementation TestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

#pragma mark UI
- (void)createUI
{
    self.view.backgroundColor = kMainColor;
    
//    [self showTitleAndBackButtonWithoutNavigation:self.myTitle];
   
    
    //测试结果title
    UILabel *resultTitle = [[UILabel alloc]init];
    
    resultTitle.text = self.dataDic[@"Title"];
    resultTitle.textColor = [UIColor whiteColor];
    resultTitle.textAlignment = NSTextAlignmentCenter;
    resultTitle.font = Kfont(30);
    resultTitle.numberOfLines = 0;
    resultTitle.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:resultTitle];
    
    CGSize maxResultTitleSize = CGSizeMake(KWidth(300), CGFLOAT_MAX);
    CGSize expectResultTitleSize = [resultTitle sizeThatFits:maxResultTitleSize];
    
    [resultTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(24));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(300), expectResultTitleSize.height));
    }];
    
    //测试结果正文
    UILabel *contentLabel = [[UILabel alloc]init];

    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.text = self.dataDic[@"AnswerContent"];
    contentLabel.font = Kfont(14);
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;

    [self.view addSubview:contentLabel];

    CGSize maxContentSize = CGSizeMake(KWidth(290), CGFLOAT_MAX);
    CGSize expectContentSize = [contentLabel sizeThatFits:maxContentSize];

    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(resultTitle.mas_bottom).mas_offset(KHeight(30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(300), expectContentSize.height));
    }];
    
    //白框
    UIImageView *contentView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"health_resultDashed"]];
    
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(resultTitle.mas_bottom).mas_offset(KHeight(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(expectContentSize.width + KWidth(10), expectContentSize.height + KHeight(20)));
    }];
    
    NSArray *buttonTitleArray = @[@"重新测试"];//,@"更多测评"
    for (int i = 0; i < buttonTitleArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:kMainColor forState:UIControlStateNormal];
        button.tag = restetButtonAndTestOtherButtonTag + i;
        button.backgroundColor = [UIColor whiteColor];
//        [button addTarget:self action:@selector(retestOrTestOther:) forControlEvents:UIControlEventTouchUpInside];
         [button addTarget:self action:@selector(retest) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(contentView.mas_bottom).mas_offset(KHeight(20));
//            if (i == 0)
//            {
//                make.left.mas_equalTo(KWidth(22));
//            }else
//            {
//                make.right.mas_equalTo(- KWidth(22));
//            }
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KWidth(120), KHeight(50)));
        }];
        
        [button SetTheArcButton];
    }
}
-(void)popToUpViewController
{
  for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[HealthTreeViewController class]])
            {
                HealthTreeViewController *test = (HealthTreeViewController *)controller;
                [self.navigationController popToViewController:test animated:YES];
                return;
            }
            if ([controller isKindOfClass:[ReadyTestViewController class]])
            {
                ReadyTestViewController *test = (ReadyTestViewController *)controller;
                [self.navigationController popToViewController:test animated:YES];
                return;
            }
        }
  
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)retest
{
    NSMutableArray *controllerArrays=(NSMutableArray *)[self.navigationController viewControllers];
    for (UIViewController *controller in controllerArrays) {
        if ([controller isKindOfClass:[ReadyTestViewController class]])
        {
            ReadyTestViewController *ready = (ReadyTestViewController *)controller;
            CheckResult *model = [CheckResult mj_objectWithKeyValues:self.dataDic];
            ready.dataDic = [model.listModel mj_keyValues]; //self.msgModel.listModel;
            [self.navigationController popToViewController:ready animated:YES];
            return;
        }
    }
    
    ReadyTestViewController *ready = [[ReadyTestViewController alloc]initWithType:pageTypeNormal];
    CheckResult *model = [CheckResult mj_objectWithKeyValues:self.dataDic];
    ready.dataDic = [model.listModel mj_keyValues];
    [self.navigationController pushViewController:ready animated:YES];
    
}
- (void)retestOrTestOther:(UIButton *)button
{
    if (button.tag - restetButtonAndTestOtherButtonTag == 0)
    {
        NSMutableArray *controllerArrays=(NSMutableArray *)[self.navigationController viewControllers];
        
        if ([controllerArrays containsObject:[ReadyTestViewController class]]) {
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[ReadyTestViewController class]])
                {
                    ReadyTestViewController *ready = (ReadyTestViewController *)controller;
                    CheckResult *model = [CheckResult mj_objectWithKeyValues:self.dataDic];
                     ready.dataDic = [model.listModel mj_keyValues]; //self.msgModel.listModel;
                    [self.navigationController popToViewController:ready animated:YES];
                    break;
                }
               
            }
        }else
        {
            ReadyTestViewController *ready = [[ReadyTestViewController alloc]initWithType:pageTypeNormal];
            CheckResult *model = [CheckResult mj_objectWithKeyValues:self.dataDic];
            ready.dataDic = [model.listModel mj_keyValues];
           [self.navigationController pushViewController:ready animated:YES];
        }
       
    }else
    {
        
        NSMutableArray *controllerArrays=(NSMutableArray *)[self.navigationController viewControllers];
        
        if ([controllerArrays containsObject:[HealthTreeViewController class]]||[controllerArrays containsObject:[ReadyTestViewController class]]) {
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[HealthTreeViewController class]])
            {
                HealthTreeViewController *test = (HealthTreeViewController *)controller;
                [self.navigationController popToViewController:test animated:YES];
                break;
            }
            if ([controller isKindOfClass:[ReadyTestViewController class]])
            {
                ReadyTestViewController *test = (ReadyTestViewController *)controller;
                [self.navigationController popToViewController:test animated:YES];
                break;
            }
        }
        }
        
        else
        {
//            HealthTreeViewController *ready = [[HealthTreeViewController alloc]initWithType:pageTypeNormal];
//
//            [self.navigationController pushViewController:ready animated:YES];
        }
    }
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
