//
//  EyeEaxmingViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//视力测试

#import "EyeEaxmingViewController.h"
#import "VisionTestViewController.h"
#import "SensoryResultViewController.h"

@interface EyeEaxmingViewController ()
{
    ///题目数
    NSInteger sumTestNum;
    
    ///字号大小
    NSInteger fontNum;
    
    ///随机测试的字母(A~Z)
    NSInteger otherRandNum;
    
    ///位于第几题
    NSInteger indexQuestion;
}

///题目
@property (nonatomic, strong) UILabel *aimLabel;

///视力数值
@property (nonatomic, strong) NSDictionary *eyeResultDic;

@end

static NSInteger buttonTag = 100;

@implementation EyeEaxmingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sumTestNum = 0;
    fontNum = 20;
    otherRandNum = 0;
    
    [self createUI];
    
    [self changeTest];
}

#pragma mark UI
- (void)createUI
{
    self.headerView.backgroundColor = kMainColor;
    self.view.backgroundColor = kMainColor;
    UILabel *aimLabel = [[UILabel alloc]init];
    
    aimLabel.font = Kfont(20);
    aimLabel.text = @"Y";
    aimLabel.textAlignment = NSTextAlignmentCenter;
    aimLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aimLabel];
    self.aimLabel = aimLabel;
    
    [aimLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo( KHeight(129));
//        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.height.mas_equalTo(KHeight(self->fontNum));
         make.size.mas_equalTo(CGSizeMake(KScreenWidth-(54), KHeight(203)));
    }];
    
    //选项
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = kMainColor;
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAnswer:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = buttonTag + i;
        button.titleLabel.font = Kfont(16);
        
        [self.view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(KWidth(27.5) + i * KWidth(125));
            make.bottom.mas_equalTo(- KHeight(150));
            make.size.mas_equalTo(CGSizeMake(KWidth(70), KWidth(70)));
        }];
        
        [button setCircularControl:KWidth(70)];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    //看不清按钮
    UIButton *cannotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cannotButton.backgroundColor =kMainColor;
    [cannotButton setTitle:@"看不清" forState:UIControlStateNormal];
    [cannotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cannotButton SetTheArcButton];
    cannotButton.titleLabel.font = Kfont(16);
    cannotButton.layer.borderColor = kMainColor.CGColor;
    [cannotButton addTarget:self action:@selector(cannotSee:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cannotButton];
    cannotButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [cannotButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(- KHeight(30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth / 2, KHeight(45)));
    }];
}

#pragma mark Action
//得到随机题目字母的ASCII码
-(int)getRandWordWith:(int)nowNum
{
    int randNum = 0;
    if (nowNum == 0) {
        randNum = (arc4random() % 26) + 65;//ASCII:65--90 ,A--Z
    }else{
        while (1) {
            randNum = (arc4random() % 26) + 65;//ASCII:65--90 ,A--Z
            if (randNum!= nowNum && otherRandNum != randNum) {
                otherRandNum = randNum;
                break;
            }
        }
    }
    
    return randNum;
}

//切换题号
-(void)changeTest
{
    sumTestNum++;
    if (sumTestNum == 7)
    {
        [self goToResultOrNextTest];
    }
    int nowAsciiNum = [self getRandWordWith:0];
    self.aimLabel.text = [NSString stringWithFormat:@"%c",nowAsciiNum];
    
    indexQuestion = arc4random()%3;
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag + i];
        if (i == indexQuestion)
        {
            [button setTitle:[NSString stringWithFormat:@"%c",nowAsciiNum] forState:UIControlStateNormal];
        }else
        {
            [button setTitle:[NSString stringWithFormat:@"%c",[self getRandWordWith:nowAsciiNum]] forState:UIControlStateNormal];
        }
    }
}

//选择了答案
- (void)clickAnswer:(UIButton *)sender
{
    if (sender.tag - buttonTag == indexQuestion)
    {
        fontNum -= 2;
        self.aimLabel.font = Kfont(fontNum);
        [self changeTest];
        
    }else{
        NSLog(@"错误 ,返回结果，跳转页面");
        [self goToResultOrNextTest];
    }
}

//看不清事件
- (void)cannotSee:(UIButton *)sender
{
    NSLog(@"看不清 ,字体+1,切换题目");
    
    [self goToResultOrNextTest];
}

- (void)goToResultOrNextTest
{
     NSString *eyeNum = self.eyeResultDic[[NSString stringWithFormat:@"%li",fontNum]];
    
    if (self.isRight)
    {
        SensoryResultViewController *result = [[SensoryResultViewController alloc]initWithType:pageTypeNoNavigation];
        
        result.myTitle = @"视力测试报告";
        result.leftEyeNum = self.leftEyeNum;
        result.rightEyeNum = [eyeNum floatValue];
        
        [self.navigationController pushViewController:result animated:YES];
    }else
    {
        VisionTestViewController *vision = [[VisionTestViewController alloc]initWithType:pageTypeNoNavigation];
        
        vision.isRight = YES;
        vision.myTitle = @"测视力";
        vision.leftEyeNum = [eyeNum floatValue];
        
        [self.navigationController pushViewController:vision animated:YES];
    }
}

#pragma mark lazy load
- (NSDictionary *)eyeResultDic
{
    if (!_eyeResultDic) {
        
        _eyeResultDic = @{@"20":@"4.0",
                          @"18":@"4.2",
                          @"16":@"4.4",
                          @"14":@"4.6",
                          @"12":@"4.8",
                          @"10":@"5.0",
                          @"8":@"5.2"};
    }
    return _eyeResultDic;
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
