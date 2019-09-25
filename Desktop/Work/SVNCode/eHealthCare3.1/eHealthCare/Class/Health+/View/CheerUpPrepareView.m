//
//  CheerUpPrepareView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "CheerUpPrepareView.h"

@interface CheerUpPrepareView ()

///确认按钮
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation CheerUpPrepareView

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
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CheerUp_pic_headset"]];
    
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(45));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(150), KWidth(150)));
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [closeButton setImage:[UIImage imageNamed:@"CheerUp_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(clickColse:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(15));
        make.right.mas_equalTo( - KWidth(15));
        make.size.mas_equalTo(CGSizeMake(KWidth(30), KWidth(30)));
    }];
    
    UILabel *remindLabel = [[UILabel alloc]init];
    
    remindLabel.text = @"请插入耳机，拿起话筒，对自己说";
    remindLabel.font = Kfont(14);
    remindLabel.textColor = GRAYCOLOR;
    remindLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(KHeight(22));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(KHeight(17));
//        make.size.mas_equalTo(CGSizeMake(self.mas_width, KHeight(17)));
    }];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [confirmButton setTitle:@"我准备好了" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = Kfont(15);
    [confirmButton addTarget:self action:@selector(clickPrepare:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.layer.cornerRadius = 20;
    confirmButton.layer.masksToBounds = YES;
    [confirmButton setBackgroundColor:kMainColor];
    
    [self addSubview:confirmButton];
    self.confirmButton = confirmButton;
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo( - KHeight(28));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KWidth(130), KHeight(40)));
    }];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

#pragma mark Action
/**
 长按按钮点击事件
 */
- (void)clickPrepare:(id)sender {
    NSLog(@"我准备好了");
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(prepare)]) {
        [self.delegate prepare];
    }
}

/**点击关闭页面*/
- (void)clickColse:(id)sender {
    [[self parentController].navigationController popViewControllerAnimated:YES];
}

@end
