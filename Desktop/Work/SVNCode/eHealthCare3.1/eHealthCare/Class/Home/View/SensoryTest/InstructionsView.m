//
//  instructionsView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/10.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "InstructionsView.h"

@interface InstructionsView ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation InstructionsView

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
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.text = @"亲爱的用户:";
    tipLabel.font = Kfont(16);
    tipLabel.textColor = kMainTitleColor;
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(14));
        make.left.mas_equalTo(KWidth(8));
        make.height.mas_equalTo(KHeight(14));
    }];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    
    contentLabel.font = Kfont(15);
    contentLabel.textColor = GRAYCOLOR;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

#pragma mark Private Methoud
///加载数据以及设置约束
- (void)loadData:(NSString *)content type:(sensoryType)type
{
    self.contentLabel.text = content;
    
    CGSize maxContentSize = CGSizeMake(KScreenWidth - KWidth(40), CGFLOAT_MAX);
    CGSize expectContentSize = [self.contentLabel sizeThatFits:maxContentSize];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(KHeight(50));
        make.left.mas_equalTo(KWidth(25));
        make.right.mas_equalTo(- KWidth(15));
        make.height.mas_equalTo(expectContentSize.height);
    }];
    
//    UIImageView *sealImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"seal"]];
//
//    [self addSubview:sealImage];
//
//    float spaceH;
//    //如果是视力测试或色觉测试 距离视图顶部距离一样
//    if (type < sensoryTypeFlexibility)
//    {
//        spaceH = 90;
//    }else
//    {
//        spaceH = 64;
//    }
//
//    [sealImage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(KHeight(spaceH));
//        make.right.mas_equalTo(- KWidth(12));
//        make.size.mas_equalTo(CGSizeMake(KWidth(130), KWidth(130)));
//    }];
}

@end