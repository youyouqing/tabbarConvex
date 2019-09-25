//
//  SportSubViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportSubViewController.h"
#import "XKHomeAcountView.h"
#import "BaiduMap_SportViewController.h"
#import "SportMapViewController.h"
@interface SportSubViewController ()
@property(nonatomic,strong)UIButton *beginButton;
@property (nonatomic,strong) UILabel *totalLabel;
/**
 计步表格试图
 */
@property (nonatomic,strong) UITableView *acountTable;
/**
 计步子视图
 */
@property (nonatomic,strong) XKHomeAcountView *acountHeadView;



@end

@implementation SportSubViewController

/**
 计步功能视图的懒加载
 */
-(UITableView *)acountTable{
    
    if (!_acountTable) {
        _acountTable = [[UITableView alloc] init];
        _acountTable.left = 0;
        _acountTable.top = self.view.frame.origin.y;
        _acountTable.width = KScreenWidth;
        _acountTable.height =  self.view.frame.size.height;
        _acountTable.showsVerticalScrollIndicator = NO;
        _acountTable.showsHorizontalScrollIndicator = NO;
        _acountTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _acountTable.scrollEnabled = NO;
    }
    
    return _acountTable;
}
/**
 计步子视图懒加载
 */
-(XKHomeAcountView *)acountHeadView{
    
    if (!_acountHeadView) {
        _acountHeadView = [[[NSBundle mainBundle] loadNibNamed:@"XKHomeAcountView" owner:self options:nil] firstObject];
        _acountHeadView.left = 0;
        _acountHeadView.top = 0;
        _acountHeadView.delegate = self;
        _acountHeadView.width = KScreenWidth;
        _acountHeadView.height =  KScreenHeight-(PublicY)-KHeight(45);
        _acountHeadView.backgroundColor = kbackGroundColor;
    }
    return _acountHeadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kbackGroundColor;
  
    if (self.type == 1) {
        [self.view addSubview:self.acountTable];
        self.acountHeadView.model = self.SportsHomeModel;
        self.acountTable.tableHeaderView = self.acountHeadView;
        self.acountTable.backgroundColor = kbackGroundGrayColor;
    }
    else
    {
        UILabel *showLabel = [[UILabel alloc] init];
        [showLabel setNumberOfLines:0];
      if (self.type ==2) {
            
            showLabel.text = @"跑步总公里 (公里)";
        }
        else if (self.type ==3) {
            
            showLabel.text = @"登山总公里 (公里)";
        }
        else if (self.type ==4) {
            
            showLabel.text = @"骑行总公里 (公里)";
        }
        
        showLabel.textColor = kMainTitleColor;
        showLabel.font = [UIFont systemFontOfSize:17];
        showLabel.textAlignment= NSTextAlignmentCenter;
        [showLabel sizeToFit];
        showLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:showLabel];
        [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(96);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            //make.bottom.mas_equalTo(btn.mas_top).offset(-30);
        }];
        self.totalLabel = [[UILabel alloc] init];
        self.totalLabel.text = [NSString stringWithFormat:@"%.2f",self.homeModel.KilometerCount];
        self.totalLabel.textColor = kMainTitleColor;
        self.totalLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:80];
        self.totalLabel.textAlignment= NSTextAlignmentCenter;
        [self.totalLabel sizeToFit];
        [self.view addSubview:self.totalLabel];
        [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //        make.top.mas_equalTo(showLabel.mas_bottom).offset(-80);
            make.top.mas_equalTo(showLabel.mas_bottom).mas_offset(KHeight(80));
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            // make.bottom.mas_equalTo(btn.mas_top).offset(-30);
        }];
        //beginbutton
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_go"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        //self.beginButton = btn;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(120);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.bottom.mas_equalTo(-KHeight(42));
        }];
    }
    
    //label warning
    UIImageView *bgImage = [[UIImageView alloc] init];
    if (self.type == 3) {
        bgImage.image = [UIImage imageNamed:@"bg_climb"];
    }else
    bgImage.image = [UIImage imageNamed:@"bg_run"];//bg_run bg_climb
    [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}
-(void)buttonClick:(UIButton *)btn
{
    SportMapViewController *sport = [[SportMapViewController alloc]initWithType:pageTypeNormal];
    [SportCommonMod shareInstance].Type = self.type;
    [SportCommonMod shareInstance].totalDistance = 10;
    [SportCommonMod shareInstance].totalTime = 120;
    [self.navigationController pushViewController:sport animated:YES];
    
    
}
-(void)setHomeModel:(XKSportsTypeModel *)homeModel
{
    _homeModel = homeModel;
    
    self.totalLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:homeModel.KilometerCount]];

}
/**获取今日记步信息*/
-(void)sendStepMesage:(StepModel *)step{
    WEAKSELF;
    if(weakSelf.backStepBlock)
    {
        NSLog(@"查询有2----%li", step.StepCount);
        weakSelf.backStepBlock(step);
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
