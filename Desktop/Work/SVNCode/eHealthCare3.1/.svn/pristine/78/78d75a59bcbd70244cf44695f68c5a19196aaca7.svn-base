//
//  PlanDirectoryCell.m
//  eHealthCare
//
//  Created by John shi on 2018/8/24.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PlanDirectoryCell.h"

@interface PlanDirectoryCell ()

@property (nonatomic, strong) UILabel *tipLabe;
@property (nonatomic, strong) UIImageView *markImage;

@end

@implementation PlanDirectoryCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLabe = [[UILabel alloc]init];
    tipLabe.font = Kfont(18);
    tipLabe.textColor = GRAYCOLOR;
    tipLabe.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:tipLabe];
    self.tipLabe = tipLabe;
    
    [tipLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(- KWidth(25));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(KHeight(18));
    }];
    
    UIImageView *markImage = [[UIImageView alloc]init];
    markImage.hidden = YES;
    markImage.image = [UIImage imageNamed:@"unfinishedImage"];
    [self.contentView addSubview:markImage];
    self.markImage = markImage;
    
    [markImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(KWidth(27));
        make.centerY.mas_equalTo(tipLabe.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(KWidth(12), KWidth(12)));
    }];
}

- (void)loadData
{
    self.tipLabe.text = [NSString stringWithFormat:@"第%@天",self.dataDic[@"Sort"]];
    
    if ([self.dataDic[@"PlanDetailStatus"] integerValue] == 1)
    {
        self.markImage.hidden = NO;
        if ([self.dataDic[@"CurrentDay"] integerValue] == 0)
        {
                self.markImage.image = [UIImage imageNamed:@"flag"];
        }else
        {
            self.markImage.image = [UIImage imageNamed:@"lightFlag"];
        }
        
    }else if ([self.dataDic[@"PlanDetailStatus"] integerValue] == 2)
    {
        if ([self.dataDic[@"CurrentDay"] integerValue] == 0)
        {
            self.markImage.hidden = NO;
            self.markImage.image = [UIImage imageNamed:@"unfinishedImage"];
        }else
        {
            self.markImage.hidden = YES;
        }
    }else
    {
        self.markImage.hidden = YES;
    }
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    [self loadData];
}

@end
