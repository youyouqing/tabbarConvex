//
//  XKSportDestinationController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "XKSportDestinationController.h"
#import "HealthPlanView.h"
#import "XKSportDestinaDetailController.h"
#import "SportDestinaMod.h"
@interface XKSportDestinationController ()
@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation XKSportDestinationController

- (void)addSubViewController
{
    //    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,PublicY, self.view.frame.size.width, KScreenHeight - (PublicY))];
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * self.dataArray.count, KScreenHeight - (PublicY) - KHeight(45));// (246+10)*2+ KHeight(45)
    
    [self.view addSubview:scrollView];

    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = self.view.frame.size.width / (self.dataArray.count);
    
    HealthPlanView *planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, PublicY, self.view.frame.size.width, KHeight(45))];
    planView.tapAnimation = YES;
    planView.headView = headView;
    planView.titleArray = self.dataArray;
    
    __weak typeof (scrollView)weakScrollView = scrollView;
    [planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
        
        //将两个scrollView联动起来
        [weakScrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(weakScrollView.frame), 0.0, CGRectGetWidth(weakScrollView.frame),CGRectGetHeight(weakScrollView.frame)) animated:animation];
        
    }];
    [self.view addSubview:planView];
    self.planView = planView;
    
     NSArray *distanceArr = @[@"0.5",@"1",@"2",@"3",@"5",@"10",@"自定义"];
     NSArray *destinaArr = @[@"10",@"20",@"30",@"60",@"120",@"180",@"自定义"];
    NSArray *dataBigArr = @[distanceArr,destinaArr];
    for (int i = 0; i < self.dataArray.count ; i++)//self.homeModel.modelList.count
    {
        XKSportDestinaDetailController *subVC = [[XKSportDestinaDetailController alloc]initWithType:pageTypeNoNavigation];
        //         subVC.myTitle = @"目标";
        subVC.DType = i+1;
        subVC.dataDestinaArray = dataBigArr[i];
        [scrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
        
        subVC.view.frame = CGRectMake(0 + i * KScreenWidth,CGRectGetHeight(self.planView.frame), CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame)-CGRectGetHeight(self.planView.frame));
        
        
        
    }
}

#pragma mark NetWorking

- (void)getHealthSportCategoryArray
{
    self.dataArray = @[@"距离",@"时间"];
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
//    [[XKLoadingView shareLoadingView]showLoadingText:nil];
//    [SportViewModel loadSprotMessageWithParams:dic FinishedBlock:^(ResponseObject *response) {
//        [[XKLoadingView shareLoadingView] hideLoding];
//        if (response.code == CodeTypeSucceed) {
//
//            self.homeModel = response.Result[@"Result"];
            [self addSubViewController];
            [self hiddenPlaceHoldImage];
//        }else{
//
//            ShowErrorStatus(response.msg);
//        }
//    }];
    
    
}

#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        [self.planView moveToIndex:offset];
    }
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView endMoveToIndex:offset];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.myTitle = @"目标";
     self.view.backgroundColor= [UIColor whiteColor];
    [self getHealthSportCategoryArray];
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
