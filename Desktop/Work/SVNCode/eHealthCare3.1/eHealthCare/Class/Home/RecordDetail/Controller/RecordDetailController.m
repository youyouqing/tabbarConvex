//
//  RecordDetailController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "RecordDetailController.h"
#import "HealthPlanView.h"
#import "HomeViewModel.h"
#import "RecordDetalInfoViewController.h"

@interface RecordDetailController ()
@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
///数据源
@property (nonatomic, strong) PersonalArcModel *personalMsg;
@end

@implementation RecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"填写健康档案";
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.titleLab.textColor = kMainTitleColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"个人信息",@"病史档案",@"生活习惯"];
    [self getRecordResultWithNetWorking];
    
   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.UserMemberId) {
        self.UserMemberId(self.userMemberID);//转身刷新用户ID
    }
    
}
#pragma mark Private Methoud
- (void)addSubViewController
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,PublicY, self.view.frame.size.width, KScreenHeight - (PublicY))];
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * 3, KScreenHeight - (PublicY) - KHeight(45));// KScreenHeight - (PublicY) - KHeight(45) (246+10)*2+ KHeight(45)
    
    [self.view addSubview:scrollView];

    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = self.view.frame.size.width / 3;
    
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
   
 
    for (int i = 0; i < 3; i++)
    {
        RecordDetalInfoViewController *subVC = [[RecordDetalInfoViewController alloc]initWithType:pageTypeNoNavigation];
//        subVC.dataArray = bigArr[i];
        subVC.typeTag = i;
        subVC.userMemberID = self.userMemberID;
        subVC.personalMsg = self.personalMsg;
        [scrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
        
        subVC.view.frame = CGRectMake(0 + i * KScreenWidth,CGRectGetHeight(self.planView.frame), CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame)-CGRectGetHeight(self.planView.frame));
        
        
    }
    
    if (self.SelectTab) {
         [self.planView moveToIndex:self.SelectTab];
         [scrollView setContentOffset:CGPointMake(KScreenWidth*self.SelectTab, 0)];
    }
}
#pragma mark NetWorking
- (void)getRecordResultWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@(self.userMemberID)};
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [HealthRecordViewModel getRecordResultDataWithParams:dic FinishedBlock:^(ResponseObject *response) {
        [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.personalMsg = [PersonalArcModel mj_objectWithKeyValues:response.Result];
            
            NSLog(@"获取用户个人档案信息300%@",self.personalMsg);
            [self addSubViewController];
            [self hiddenPlaceHoldImage];
            [self.tableView reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
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
