//
//  XKAcountHistoryBottomView.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKAcountHistoryBottomView.h"

@interface XKAcountHistoryBottomView ()

/**
 展示步数的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *acountLab;

/**
 展示里程的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *klomiterLab;

/**
 展示热量的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *hotLab;

@end

@implementation XKAcountHistoryBottomView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

/**
 重写数据源set方法
 */
-(void)setModel:(StepModel *)model{
    _model = model;
    
    self.acountLab.text = [NSString stringWithFormat:@"%li",model.StepCount];
    self.klomiterLab.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:model.KilometerCount]];
    self.hotLab.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:model.KilocalorieCount]];
    
}

@end
