//
//  VisionTestViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//视力测试

#import "VisionTestViewController.h"
#import "EyeEaxmingViewController.h"

@interface VisionTestViewController ()

@end

@implementation VisionTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor =  [UIColor whiteColor];
   
    UIImageView *photoImage = [[UIImageView alloc]init];
    
    if (self.isRight)
    {
        photoImage.image = [UIImage imageNamed:@"eye_left"];
    }else
    {
        photoImage.image = [UIImage imageNamed:@"eye_right"];
    }
    [self.view addSubview:photoImage];
//    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(76));
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(KWidth(200), KHeight(265)));
//    }];
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth,KScreenWidth*928.0/750.0 ));
    }];
    //提示文字
    UILabel *tipLabel = [[UILabel alloc]init];
    
    if (self.isRight)
    {
        tipLabel.text = @"遮住左眼,开始右眼测试";
    }else
    {
        tipLabel.text = @"遮住右眼,开始左眼测试";
    }
    tipLabel.font = Kfont(16);
    tipLabel.textColor = kMainTitleColor;
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(photoImage.mas_bottom).mas_offset(KHeight(30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(16));
    }];
    
    //开始测试按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    startButton.backgroundColor = kMainColor;
    [startButton setTitle:@"开始测试" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startTest) forControlEvents:UIControlEventTouchUpInside];
    [startButton SetTheArcButton];
    startButton.titleLabel.font = Kfont(19);
    
    [self.view addSubview:startButton];
    
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(- KHeight(8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(10),KHeight(45)));
    }];
    
    [self showTitleAndBackButtonWithoutNavigation:self.myTitle];
    self.headerView.backgroundColor = kMainColor;
}

#pragma mark Action
- (void)startTest
{
    EyeEaxmingViewController *eye = [[EyeEaxmingViewController alloc]initWithType:pageTypeNormal];
    
    eye.isRight = self.isRight;
    //将之前存储的左眼视力值传过去
    eye.leftEyeNum = self.leftEyeNum;
    
    eye.myTitle = @"测视力";
    
    [self.navigationController pushViewController:eye animated:YES];
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
