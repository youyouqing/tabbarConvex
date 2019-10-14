//
//  HealthPlanCell.m
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthPlanCell.h"

@interface HealthPlanCell ()

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *describeLabel;

/**我的计划特有*/
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *medalImage;//完成才会显示 金牌图标

@end

@implementation HealthPlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    //对cell边框绘制
    [self setLayerBordWidth:0.3f AndCornerRadius:6];
    self.layer.borderColor = COLOR(231,231,231, 1).CGColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *photoView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    
    [photoView setCircularControl:KWidth(65)];
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.layer.borderColor = [UIColor whiteColor].CGColor;
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(KWidth(20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(65), KWidth(65)));
    }];
    
    UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    joinButton.titleLabel.font = Kfont(16);
    [joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinButton SetTheArcButton];
    joinButton.layer.borderColor = [UIColor whiteColor].CGColor;
    joinButton.backgroundColor = kMainColor;
    
    [self.contentView addSubview:joinButton];
    self.joinButton = joinButton;
    
    [joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(- KWidth(8));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(85), KHeight(32)));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.font = Kfont(16);

    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(20));
        make.left.mas_equalTo(photoView.mas_right).mas_offset(KWidth(20));
        make.right.mas_equalTo(joinButton.mas_left).mas_offset( - KWidth(15));
        make.height.mas_equalTo(KHeight(16));
    }];
    
    UILabel *describeLabel = [[UILabel alloc]init];
    
    describeLabel.font = Kfont(14);
    describeLabel.textColor = GRAYCOLOR;
    
    [self.contentView addSubview:describeLabel];
    self.describeLabel = describeLabel;
    
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(titleLabel.mas_left);
        make.bottom.mas_equalTo(- KHeight(20));
        make.height.mas_equalTo(KHeight(14));
    }];
}

//我的计划特有的UI
- (void)setMyPlanUI
{
    //以下为 我的计划所特有的UI
    if (self.isMyPlan)
    {
        UIImageView *medalImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plan_medal"]];
        
        medalImage.hidden = YES;
        
        [self.contentView addSubview:medalImage];
        self.medalImage = medalImage;
        
        [medalImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(self.joinButton.mas_left).mas_offset( - KWidth(5));
            make.size.mas_equalTo(CGSizeMake(KWidth(36), KWidth(36)));
        }];
        
        UILabel *statusLabel = [[UILabel alloc]init];
        
        statusLabel.font = Kfont(13);
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = kMainColor;
        
        [self.contentView addSubview:statusLabel];
        self.statusLabel = statusLabel;
        
        [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(medalImage.mas_centerY);
            make.centerX.mas_equalTo(self.joinButton.mas_centerX);
            make.height.mas_equalTo(KHeight(13));
        }];
    }
}

- (void)loadData
{
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"LogoImg"]] placeholderImage:KPlaceHoldImage];
    self.titleLabel.text = self.dataDic[@"PlanTitle"];
    self.describeLabel.text = [NSString stringWithFormat:@"%@人已加入",self.dataDic[@"JoinCount"]];

    NSInteger status = [self.dataDic[@"PlanStatus"] integerValue];
    if (status == 1)
    {
        self.backgroundColor = kMainColor;
        [self.joinButton setTitleColor:kMainColor forState:UIControlStateNormal];
        [self.joinButton setTitle:@"查看本日" forState:UIControlStateNormal];
        self.joinButton.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel.textColor = [UIColor whiteColor];
        self.describeLabel.textColor = [UIColor whiteColor];
        
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
        [self.joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.joinButton.backgroundColor = kMainColor;
        
        self.titleLabel.textColor = [UIColor blackColor];
        self.describeLabel.textColor = GRAYCOLOR;
        
        if (status != 0)
        {
            [self.joinButton setTitle:@"查看结果" forState:UIControlStateNormal];
            
            if (self.isMyPlan)
            {
                if (status == 2)
                {
                    self.medalImage.hidden = NO;
                    self.statusLabel.text = @"已完成";
                    self.statusLabel.textColor = kMainColor;
                }else
                {
                    self.medalImage.hidden = YES;
                    self.statusLabel.text = @"未完成";
                    self.statusLabel.textColor = GRAYCOLOR;
                }
            }
        }else
        {
            [self.joinButton setTitle:@"加入" forState:UIControlStateNormal];
        }
    }
}

#pragma mark Setter
- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    [self loadData];
}

- (void)setIsMyPlan:(BOOL)isMyPlan
{
    _isMyPlan = isMyPlan;
    
    [self setMyPlanUI];
}

@end