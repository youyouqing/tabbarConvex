//
//  ReadyTestViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/8/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "ReadyTestViewController.h"
#import "AnswerViewController.h"

@interface ReadyTestViewController ()

@end

@implementation ReadyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTitle = @"健康自测";
    [self createUI];
    
    
    //展示当天任务是否完成
    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
    [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(5)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(5)} isPopView:YES];
}

#pragma mark UI
- (void)createUI
{
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.font = Kfont(30);
    titleLabel.text = self.dataDic[@"SetCategoryName"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(PublicY + KHeight(35));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(KHeight(36));
    }];
    
    
    UILabel *contentLabel = [[UILabel alloc]init];
    
    contentLabel.font = Kfont(15);
    contentLabel.text = [NSString stringWithFormat:@"\t\t\t\t%@",self.dataDic[@"SetContent"]];//SetContent
    contentLabel.textColor = GRAYCOLOR;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:contentLabel];
    
    CGSize maxContentSize = CGSizeMake(KWidth(320), CGFLOAT_MAX);
    CGSize expectContentSize = [contentLabel sizeThatFits:maxContentSize];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(KHeight(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(320), expectContentSize.height));
    }];
    
    
    UIImageView *bigImage = [[UIImageView alloc]init];
    
    bigImage.contentMode = UIViewContentModeScaleAspectFit;
    [bigImage sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"SetImgUrl"]] placeholderImage:KPlaceHoldImage];
    
    [self.view addSubview:bigImage];
    
    [bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(contentLabel.mas_bottom).mas_equalTo(KHeight(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(315), KHeight(150)));
    }];
    
    
    UIButton *admitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [admitButton setTitle:@"开始答题" forState:UIControlStateNormal];
    [admitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    admitButton.backgroundColor = kMainColor;
    
    [admitButton addTarget:self action:@selector(goToTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:admitButton];
    
    [admitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(bigImage.mas_bottom).mas_equalTo(KHeight(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(275), KHeight(45)));
    }];
    
    [admitButton SetTheArcButton];
}

#pragma mark Action
- (void)goToTest
{
    AnswerViewController *answer = [[AnswerViewController alloc]initWithType:pageTypeNormal];
    
    answer.myTitle = [NSString stringWithFormat:@"%@测评",self.dataDic[@"SetCategoryName"]];
    answer.dataDic = self.dataDic;
    
    [self.navigationController pushViewController:answer animated:YES];
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