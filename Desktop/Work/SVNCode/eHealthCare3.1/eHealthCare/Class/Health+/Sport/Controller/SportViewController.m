//
//  SportViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportViewController.h"
#import "CountDownViewController.h"
#import "HealthPlanView.h"
#import "SportSubViewController.h"
#import "HomeViewModel.h"
#import "SportViewModel.h"
#import "XKSportsHomeModel.h"
@interface SportViewController ()
@property (nonatomic, strong) HealthPlanView *planView;///顶部滚动视图
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong) XKSportsHomeModel *homeModel;

@property (nonatomic, assign) NSInteger type;
/**保留记步信息实体*/
@property (nonatomic,strong)StepModel *step;
@end
//沙盒存储所用 同时也是从沙盒取出的dic的key value是我们需要的数据
static NSString *healthPlanCategoryFileName = @"healthPlanCategory.plist";
@implementation SportViewController
#pragma mark Private Methoud
- (void)addSubViewController
{
//    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,PublicY, self.view.frame.size.width, KScreenHeight - (PublicY))];
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * 4,KScreenHeight - (PublicY));
    [self.view addSubview:scrollView];
    for (int i = 0; i < 4 ; i++)//self.homeModel.modelList.count
    {
        //分类子模块嵌入
        SportSubViewController *subVC = [[SportSubViewController alloc]initWithType:pageTypeNoNavigation];
        for (XKSportsTypeModel *stype in self.homeModel.modelList) {
            if (stype.PatternType == i+1) {
               subVC.homeModel = stype;//（1步数2跑步、骑行）
                break;
            }
        }
        subVC.type = i+1;
        subVC.SportsHomeModel = self.homeModel;
        NSLog(@"subVC.homeModel----%@",subVC.homeModel);
        [scrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
        
        subVC.view.frame = CGRectMake(0 + i * KScreenWidth,KHeight(45), CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame)-KHeight(45));
        subVC.backStepBlock = ^(StepModel *stepM) {
            self.step = stepM;
            
            NSLog(@"查询有3----%li", self.step.StepCount);
        };
    }
    
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth = self.view.frame.size.width / 4;
    
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

}

#pragma mark NetWorking

- (void)getHealthSportCategoryArray
{
   
    self.homeModel = [[XKSportsHomeModel alloc]init];
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [SportViewModel loadSprotMessageWithParams:dic FinishedBlock:^(ResponseObject *response) {
        [[XKLoadingView shareLoadingView] hideLoding];
        NSLog(@"340-----%@",response.Result);
        if (response.code == CodeTypeSucceed) {
            
            self.homeModel = [XKSportsHomeModel mj_objectWithKeyValues:response.Result];
            
//            if (!self.acountHeadView.model) {//判断是否要给记步数据赋值
//                self.acountHeadView.model = self.homeModel;
//            }
            //            self.runHeadView.model = self.homeModel;
            //            self.rideHeadView.model = self.homeModel;
            XKSportsTypeModel *stype1 = [[XKSportsTypeModel alloc]init];
            for (XKSportsTypeModel *stype in self.homeModel.modelList) {
                if (stype.PatternType == 1) {
                    stype1 = stype;
                }
            }
            if (self.step.StepCount>=3000||stype1.StepCount>=3000) {
                //展示当天任务是否完成
                XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
                
                NSDictionary *validationDic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                                                @"TaskType":@(1),
                                                @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                                                @"TypeID":@(7)};
                
                NSDictionary *scoreDic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                                           @"TaskType":@(1),
                                           @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                                           @"TypeID":@(7)};
                
                [tools validationAndAddScore:validationDic withAdd:scoreDic isPopView:YES];
            }
            
            
            [self addSubViewController];
            [self hiddenPlaceHoldImage];
        }else{
            
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
    self.type = offset+1 ;
    if (self.type == 1) {
        self.rightBtn.hidden = NO;
    }else
        self.rightBtn.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView endMoveToIndex:offset];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.rightBtn.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   
    if (self.type == 1) {
        self.rightBtn.hidden = NO;
    }else
        self.rightBtn.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.type = 1;
    self.dataArray = @[@"行走",@"跑步",@"登山",@"骑行"];
    self.view.backgroundColor= [UIColor whiteColor];
    self.myTitle = @"运动";
    self.view.frame = [UIScreen mainScreen].bounds;
    self.headerView.backgroundColor= [UIColor whiteColor];
    self.titleLab.textColor = kMainTitleColor;
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];

    [self.rightBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionSharde) forControlEvents:UIControlEventTouchUpInside];

    
    NSLog(@"查询有4----%li", self.step.StepCount);
    
    
    [self getHealthSportCategoryArray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonClick:(id)sender {

    
}

#pragma mark action
//分享按钮的点击事件
-(void)ActionSharde{
    
    XKSpShareViewController *share = [[XKSpShareViewController alloc] initWithType:pageTypeNoNavigation];

//    if (self.step.StepCount == 0) {//判断今日步数为零  不让进入分享
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"今日还没运动！" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:nil];
//        return;
//    }

    share.spStyle =  self.type;
    if (self.type == 1) {
        share.step = self.step;
    }else
        share.step = nil;
    for (XKSportsTypeModel *type in self.homeModel.modelList) {
        if (type.PatternType == self.type) {
            share.StepManageID = type.StepManageID;
            share.spStyle =  self.type;
            [self.navigationController pushViewController:share animated:YES];
            break;
        }
    }
  
    NSLog(@"StepManageID---%d",share.StepManageID);
  

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