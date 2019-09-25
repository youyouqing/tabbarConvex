//
//  XKInfomationViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInfomationViewController.h"
#import "XKInfomationChildController.h"
#import "XKHealthPlanModel.h"
#import "XKValidationAndAddScoreTools.h"
#import "HealthPlanView.h"
#import "HomeViewModel.h"
@interface XKInfomationViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *conArr;//控制器数组
    
    
}
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图

@end
static NSString *healthPlanCategoryFileName = @"healthInformationCategory.plist";

@implementation XKInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"健康资讯";
    [self getHealthPlanCategoryArrayWithNetWorking];

   
}

#pragma mark Private Methoud
- (void)addSubViewController
{
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
    conArr = [NSMutableArray arrayWithCapacity:0];

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight - (PublicY))];
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * self.dataArray.count, KScreenHeight - (PublicY) - KHeight(45));
    
    [self.view addSubview:scrollView];
    for (int i = 0; i < self.dataArray.count; i++)
    {
        //将名称剥离出来
        NSDictionary *dic = [self.dataArray objectAtIndex:i];
        [mArray addObject:dic[@"TypeName"]];
        
        XKInfomationChildController *all = [[XKInfomationChildController alloc] initWithType:pageTypeNormal];
        all.myTitle = dic[@"TypeName"];
        all.model = [XKHealthPlanModel mj_objectWithKeyValues:dic];
        [scrollView addSubview:all.view];
        [self addChildViewController:all];
        all.view.frame = CGRectMake(0 + i * KScreenWidth, KHeight(45), CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame)-KHeight(45));
         [conArr addObject:all];
    }
    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = KScreenWidth / 5;
    
    HealthPlanView *planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KHeight(45))];
    planView.tapAnimation = YES;
    planView.headView = headView;
    planView.titleArray = mArray;
    planView.backgroundColor = [UIColor whiteColor];
    __weak typeof (scrollView)weakScrollView = scrollView;
    [planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
        if (![scrollView isKindOfClass:[UITableView class]]) {
            
            XKInfomationChildController *all = [conArr objectAtIndex:index];
            [all loadData:1 withIsFresh:YES];
        }
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
                          @"TypeFlag":@(2)};
     [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HomeViewModel getTopicCategoryOrInformationCategoryOrHealthPlanCategoryWithParams:dic FinishedBlock:^(ResponseObject *response) {
          [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.dataArray = response.Result;
            
            //讲数据存储到沙盒
            if (self.dataArray.count > 0)
            {
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
    if (![scrollView isKindOfClass:[UITableView class]]) {
        
        XKInfomationChildController *all = [conArr objectAtIndex:offset];
        [all loadData:1 withIsFresh:YES];
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
