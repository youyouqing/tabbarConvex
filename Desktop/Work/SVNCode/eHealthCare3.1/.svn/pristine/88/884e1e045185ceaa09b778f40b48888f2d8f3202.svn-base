//
//  MusicTrainListCell.m
//  eHealthCare
//
//  Created by John shi on 2018/7/24.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MusicTrainListCell.h"

#import "MusicTrainModel.h"

@interface MusicTrainListCell ()

@property (nonatomic, strong) UIImageView *photoImage;

@end

@implementation MusicTrainListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createUI];
    }
    
    return self;
}

#pragma mark UI
- (void)createUI
{
    UIImageView *photoImage = [[UIImageView alloc]init];
    
    photoImage.image = [UIImage imageNamed:@""];
    
    [self.contentView addSubview:photoImage];
    self.photoImage = photoImage;
    [photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(6);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(KScreenWidth - KWidth(12), KHeight(88)));
    }];
}

#pragma mark load data
- (void)loadData
{
    MusicTrainModel *model = [MusicTrainModel mj_objectWithKeyValues:self.dataDic];
    
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.TitleImgUrl] placeholderImage:[UIImage imageNamed:@"MusicTrain_placeHolderImage"]];
}

#pragma mark Setter
- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    [self loadData];
}
@end
