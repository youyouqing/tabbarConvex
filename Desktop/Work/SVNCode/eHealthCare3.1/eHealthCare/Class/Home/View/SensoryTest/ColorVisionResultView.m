//
//  ColorVisionResult.m
//  eHealthCare
//
//  Created by John shi on 2018/8/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "ColorVisionResultView.h"

@interface ColorVisionResultView ()

@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation ColorVisionResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    [self addSubview:imageView];
    self.imageView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.mas_equalTo(0);
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(0);
    }];
}

#pragma mark Setter
- (void)setResult:(NSString *)result
{
    _result = result;
    
    if ([result isEqualToString:@"正常"])
    {
        _imageView.image = [UIImage imageNamed:@"regular"];
        
    }else if ([result isEqualToString:@"色弱"])
    {
        _imageView.image = [UIImage imageNamed:@"ColorWeakness"];
        
    }else if ([result isEqualToString:@"先天性色盲"])
    {
        _imageView.image = [UIImage imageNamed:@"ColorBlindness"];
    }
}
@end
