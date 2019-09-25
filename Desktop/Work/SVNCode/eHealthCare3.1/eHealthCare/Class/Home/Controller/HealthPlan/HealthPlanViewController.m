//
//  HealthPlanViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthPlanViewController.h"
#import "HealthPlanSubViewController.h"
#import "MyHealthPlanViewController.h"

#import "HomeViewModel.h"
#import "HealthPlanViewModel.h"

#import "HealthPlanView.h"

//沙盒存储所用 同时也是从沙盒取出的dic的key value是我们需要的数据
static NSString *healthPlanCategoryFileName = @"healthPlanCategory.plist";

@interface HealthPlanViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图

@end

@implementation HealthPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dic = [DataSaveTool getDataFromPlistFile:healthPlanCategoryFileName];
    if (!dic)
    {
        [self getHealthPlanCategoryArrayWithNetWorking];
    }else
    {
        self.dataArray = [dic objectForKey:healthPlanCategoryFileName];
        [self addSubViewController];
    }
    [self createUI];
}

- (void)createUI
{
    [self.rightBtn setTitle:@"我的计划" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;
    [self.rightBtn addTarget:self action:@selector(checkMyPlan) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Action
- (void)checkMyPlan
{
    MyHealthPlanViewController *my = [[MyHealthPlanViewController alloc]initWithType:pageTypeNormal];
    
    my.myTitle = @"我的计划";
    
    [self.navigationController pushViewController:my animated:YES];
}

#pragma mark Private Methoud
- (void)addSubViewController
{
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, PublicY + KHeight(45), KScreenWidth, KScreenHeight - (PublicY) - KHeight(45))];

    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * self.dataArray.count, KScreenHeight - (PublicY) - KHeight(45));
    
    [self.view addSubview:scrollView];
    for (int i = 0; i < self.dataArray.count; i++)
    {
        //将名称剥离出来
        NSDictionary *dic = [self.dataArray objectAtIndex:i];
        [mArray addObject:dic[@"TypeName"]];
        
        //分类子模块嵌入
        HealthPlanSubViewController *subVC = [[HealthPlanSubViewController alloc]initWithType:pageTypeNoNavigation];

        subVC.PlanTypeID = dic[@"TypeID"];

        [scrollView addSubview:subVC.view];
        [self addChildViewController:subVC];

        subVC.view.frame = CGRectMake(0 + i * KScreenWidth, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
    }
    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = KScreenWidth / 5;
    
    HealthPlanView *planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KHeight(45))];
    planView.tapAnimation = YES;
    planView.headView = headView;
    planView.titleArray = mArray;
    
    __weak typeof (scrollView)weakScrollView = scrollView;
    [planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
        
        //将两个scrollView联动起来
        [weakScrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(weakScrollView.frame), 0.0, CGRectGetWidth(weakScrollView.frame),CGRectGetHeight(weakScrollView.frame)) animated:animation];
        
    }];
    [self.view addSubview:planView];
    self.planView = planView;
}


#pragma mark NetWorking

- (void)getHealthPlanCategoryArrayWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"TypeFlag":@(3)};
    
    [HomeViewModel getTopicCategoryOrInformationCategoryOrHealthPlanCategoryWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed) {
            
            self.dataArray = response.Result;
            
            //讲数据存储到沙盒
            if (self.dataArray.count > 0)
            {
                NSDictionary *dic = @{healthPlanCategoryFileName:response.Result};
                [DataSaveTool saveDataAtPlistFile:healthPlanCategoryFileName dataDic:dic];
                
                [self addSubViewController];
                [self hiddenPlaceHoldImage];
            }else
            {
                [self showPlaceHoldImageAtCenterOfViewController:healthPlanNoDataImage];
            }
            
        }else
        {
            [self showPlaceHoldImageAtCenterOfViewController:healthPlanNoDataImage];
        }
    }];
}

#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView moveToIndex:offset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView endMoveToIndex:offset];
    
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
