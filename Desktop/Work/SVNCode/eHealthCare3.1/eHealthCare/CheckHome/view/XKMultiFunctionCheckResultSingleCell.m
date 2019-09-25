//
//  XKMultiFunctionCheckResultSingleCell.m
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMultiFunctionCheckResultSingleCell.h"

@interface XKMultiFunctionCheckResultSingleCell ()

//血压监测
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;

/**
 小标题名字
 */
@property (weak, nonatomic) IBOutlet UILabel *subTitleNameLab;

/**
 时间
 */


/**
 数据
 */
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

/**
 正常  偏高偏低
 */
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;

@end


@implementation XKMultiFunctionCheckResultSingleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 模型数据赋值

 @param model <#model description#>
 */
-(void)setModel:(ReportModel *)model{
    
    _model = model;
    
 
   
    if ([_model.ItemName containsString:@"血氧"]) {
        
//        self.iconImg.image = [UIImage imageNamed:@"bloodoxygen1"];
        
    }
    if ([_model.ItemName containsString:@"心率"]) {
        
//        self.iconImg.image = [UIImage imageNamed:@"pulserate"];
        
    }
    if ([_model.ItemName containsString:@"体温"]) {
        
//        self.iconImg.image = [UIImage imageNamed:@"heat1"];
        
    }
    if ([_model.ItemName containsString:@"血糖"]) {
        
//        self.iconImg.image = [UIImage imageNamed:@"bloodglucose1"];
        
    }
    if (_model.ParameterStatus == 1) {
        self.conditionLab.text = @"偏高";
        self.conditionLab.textColor = ORANGECOLOR;
    }
    else  if (_model.ParameterStatus == 2) {
        self.conditionLab.text = @"正常";
        self.conditionLab.textColor = [UIColor colorWithHexString:@"3BBD51"];
    }
    else if (_model.ParameterStatus == 3) {
        self.conditionLab.text = @"偏低";
        self.conditionLab.textColor = ORANGECOLOR;
    }
    else
         self.conditionLab.text = @"--";
    self.titleNameLab.text = [NSString stringWithFormat:@"%@检测",_model.ItemName];
    self.subTitleNameLab.text = [NSString stringWithFormat:@"%@",_model.ItemName];
    self.dataLab.text = _model.ItemValue.length>0?_model.ItemValue:@"--";
//    self.timeLab.text = [NSString stringWithFormat:@"%@",_model.TestTime];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
