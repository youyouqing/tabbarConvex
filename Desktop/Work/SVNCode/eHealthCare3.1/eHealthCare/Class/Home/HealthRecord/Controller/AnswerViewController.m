//
//  AnswerViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/7.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AnswerViewController.h"
#import "TestResultViewController.h"

#import "AnswerViewModel.h"

#import "HomeAnswerView.h"

@interface AnswerViewController () <HomeAnswerViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HomeAnswerView *mainView;

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断是否是体质检测
    if ([self.dataDic[@"IsCorporeity"] integerValue] == 1)
    {
        [self getPhysicalTestingData];
    }else{
        [self getDataWithNetWorking];
    }
}

#pragma mark UI
- (void)createUI
{
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY);
        make.left.bottom.right.mas_equalTo(0);
    }];
}

#pragma mark NetWorking
///获取测试试题(非体质检测)401
- (void)getDataWithNetWorking
{
    NSDictionary *dic = @{@"SetCategoryId":self.dataDic[@"SetCategoryId"],
                          @"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@""
                          };
    
    [AnswerViewModel getTestQuestionWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            self.dataArray = response.Result;
            
            if (self.dataArray.count > 0)
            {
                [self createUI];
            }else
            {
                ShowSuccessStatus(response.msg);
            }
            
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

///获取体质检测测试试题
- (void)getPhysicalTestingData
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token.length>0?[UserInfoTool getLoginInfo].Token:@""};
    
    [AnswerViewModel getPhysicalTestingDataWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            self.dataArray = response.Result;
            
            if (self.dataArray.count > 0)
            {
                [self createUI];
            }else
            {
                ShowErrorStatus(response.msg);
            }
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

///获取体质检测结果
- (void)getPhysicalTestResultWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
    
    [AnswerViewModel getPhysicalTestResultWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            TestResultViewController *result = [[TestResultViewController alloc]initWithType:pageTypeNormal];
            
            result.myTitle = @"健康自测";
            result.dataDic = response.Result;
            
            [self.navigationController pushViewController:result animated:YES];
        }else
        {
            ShowErrorStatus(response.Result);
        }
    }];
    
    //展示当天任务是否完成
    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
    [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(5)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(5)} isPopView:YES];
    
}

#pragma mark Lazy load
- (HomeAnswerView *)mainView
{
    if (!_mainView) {
        _mainView = [[HomeAnswerView alloc]init];
        _mainView.delegate = self;
        if ([_dataDic[@"IsCorporeity"] integerValue] == 1)
        {
            _mainView.isCorporeity = YES;
        }
        _mainView.dataArray = [NSArray arrayWithArray:self.dataArray];
    }
    return _mainView;
}

#pragma mark HomeAnswerView Delegate
- (void)testFinish:(NSArray *)testArray
{
    ShowNormailMessage(@"正在获取测评结果...");
    //判断是否是体质检测
    if ([self.dataDic[@"IsCorporeity"] integerValue] == 1)
    {
        //上传体质检测结果
        NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                              @"MemberId":@([UserInfoTool getLoginInfo].MemberID),
                              @"Infos":testArray};
        
        [AnswerViewModel uploadPhysicalTestResultWithParams:dic FinishedBlock:^(ResponseObject *response) {
            
            DismissHud();
            if (response.code == CodeTypeSucceed)
            {
                [self getPhysicalTestResultWithNetWorking];
            }else
            {
                ShowErrorStatus(response.msg);
            }
        }];
    }else
    {
        //上传非体质检测之外的其他测试结果
        NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                              @"MemberId":@([UserInfoTool getLoginInfo].MemberID),
                              @"TestSetId":self.dataDic[@"SetCategoryId"],
                              @"Infos":testArray};
        
        [AnswerViewModel uploadTestResultWithParams:dic FinishedBlock:^(ResponseObject *response) {
            
            DismissHud();
            if (response.code == CodeTypeSucceed)
            {
                TestResultViewController *result = [[TestResultViewController alloc]initWithType:pageTypeNormal];
                
                result.myTitle = @"健康自测";
                result.dataDic = response.Result;
                
                [self.navigationController pushViewController:result animated:YES];
            }else
            {
                ShowErrorStatus(response.msg);
            }
        }];
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
