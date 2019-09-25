//
//  PlanCompleteViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PlanCompleteViewController.h"

#import "HealthPlanViewModel.h"

#import "PlanCompleteModel.h"

@interface PlanCompleteViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIView *greenBackView;//状态背景视图
@property (nonatomic, strong) UIImageView *evaluationView;//评价反馈视图

/**计划状态情况*/
@property (nonatomic, strong) UILabel *stateLabel;//计划状态
@property (nonatomic, strong) UIProgressView *progressView;//进度条
@property (nonatomic, strong) UILabel *progressLabel;//进度百分比
@property (nonatomic, strong) UILabel *descriptionLabel;//状态评价描述

/**评价视图控件*/
@property (nonatomic, strong) UITextView *textView;//输入框
@property (nonatomic, copy) NSString *choseButtonName;//选择的按钮的选项名称

@property (nonatomic, strong) PlanCompleteModel *model;

@end

static NSInteger ChoseButtonTag = 100;

@implementation PlanCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getDataWithNetWorking];
    [self createUI];
    
    //监听键盘弹出和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)createUI
{
    self.view.backgroundColor = kLightGrayColor;
    
    [self setStateViewUI];
    [self SetPlanEvaluationUI];
    
    UIImageView *closeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plan_unfinished"]];
    
    [self.view addSubview:closeImage];
    [closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.greenBackView.mas_top).mas_offset( - KWidth(30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(60), KWidth(60)));
    }];
    
    //确定按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    confirmButton.backgroundColor = kMainColor;
    [confirmButton SetTheArcButton];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = Kfont(18);
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.evaluationView.mas_bottom).mas_offset(KHeight(32));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(270), KHeight(45)));
    }];
}

//最上面的状态视图
- (void)setStateViewUI
{
    UIView *greenBackView = [[UIView alloc]init];
    
    greenBackView.backgroundColor = kMainColor;
    greenBackView.layer.borderColor = [UIColor whiteColor].CGColor;
    [greenBackView setLayerBordWidth:0.3 AndCornerRadius:10];
    
    [self.view addSubview:greenBackView];
    self.greenBackView = greenBackView;
    [greenBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY + KHeight(35));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(300), KHeight(193)));
    }];
    
    //计划状态
    UILabel *stateLabel = [[UILabel alloc]init];
    
    stateLabel.font = Kfont(21);
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.textColor = [UIColor whiteColor];
    
    [greenBackView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(48));
        make.centerX.mas_equalTo(greenBackView.mas_centerX);
        make.height.mas_equalTo(KHeight(21));
    }];
    
    //计划进度
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    progressView.layer.borderColor = [UIColor whiteColor].CGColor;
    [progressView setLayerBordWidth:2 AndCornerRadius:8];
    progressView.tintColor = GREENCOLOR;
    progressView.trackTintColor = [UIColor whiteColor];
    
    [greenBackView addSubview:progressView];
    self.progressView = progressView;
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(stateLabel.mas_bottom).mas_offset(KHeight(16));
        make.centerX.mas_equalTo(greenBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(260), KHeight(20)));
    }];
    
    //状态进度百分比
    UILabel *progressLabel = [[UILabel alloc]init];
    
    progressLabel.font = Kfont(12);
    progressLabel.textColor = GREENCOLOR;
    progressLabel.textAlignment = NSTextAlignmentRight;
    progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progressView.progress * 100];
    
    [progressView addSubview:progressLabel];
    [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(progressView.mas_centerY);
        make.right.mas_equalTo(- KWidth(5));
        make.height.mas_equalTo(KHeight(12));
    }];
    
    //状态评价描述
    UILabel *descriptionLabel = [[UILabel alloc]init];
    
    descriptionLabel.font = Kfont(14);
    descriptionLabel.textColor = [UIColor whiteColor];
    
    [greenBackView addSubview:descriptionLabel];
    self.descriptionLabel = descriptionLabel;
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(progressView.mas_left);
        make.bottom.mas_equalTo( - KHeight(36));
        make.height.mas_equalTo(KHeight(14));
    }];
    
}

- (void)SetPlanEvaluationUI
{
    UIImageView *evaluationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plan_tipImage"]];
    
    evaluationView.contentMode = UIViewContentModeScaleToFill;
    
    evaluationView.userInteractionEnabled = YES;
    
    [self.view addSubview:evaluationView];
    self.evaluationView = evaluationView;
    [evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.greenBackView.mas_bottom).mas_offset(KHeight(6));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(300), KHeight(200)));
    }];
    
    //标题
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.font = Kfont(15);
    tipLabel.text = @"你对整体计划满意吗";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    [evaluationView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(30));
        make.centerX.mas_equalTo(evaluationView.mas_centerX);
        make.height.mas_equalTo(KHeight(15));
    }];
    
    NSArray *titleArray = @[@"满意",@"一般",@"不满"];
    for (int i = 0; i < titleArray.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:kMainColor forState:UIControlStateNormal];
        button.layer.borderColor = kMainColor.CGColor;
        button.layer.borderWidth = 0.8;
        button.titleLabel.font = Kfont(12);
        
        [button addTarget:self action:@selector(choseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = ChoseButtonTag + i;
        
        [evaluationView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(tipLabel.mas_bottom).mas_offset(KHeight(16));
            make.left.mas_equalTo(KWidth(30) + i * KWidth(74));
            make.size.mas_equalTo(CGSizeMake(KWidth(64), KHeight(27)));
        }];
        
        if (i == 1)
        {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = kMainColor;
            self.choseButtonName = titleArray[i];
        }
    }
    
    //输入框
    UITextView *textView = [[UITextView alloc]init];
    
    textView.font = Kfont(12);
    textView.text = @"你们有什么更好的意见或建议吗";
    textView.textColor = GRAYCOLOR;
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    
    [evaluationView addSubview:textView];
    self.textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(- KHeight(25));
        make.centerX.mas_equalTo(evaluationView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(250), KHeight(62)));
    }];
}

#pragma mark Action
- (void)confirmButtonAction
{
    
}

//加载数据
- (void)loadData
{
    //进度情况
    if ([NSObject isEnptyOrNil:self.model.CompletionRate])
    {
        [self.progressView setProgress:[self.model.CompletionRate floatValue] animated:YES];
        self.progressLabel.text = [NSString stringWithFormat:@"%.2f%%",[self.model.CompletionRate floatValue]];
    }
    
    
        if (self.model.PlanResult == 1)
        {
            self.stateLabel.text = @"计划已完成";
        }else
        {
            self.stateLabel.text = @"计划未完成";
        }
    
    
    self.descriptionLabel.text = self.model.ResultContent;//[NSString stringWithFormat:@"%@",];
    
    NSInteger choseButtonIndex = self.model.Satisfaction;
    
    //给选项按钮赋予结果
    if (choseButtonIndex != 0)
    {
        UIButton *button = [self.evaluationView viewWithTag:choseButtonIndex + ChoseButtonTag - 1];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = kMainColor;
        self.choseButtonName = button.titleLabel.text;
    }
    
    //意见建议
    if ([NSString isEnptyOrNil:self.model.Suggest])
    {
        self.textView.text = self.model.Suggest;
        self.textView.textColor = [UIColor blackColor];
    }
}

- (void)choseButtonAction:(UIButton *)button
{
    for (id aim in self.evaluationView.subviews)
    {
        if ([aim isKindOfClass:[UIButton class]])
        {
            UIButton *aimButton = (UIButton *)aim;
            if (aimButton.tag != button.tag)
            {
                //非点击的按钮
                [aimButton setTitleColor:kMainColor forState:UIControlStateNormal];
                aimButton.backgroundColor = [UIColor whiteColor];
            }else
            {
                //被点击的按钮
                [aimButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                aimButton.backgroundColor = kMainColor;
                self.choseButtonName = aimButton.titleLabel.text;
            }
            
        }
    }
}

#pragma mark UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        textView.text = @"你们有什么更好的意见或建议吗";
        textView.textColor = GRAYCOLOR;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.view endEditing:YES];
        [self.textView endEditing:YES];
        
        return NO;
    }

    return YES;
}

#pragma mark 监听键盘

-(void)didClickKeyboard:(NSNotification *)sender{
    
    CGFloat durition = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    CGRect keyboardRect = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    [UIView animateWithDuration:durition animations:^{
        
        //距离底部的距离
        float spaceToBottom = KScreenHeight - (self.evaluationView.frame.origin.y + self.textView.frame.origin.y + self.textView.frame.size.height);
        self.view.transform = CGAffineTransformMakeTranslation(0, - keyboardHeight + spaceToBottom - KHeight(8));
        
    }];
    
}

-(void)didKboardDisappear:(NSNotification *)sender{
    
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        
    }];
    
}

#pragma mark NetWorking
- (void)getDataWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                          @"MemResultID":self.MemResultID};
    
    [HealthPlanViewModel getPlanResultDataWithParams:dic FinishedBlock:^(ResponseObject *response) {
        
        if (response.code == CodeTypeSucceed)
        {
            self.model = [PlanCompleteModel mj_objectWithKeyValues:response.Result];
            [self loadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView endEditing:YES];
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
