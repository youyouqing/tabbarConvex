//
//  TodayPlanDeatilView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TodayPlanDetailHeadView.h"

#import "PlanDirectoryView.h"

@interface TodayPlanDetailHeadView ()

@property (nonatomic, strong) UILabel *tipLabel;//提示label

@end

@implementation TodayPlanDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = Kfont(23);
    
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(KHeight(20));
    }];
    
    UIButton *planButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    planButton.backgroundColor = kMainColor;
    planButton.frame = CGRectMake(KScreenWidth - KWidth(74), KHeight(30), KWidth(74), KHeight(30));
    [planButton setTitle:@"计划目录" forState:UIControlStateNormal];
    [planButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    planButton.titleLabel.font = Kfont(15);
    [planButton addTarget:self action:@selector(popPlanDirectory) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:planButton];
    
    //绘制左边圆形右边矩形
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:planButton.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(planButton.frame.size.height / 2,planButton.frame.size.height / 2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = planButton.bounds;
    maskLayer.path = maskPath.CGPath;
    planButton.layer.mask = maskLayer;
}

#pragma mark Action
- (void)popPlanDirectory
{
    if (self.popBlock) {
        self.popBlock();
    }
}

#pragma mark Setter
- (void)setIndexOfPlanDay:(NSString *)indexOfPlanDay
{
    _indexOfPlanDay = indexOfPlanDay;
    _tipLabel.text = indexOfPlanDay;
}

@end