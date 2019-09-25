//
//  XKAcountDiscountSingleView.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKAcountDiscountSingleView.h"

@interface XKAcountDiscountSingleView ()

/**
 描述周几的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *weekLab;

/**
 描述号数的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *dayLab;


@end

@implementation XKAcountDiscountSingleView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
//    int R = (arc4random() % 256) ;
//    int G = (arc4random() % 256) ;
//    int B = (arc4random() % 256) ;
//    
//    self.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
    
    self.backgroundColor = [UIColor clearColor];
    
}

/**重写数据源*/
-(void)setModel:(StepModel *)model{
    
    _model = model;
    
    self.weekLab.text = model.weekDay;
    self.dayLab.text = model.dayTime;
    
}

@end
