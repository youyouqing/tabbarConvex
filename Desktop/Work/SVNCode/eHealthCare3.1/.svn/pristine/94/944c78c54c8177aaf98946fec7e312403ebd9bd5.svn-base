//
//  TodayPlanDetailView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TodayPlanDetailView.h"

@interface TodayPlanDetailView ()

@property (nonatomic, strong) UIView *lineView;//暗绿色竖线
@property (nonatomic, strong) UILabel *tipLabel;//mark 第几天
@property (nonatomic, strong) UILabel *contentLabel;//内容
@property (nonatomic, strong) UIView *HorizontalLineView;//水平横线
@property (nonatomic, strong) UIImageView *ballImage;//绿色的球

@end

@implementation TodayPlanDetailView

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
    UIImageView *ballImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"darkGreenBallImage"]];
    
    [self addSubview:ballImage];
    self.ballImage = ballImage;
    
    [ballImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(20));
        make.left.mas_equalTo(KWidth(20));
        make.size.mas_equalTo(CGSizeMake(KWidth(12), KWidth(12)));
    }];
    
    //竖线
    UIView *lineView = [[UIView alloc]init];
    
    lineView.backgroundColor = kMainColor;
    
    [self addSubview:lineView];
    self.lineView = lineView;
    
    //第几天
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.font = [UIFont systemFontOfSize:KWidth(16) weight:UIFontWeightBold];
    
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(ballImage.mas_right).mas_offset(KWidth(20));
        make.centerY.mas_equalTo(ballImage.mas_centerY);
        make.height.mas_equalTo(KHeight(16));
    }];
    
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    
    contentLabel.font = Kfont(14);
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //分割线
    UIView *HorizontalLineView = [[UIView alloc]init];
    
    HorizontalLineView.backgroundColor = kSeperateLineColor;
    
    [self addSubview:HorizontalLineView];
    self.HorizontalLineView = HorizontalLineView;
    
}

- (void)loadDataAndSetConstraint
{
    NSDictionary *dic = [self.dataArray firstObject];
    self.tipLabel.text = dic[@"PlanDetailTitle"];
    self.contentLabel.text = dic[@"PlanDetailContent"];
    
    CGSize maxContentSize = CGSizeMake(KWidth(245), CGFLOAT_MAX);
    CGSize expectContentSize = [self.contentLabel sizeThatFits:maxContentSize];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset(KHeight(18));
        make.left.mas_equalTo(self.tipLabel.mas_left);
        make.size.mas_equalTo(expectContentSize);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.ballImage.mas_top);
        make.centerX.mas_equalTo(self.ballImage.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1, expectContentSize.height + KHeight(45)));
    }];
    
    [self.HorizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.contentLabel.mas_left);
        make.bottom.mas_equalTo(self.lineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(45), 1));
    }];
    
    if (self.heightBlock) {
        
        self.heightBlock(KHeight(64) + expectContentSize.height);
    }
}

#pragma mark Setter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self loadDataAndSetConstraint];
}
@end
