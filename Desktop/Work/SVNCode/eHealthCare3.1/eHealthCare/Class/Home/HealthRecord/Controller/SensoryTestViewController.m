//
//  SensoryTestViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SensoryTestViewController.h"
#import "VisionTestViewController.h"
#import "ColorVisionViewController.h"
#import "FlexibilityViewController.h"
#import "FistViewController.h"

@interface SensoryTestViewController ()

@end

@implementation SensoryTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

#pragma mark UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *photoImage = [[UIImageView alloc]init];
    photoImage.backgroundColor = kMainColor;
    [self.view addSubview:photoImage];
    
    //提示文字
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.font = Kfont(16);
    tipLabel.textColor = kMainTitleColor;
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:tipLabel];
    
    //开始测试按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    startButton.backgroundColor = kMainColor;
    [startButton setTitle:@"开始测试" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startTest) forControlEvents:UIControlEventTouchUpInside];
    [startButton SetTheArcButton];
    startButton.titleLabel.font = Kfont(19);
    
    [self.view addSubview:startButton];
    
    
    NSString *titleString = @"";
    if (self.testType == sensoryTypeVision)
    {
        titleString = @"测视力";
        photoImage.image = [UIImage imageNamed:@"eye_vision"];
        tipLabel.text = @"请将手机屏幕面向自己，放置在距离您双眼40厘米处，并保持手机屏幕的干净整洁。";
        
        //设置约束
        [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth,KScreenWidth*928.0/750.0 ));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(photoImage.mas_bottom).mas_offset(KHeight(48));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(44), KHeight(45)));
        }];
        
        [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(- KHeight(8));
//            make.height.mas_equalTo(KHeight(27.5));
//            make.left.mas_equalTo(KWidth(5));
//             make.right.mas_equalTo(KWidth(5));
            
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(10), KHeight(45)));
        }];
        
    }else if (self.testType == sensoryTypeColorVision)
    {
        titleString = @"测色觉";
        photoImage.image = [UIImage imageNamed:@"iv_sejue"];
        tipLabel.text = @"请将手机屏幕面向自己，放置在离您双眼60厘米处，特殊情况不能超过50-100厘米范围。";
        
        //设置约束
        [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth,KScreenWidth*928.0/750.0 ));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(photoImage.mas_bottom).mas_offset(KHeight(48));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(44), KHeight(45)));
        }];
        
        [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(- KHeight(8));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(10), KHeight(45)));
        }];
        
    }else if (self.testType == sensoryTypeFlexibility)
    {
        titleString = @"柔韧度";
        photoImage.image = [UIImage imageNamed:@"iv_rourendu"];
        tipLabel.text = @"弯腰，将手机置于双脚前，双手食指轻触界面，保持身体拉伸状态，坚持时间越久，得分越高";
        
        //设置约束
        [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth,KScreenWidth*928.0/750.0 ));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(photoImage.mas_bottom).mas_offset(KHeight(48));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(44), KHeight(75)));
        }];
        
        [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(- KHeight(8));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(10), KHeight(45)));
        }];
        
    }else if (self.testType == sensoryTypeFist)
    {
        titleString = @"大力士";
        photoImage.image = [UIImage imageNamed:@"iv_dalishi"];
        tipLabel.text = @"手握手机，做用力挥拳动作，挥拳速度越快、频率越高、力量越大、得分越高。";
        
        //设置约束
        [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth,KScreenWidth*928.0/750.0 ));
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(photoImage.mas_bottom).mas_offset(KHeight(48));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(44), KHeight(45)));
        }];
        
        [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(- KHeight(8));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(10), KHeight(45)));
        }];
    }
    [self showTitleAndBackButtonWithoutNavigation:titleString];
    
    
}
#pragma mark Action
//开始测试
- (void)startTest
{
    if (self.testType == sensoryTypeVision)
    {
        VisionTestViewController *vision = [[VisionTestViewController alloc]initWithType:pageTypeNoNavigation];
        
        vision.myTitle = @"测视力";
        
        [self.navigationController pushViewController:vision animated:YES];
        
    }else if (self.testType == sensoryTypeColorVision)
    {
        ColorVisionViewController *color = [[ColorVisionViewController alloc]initWithType:pageTypeNoNavigation];
        
        color.myTitle = @"测色觉";
        
        [self.navigationController pushViewController:color animated:YES];
    }else if (self.testType == sensoryTypeFlexibility)
    {
        FlexibilityViewController *fle = [[FlexibilityViewController alloc]initWithType:pageTypeNoNavigation];
        
        fle.myTitle = @"柔韧度";
        
        [self.navigationController pushViewController:fle animated:YES];
        
    }else if (self.testType == sensoryTypeFist)
    {
        FistViewController *fist = [[FistViewController alloc]initWithType:pageTypeNormal];
        
        fist.myTitle = @"挥拳测试";
        
        [self.navigationController pushViewController:fist animated:NO];
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