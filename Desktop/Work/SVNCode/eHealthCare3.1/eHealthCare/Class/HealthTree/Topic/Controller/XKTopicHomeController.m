//
//  XKTopicHomeController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicHomeController.h"
#import "XKTopicHotChildController.h"
#import "XKHealthPlanModel.h"
#import "XKValidationAndAddScoreTools.h"
#import "HealthPlanView.h"
#import "HomeViewModel.h"
@interface XKTopicHomeController ()
{
    NSMutableArray *conArr;//控制器数组
    
    
}
@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图
@property (nonatomic,strong) NSMutableArray *topicTypeArray;
@end
@implementation XKTopicHomeController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"健康话题";
    self.topicTypeArray = [NSMutableArray arrayWithCapacity:0];
//    NSDictionary *dic = [DataSaveTool getDataFromPlistFile:healthTopicCategoryFileName];
//    if (!dic)
//    {
        [self getTopicCategoryArrayWithNetWorking];
//    }else
//    {
//        self.topicTypeArray = [dic objectForKey:healthTopicCategoryFileName];
//        [self addSubViewController];
//    }
    
    
}

#pragma mark Private Methoud
- (void)addSubViewController
{
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
     conArr = [NSMutableArray arrayWithCapacity:0];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, PublicY , KScreenWidth, KScreenHeight - (PublicY) )];
    scrollView.backgroundColor = [UIColor getColor:@"F4F4F4"];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * self.topicTypeArray.count, KScreenHeight - (PublicY));
    
    [self.view addSubview:scrollView];
    for (int i = 0; i <self.topicTypeArray.count; i++)
    {
        //将名称剥离出来
        NSDictionary *dic = [self.topicTypeArray objectAtIndex:i];
        [mArray addObject:dic[@"TypeName"]];
        
        XKTopicHotChildController *all = [[XKTopicHotChildController alloc] initWithType:pageTypeNoNavigation];
//        all.myTitle = dic[@"TypeName"];
//        all.typeArray = self.topicTypeArray;
        NSArray *arr =   [XKHealthPlanModel mj_objectArrayWithKeyValuesArray:self.topicTypeArray] ;
        NSMutableArray *tepTypeArray = [NSMutableArray arrayWithCapacity:0];
        for (XKHealthPlanModel *type in arr) {
            if (![type.TypeName isEqualToString:@"推荐"]) {
                [tepTypeArray addObject:type];
            }
        }
        if (i==0) {
            [all loadData:1 withIsFresh:YES];

        }
        all.typeArray = tepTypeArray;
        all.model = [XKHealthPlanModel mj_objectWithKeyValues:dic];
        [scrollView addSubview:all.view];
        [self addChildViewController:all];
        [conArr addObject:all];
        all.view.frame = CGRectMake(0 + i * KScreenWidth,  KHeight(45)+6, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame)- KHeight(45)-6);
        
    }
    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = KScreenWidth / 5;
//
    HealthPlanView *planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KHeight(45))];
    planView.tapAnimation = YES;
    planView.headView = headView;
    planView.titleArray = mArray;
     planView.backgroundColor = [UIColor whiteColor];
//    planView.backgroundColor = [UIColor getColor:@"F4F4F4"];
    __weak typeof (scrollView)weakScrollView = scrollView;
    [planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
        if (![scrollView isKindOfClass:[UITableView class]]) {
            
            XKTopicHotChildController *all = [conArr objectAtIndex:index];
            [all loadData:1 withIsFresh:YES];
        }
        //将两个scrollView联动起来
        [weakScrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(weakScrollView.frame), 0.0, CGRectGetWidth(weakScrollView.frame),CGRectGetHeight(weakScrollView.frame)) animated:animation];
        
    }];
    [self.view addSubview:planView];
    self.planView = planView;
}


#pragma mark NetWorking

- (void)getTopicCategoryArrayWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"TypeFlag":@(1)};
     [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HomeViewModel getTopicCategoryOrInformationCategoryOrHealthPlanCategoryWithParams:dic FinishedBlock:^(ResponseObject *response) {
          [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.topicTypeArray = response.Result;
            
            //讲数据存储到沙盒
            if (self.topicTypeArray.count > 0)
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
      
        XKTopicHotChildController *all = [conArr objectAtIndex:offset];
        [all loadData:1 withIsFresh:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
