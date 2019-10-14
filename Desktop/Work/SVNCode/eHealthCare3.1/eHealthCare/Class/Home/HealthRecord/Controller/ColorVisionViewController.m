//
//  ColorVisionViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//色觉测试

#import "ColorVisionViewController.h"
#import "SensoryResultViewController.h"

@interface ColorVisionViewController ()

@property (nonatomic, strong) UIImageView *testImage;

///存放测试图片的数组
@property (nonatomic, strong) NSArray *testImageArray;

///选项A
@property (nonatomic, strong) UIButton *buttonA;

///选项B
@property (nonatomic, strong) UIButton *buttonB;

///标记选用了哪套试题
@property (nonatomic, assign) int indexTest;

///题号 (第几题)
@property (nonatomic, assign) int indexQuestion;

///旧工程里面引入的两个用来做结果判断的两个参数，思路很不错
@property (nonatomic,assign)NSInteger firstResultNum,secondeResultNum;

@end

@interface ColorVisionViewController ()

@end

static int ButtonTag = 100;

@implementation ColorVisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.indexQuestion = 0;
    
    [self createUI];
    [self RandomGeneratingTest];
}

#pragma mark UI
- (void)createUI
{
    self.view.backgroundColor =  kMainColor;
    [self showTitleAndBackButtonWithoutNavigation:self.myTitle];
    
    UIImageView *testImage = [[UIImageView alloc]init];
    
    testImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:testImage];
    self.testImage = testImage;
    
    [testImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(70));
        make.left.mas_equalTo(KWidth(30));
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(60), KHeight(200)));
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.font = Kfont(14);
    tipLabel.text = @"请在3秒内做出选择，以便达到做好的测试效果，建议最多不超过10秒。";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.numberOfLines = 0;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self.view addSubview:tipLabel];
    
    CGSize maxTipSize = CGSizeMake(KWidth(265), CGFLOAT_MAX);
    CGSize expectTipSize = [tipLabel sizeThatFits:maxTipSize];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(testImage.mas_bottom).mas_offset(KHeight(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(265), expectTipSize.height));
        
        
        
    }];
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i == 2)
        {
            [button setTitle:@"不能读" forState:UIControlStateNormal];
        }
        
        if (i == 0)
        {
            self.buttonA = button;
        }
        
        if (i == 1)
        {
            self.buttonB = button;
        }
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(choseTheAnswer:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = ButtonTag + i;
        
        [self.view addSubview:button];
        [button setCircularControl:KWidth(68)];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(tipLabel.mas_bottom).mas_offset(KHeight(40));
            make.left.mas_equalTo(KWidth(30) + i * KWidth(123.5));
            make.size.mas_equalTo(CGSizeMake(KWidth(68), KWidth(68)));
        }];
    }
}

#pragma Private Method
///随机生成试题
- (void)RandomGeneratingTest
{
    NSArray *arr1 = @[@"88",@"286",@"291",@"816"];
    
    NSArray *arr2 = @[@"286",@"816",@"88",@"291"];
    
    NSArray *arr3 = @[@"291",@"88",@"286",@"816"];
    
    NSArray *arr4 = @[@"816",@"286",@"circalAndShape",@"circals"];
    
    NSArray *maxArray = @[arr1,arr2,arr3,arr4];
    
    int x = arc4random() % 4;
    
    self.testImageArray = maxArray[x];
    self.indexTest = x;
    
    [self showPhotoAndAnswer];
}

/**定义方法显示图片和答案**/
-(void)showPhotoAndAnswer
{
    self.testImage.image = [UIImage imageNamed:self.testImageArray[self.indexQuestion]];
    
    //拿到错误的答案
    NSInteger errA = [self randomErrorAswer];
    
    //拿到错误答案该显示的位置
    NSInteger location = [self desErrorAswer];
    
    if (self.indexTest == 3 && self.indexQuestion == 2) {
        
        if (location == 1) {//判断位置之后显示在对应的位置上去
            
            [self.buttonA setTitle:@"Ο" forState:UIControlStateNormal];
            [self.buttonB setTitle:@"ΔΟΔ" forState:UIControlStateNormal];
            
        }else{
            
            [self.buttonA setTitle:@"ΔΟΔ" forState:UIControlStateNormal];
            [self.buttonB setTitle:@"Ο" forState:UIControlStateNormal];
            
            
        }
        
        return;
        
    }
    
    if (self.indexTest == 3 && self.indexQuestion == 3) {
        
        if (location == 1) {//判断位置之后显示在对应的位置上去
            
            [self.buttonA setTitle:@"ΔΟΔ" forState:UIControlStateNormal];
            [self.buttonB setTitle:@"Ο" forState:UIControlStateNormal];
            
        }else{
            
            [self.buttonA setTitle:@"Ο" forState:UIControlStateNormal];
            [self.buttonB setTitle:@"ΔΟΔ" forState:UIControlStateNormal];
            
        }
        
        return;
        
    }
    
    if (location == 1) {//判断位置之后显示在对应的位置上去
        
        [self.buttonA setTitle:[NSString stringWithFormat:@"%li",errA] forState:UIControlStateNormal];
        [self.buttonB setTitle:self.testImageArray[self.indexQuestion] forState:UIControlStateNormal];
        
    }else{
        
        [self.buttonA setTitle:self.testImageArray[self.indexQuestion] forState:UIControlStateNormal];
        [self.buttonB setTitle:[NSString stringWithFormat:@"%li",errA] forState:UIControlStateNormal];
        
    }
    
}

/**定义方法返回错误的答案**/
-(NSInteger)randomErrorAswer{
    
    NSInteger err=arc4random()%1000;
    
    
    return err;
    
}

/**定义方法表示生成的错误答案放置的顺序**/
-(NSInteger)desErrorAswer{
    
    NSInteger index=arc4random()%2;
    
    return index+1;
    
}


- (void)ResultsTheJudgment:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:self.testImageArray[self.indexQuestion]]) {//答案正确
        
        NSLog(@"答案正确");
        
        if (self.indexQuestion == 0) {//第一次
            
            self.firstResultNum=1;
            
        }
        
        if (self.indexQuestion == 1) {//第二次
            
            self.secondeResultNum =1;
        }
        
    }else
    {
        NSLog(@"答案错误");
        
        if (self.indexQuestion == 0) {//第一次
            
            self.firstResultNum = -1;
            
        }
        
        if (self.indexQuestion == 1) {//第二次
            
            self.secondeResultNum = -1;
            
        }
         NSLog(@"答案111错误");
    }
    NSLog(@"答案2222错误");
    [self secondJudgement];
}

//选择了错误答案或者是选择看不清
- (void)choseTheWrongAnswer
{

    if (self.indexQuestion == 0) {//第一次
        
        self.firstResultNum = -1;
        
    }
    
    if (self.indexQuestion == 1) {//第二次
        
        self.secondeResultNum = -1;
        
    }
    [self secondJudgement];
}

///判断之后的后续处理
- (void)secondJudgement
{
    if (self.indexQuestion == 1) {
        
        NSInteger result = self.firstResultNum * self.secondeResultNum;
        
        if (result == 1) {//判断前两次结果是否为1
            
            NSInteger onceResult = result + (self.firstResultNum + self.secondeResultNum);
            
            if (onceResult > 0) {
                
                [self goToTheResult:@"正常"];
                return;
                
            }
            
            if (onceResult < 0) {
                NSLog(@"---先天性色盲--");
                [self goToTheResult:@"先天性色盲"];
                return;
                
            }
            
        }
        
    }
    
    if (self.indexQuestion == 3) {
         NSLog(@"---色弱--");
        [self goToTheResult:@"色弱"];
        
        return;
    }
    
    self.indexQuestion++;
    [self showPhotoAndAnswer];
}

///去结果
- (void)goToTheResult:(NSString *)resultString
{
    SensoryResultViewController *result = [[SensoryResultViewController alloc]initWithType:pageTypeNoNavigation];
    
    result.myTitle = @"色觉测试报告";
    result.colorResult = resultString;
    result.testType = sensoryTypeColorVision;
    
    [self.navigationController pushViewController:result animated:YES];
}


#pragma mark Action
- (void)choseTheAnswer:(UIButton *)button
{
    if (button.tag - ButtonTag < 2)
    {
        [self ResultsTheJudgment:button];
    }else
    {
        [self choseTheWrongAnswer];
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