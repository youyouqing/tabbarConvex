//
//  SensoryResultViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//柔韧度

#import "SensoryResultViewController.h"
#import "HealthTreeViewController.h"
#import "HomeViewController.h"
#import "InstructionsView.h"
#import "VisionResultView.h"
#import "ColorVisionResultView.h"
#import "FlexibilityOrFistResultView.h"

@interface SensoryResultViewController ()

///下面的白色 测评说明视图 公共页面
@property (nonatomic, strong) InstructionsView *instuctionsView;

///色觉测评的非公共UI
@property (nonatomic, strong) ColorVisionResultView *colorView;

///柔韧度测评或挥拳测评非公共UI
@property (nonatomic, strong) FlexibilityOrFistResultView *flexibilityOrFist;

@end

@implementation SensoryResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)createUI
{
    float viewHeight;//self.instuctionsView 的高度
    self.view.backgroundColor = kMainColor;
   
    
     [self.view addSubview:self.instuctionsView];
    //展示当天任务是否完成
    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
    if (self.testType == sensoryTypeVision)
    {
        
      
        [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(8)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(8)} isPopView:YES];
        viewHeight = KHeight(250);
        
        NSString *content = [NSString stringWithFormat:@"您现在是视力结果是：左眼%.1f属于%@，右眼%.1f属于%@，如果您对测试结果有所顾虑，建议您去就近的医院做相关的检查。",self.leftEyeNum,self.leftEyeNum <= 4.9 ? @"近视眼":@"正常", self.rightEyeNum, self.rightEyeNum <= 4.9 ? @"近视眼":@"正常"];
        
        [self.instuctionsView loadData:content type:sensoryTypeVision];
        
        [self loadVisionUI];
        
    }else if (self.testType == sensoryTypeColorVision)
    {
        
     
        [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(11)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(11)} isPopView:YES];
        
        viewHeight = KHeight(342);
        
        NSString *content = [NSString stringWithFormat:@"您的色觉测试结果是：%@，如果您对测试结果有所顾虑，建议您去就近的医院做相关的检查。",self.colorResult];
        [self.instuctionsView loadData:content type:sensoryTypeColorVision];
        
        [self loadColorVisionUI];
        
    }else if (self.testType == sensoryTypeFlexibility)
    {
        
       
        [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(9)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(9)} isPopView:YES];
        viewHeight = KHeight(250);
        
        NSString *contentString = @"";
        if (self.score >= 0 && self.score <= 20) {
            contentString = [NSString stringWithFormat:@"您的柔韧度检测结果为：%d分，从现在开始拉伸锻炼！",self.score];
            
        }else if (self.score > 20 && self.score <= 40){
            
            contentString = [NSString stringWithFormat:@"您的柔韧度检测结果为：%d分，身体柔韧有待提高。",self.score];
            
        }else if (self.score > 40 && self.score <= 60){
            
            contentString = [NSString stringWithFormat:@"您的柔韧度检测结果为：%d分，不错的成绩，请保持！",self.score];
            
        }else if (self.score > 60 && self.score <= 80){
            
            contentString = [NSString stringWithFormat:@"您的柔韧度检测结果为：%d分，身体柔韧度超越大部分人！",self.score];
            
        }else if (self.score > 80 && self.score <= 100){
            
            contentString = [NSString stringWithFormat:@"您的柔韧度检测结果为：%d分，惊呆了，你是个天生舞者！",self.score];

        }
        
        [self.instuctionsView loadData:contentString type:sensoryTypeFlexibility];

        [self loadFlexibilityUI];
        
    }else
    {
       
        [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(10)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(10)} isPopView:YES];
        viewHeight = KHeight(250);
        
        NSString *contentString = @"";

        if (self.score >= 0 && self.score <= 20) {
            
            contentString = [NSString stringWithFormat:@"你的挥拳测试结果为：%d分，您的身体急需锻炼！",self.score];
            
        }else if (self.score > 20 && self.score <= 40){
            
            contentString = [NSString stringWithFormat:@"你的挥拳测试结果为：%d分，身体素质有待提高。",self.score];
            
        }else if (self.score > 40 && self.score <= 60){
            
            contentString = [NSString stringWithFormat:@"你的挥拳测试结果为：%d分，不错的成绩，请保持！",self.score];
            
        }else if (self.score > 60 && self.score <= 80){
            
            contentString = [NSString stringWithFormat:@"你的挥拳测试结果为：%d分，身体素质超越大部分人！",self.score];

        }else if (self.score > 80 && self.score <= 100){
            
            contentString = [NSString stringWithFormat:@"你的挥拳测试结果为：%d分，与世界拳王媲美！",self.score];
        }
        
        [self.instuctionsView loadData:contentString type:sensoryTypeFist];
        
        [self loadFistUI];
    }
    
    ///公共UI
    [self.instuctionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(viewHeight);
        
    }];
    
     [self showTitleAndBackButtonWithoutNavigation:self.myTitle];
}

#pragma mark Private Methoud
///加载视力检测的特有UI
- (void)loadVisionUI
{
    for (int i = 0; i < 2; i++)
    {
        VisionResultView *vision = [[VisionResultView alloc]init];
        
        [self.view addSubview:vision];
        
        if (i == 0)
        {
            [vision loadData:self.leftEyeNum isRightEye:NO];
            [vision mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(16));
                make.left.mas_equalTo(KWidth(14));
                make.size.mas_equalTo(CGSizeMake(KWidth(162), KHeight(342)));
            }];
        }else
        {
            [vision loadData:self.rightEyeNum isRightEye:YES];
            [vision mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(16));
                make.right.mas_equalTo(- KWidth(14));
                make.size.mas_equalTo(CGSizeMake(KWidth(162), KHeight(342)));
            }];
        }
    }
}

///加载色觉测试UI
- (void)loadColorVisionUI
{
    [self.view addSubview:self.colorView];
    self.colorView.result = self.colorResult;
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(36), KHeight(215)));
    }];
}

///加载柔韧度UI
- (void)loadFlexibilityUI
{
    [self.view addSubview:self.flexibilityOrFist];
    self.flexibilityOrFist.viewType = viewTypeFlexibility;
    self.flexibilityOrFist.score = self.score;
    
    [self.flexibilityOrFist mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(280), KHeight(260)));
    }];
    
}

///加载挥拳测试UI
- (void)loadFistUI
{
    [self.view addSubview:self.flexibilityOrFist];
    self.flexibilityOrFist.viewType = viewTypeFist;
    self.flexibilityOrFist.score = self.score;
    
    [self.flexibilityOrFist mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(KHeight(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(280), KHeight(260)));
    }];
}

#pragma mark 重写父类方法
//返回按钮的点击时间
- (void)noNavigationBackToUpviewControllerAction
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[NoralWebViewController class]])
        {
            NoralWebViewController *test = (NoralWebViewController *)controller;
            [self.navigationController popToViewController:test animated:YES];
            break;
        }
//        if ([controller isKindOfClass:[HealthTreeViewController class]])
//        {
//            HealthTreeViewController *test = (HealthTreeViewController *)controller;
//            [self.navigationController popToViewController:test animated:YES];
//            break;
//        }
        if ([controller isKindOfClass:[HomeViewController class]])
        {
            HomeViewController *test = (HomeViewController *)controller;
            [self.navigationController popToViewController:test animated:YES];
              break;
        }
    }
}

#pragma mark Lazy load
- (InstructionsView *)instuctionsView
{
    if (!_instuctionsView) {
        _instuctionsView = [[InstructionsView alloc]init];
    }
    return _instuctionsView;
}
//色觉测试的结果
- (ColorVisionResultView *)colorView
{
    if (!_colorView) {
        _colorView = [[ColorVisionResultView alloc]init];
    }
    return _colorView;
}

- (FlexibilityOrFistResultView *)flexibilityOrFist
{
    if (!_flexibilityOrFist) {
        _flexibilityOrFist = [[FlexibilityOrFistResultView alloc]initWithSize:CGSizeMake(KWidth(280), KHeight(260))];
    }
    return _flexibilityOrFist;
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
