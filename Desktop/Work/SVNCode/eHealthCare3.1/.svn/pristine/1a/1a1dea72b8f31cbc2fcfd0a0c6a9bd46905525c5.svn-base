//
//  HealthTestHeadView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthTestHeadView.h"

@implementation HealthTestHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

#pragma mark UI
- (void)createUI
{
    NSArray *imageArray = @[@"health_subhealthy",@"health_dailyAction",@"health_mind",@"health_measurement"];
    NSArray *secondImageArray = @[@"health_eyeTest",@"health_colorTest",@"health_flexibility",@"health_handle"];
    
    NSArray *titleArray = @[@"亚健康",@"日常行为",@"健商",@"体质检测"];
    NSArray *secondTitleArray = @[@"视力",@"色觉",@"柔韧度",@"挥拳"];
    
    NSArray *subTitleArray = @[@"身体被掏空?",@"习惯铸就健康",@"健商导航健康",@"权威中医测体质"];
    
    NSArray *textColorArray = @[[UIColor colorWithRed:151/255. green:92/255. blue:32/255. alpha:1],
                                [UIColor colorWithRed:66/255. green:143/255. blue:140/255. alpha:1],
                                [UIColor colorWithRed:46/255. green:94/255. blue:179/255. alpha:1],
                                [UIColor colorWithRed:159/255. green:74/255. blue:43/255. alpha:1]];
    
    for (int i = 0; i < imageArray.count; i++) {
        //上面大的四个按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(KHeight(12) + i / 2 * KHeight(93));
            make.left.mas_equalTo(KWidth(10) + i % 2 * KWidth(180));
            make.size.mas_equalTo(CGSizeMake(KWidth(175), KHeight(88)));
        }];
        
        //下面小的四个按钮
        UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [secondButton setImage:[UIImage imageNamed:secondImageArray[i]] forState:UIControlStateNormal];
        [secondButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        secondButton.tag = 104 + i;
        
        [secondButton setTitle:secondTitleArray[i] forState:UIControlStateNormal];
        [secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        secondButton.titleLabel.font = Kfont(13);
        
        [secondButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];

        [self addSubview:secondButton];
        [secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(i * KScreenWidth / 4);
            make.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth / 4, KHeight(55)));
        }];
        
         //四个按钮分割线  之前每个按钮都带边框显示不好看
        if (i < 3)
        {
            if (i < 2)
            {
                UIView *lineView = [[UIView alloc]init];
                
                lineView.backgroundColor = GRAYCOLOR;
                
                [self addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.right.mas_equalTo(0);
                    make.bottom.mas_equalTo(- i * KHeight(55));
                    make.height.mas_equalTo(KHeight(0.5));
                }];
            }
            UIView *lineYView = [[UIView alloc]init];
            
            lineYView.backgroundColor = GRAYCOLOR;
            
            [self addSubview:lineYView];
            [lineYView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo((i + 1) * KScreenWidth / 4);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(KWidth(0.5));
                make.height.mas_equalTo(KHeight(55));
            }];
            
        }
        
        
        //上面大的按钮标题等
        UILabel *titleLabel = [[UILabel alloc]init];
        
        titleLabel.font = [UIFont systemFontOfSize:16 * KScreenWidth / 375 weight:1];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = textColorArray[i];
        
        [button addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(KHeight(21));
            make.left.mas_equalTo(KWidth(80));
            make.height.mas_equalTo(KHeight(16));
        }];
        
        UILabel *subTitle = [[UILabel alloc]init];
        
        subTitle.font = Kfont(12);
        subTitle.text = subTitleArray[i];
        subTitle.textColor = textColorArray[i];
        
        [button addSubview:subTitle];
        
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(KHeight(8));
            make.left.mas_equalTo(titleLabel.mas_left);
            make.height.mas_equalTo(KHeight(12));
        }];
    }
}

#pragma mark Action
- (void)buttonClickAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickAtIndex:)]) {
        [self.delegate buttonClickAtIndex:button.tag - 100];
    }
}

@end
