//
//  VisionResultView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "VisionResultView.h"

@interface VisionResultView ()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *eyeNumLabel;
@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation VisionResultView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark UI
- (void)createUI
{
//    self.image = [UIImage imageNamed:@"eye_resultBackImage"];
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"eye_resultBackImage"]];
    
    [self addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KWidth(162), KHeight(227)));
    }];
    
    
    UIImageView *eyeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_shili_result"]];
    
    [self addSubview:eyeImage];
    [eyeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(20));
        make.left.mas_equalTo(KWidth(28));
        make.size.mas_equalTo(CGSizeMake(KWidth(21), KHeight(15)));
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = Kfont(12);
    
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(eyeImage.mas_right).mas_offset(KWidth(6));
        make.centerY.mas_equalTo(eyeImage.mas_centerY);
        make.height.mas_equalTo(KHeight(12));
    }];
    
    //眼镜的标识
    UILabel *eyeNumLabel = [[UILabel alloc]init];
    
    eyeNumLabel.font = Kfont(75);
    eyeNumLabel.textAlignment = NSTextAlignmentCenter;
    eyeNumLabel.textColor =[UIColor whiteColor];
    
    [backImage addSubview:eyeNumLabel];
    self.eyeNumLabel = eyeNumLabel;
    
    [eyeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(backImage.mas_centerX);
        make.centerY.mas_equalTo(backImage.mas_centerY);
        make.height.mas_equalTo(KHeight(62));
    }];
    
    UIView *whiteView = [[UIView alloc]init];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KHeight(66));
        make.height.mas_equalTo(KHeight(50));
    }];
    
    UILabel *resultLabel = [[UILabel alloc]init];
    
    resultLabel.textColor = kMainTitleColor;
    resultLabel.font = Kfont(15);
    resultLabel.textAlignment = NSTextAlignmentCenter;
    
    [whiteView addSubview:resultLabel];
    self.resultLabel = resultLabel;
    
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(KHeight(15));
    }];
}

#pragma mark Public Methoud
- (void)loadData:(float)eyeNum isRightEye:(BOOL)isRightEye
{
    self.eyeNumLabel.text = [NSString stringWithFormat:@"%.1f",eyeNum];
    self.resultLabel.text = eyeNum <= 4.9 ? @"近视眼":@"正常";
    
    if (isRightEye)
    {
        self.tipLabel.text = @"右眼视力";
    }else
    {
        self.tipLabel.text = @"左眼视力";
    }
}

@end
