//
//  XKMultiFunctionCheckResultCell.m
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//携康3.0版本pc300检测报告页面cell视图

#import "XKMultiFunctionCheckResultCell.h"
@interface XKMultiFunctionCheckResultCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleOneLab;

@property (weak, nonatomic) IBOutlet UILabel *titleTwoLab;

@property (weak, nonatomic) IBOutlet UILabel *titleThreeLab;



/**
 数据
 */
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

/**
 正常  偏高偏低
 */
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;

/**
 舒张压 数据
 */
@property (weak, nonatomic) IBOutlet UILabel *diastolicBloodLab;

/**
 舒张压 正常  偏高偏低
 */

@property (weak, nonatomic) IBOutlet UILabel *diastolicBloodConditionLab;

/**
 静息心率
 */
@property (weak, nonatomic) IBOutlet UILabel *heartRateLab;

/**
 静息心率 偏高偏低
 */
@property (weak, nonatomic) IBOutlet UILabel *heartRateConditionLab;

@end
@implementation XKMultiFunctionCheckResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
    
}
-(void)setArrayModel:(NSMutableArray *)arrayModel {
    
    _arrayModel = arrayModel;
    
    ReportModel *one = _arrayModel[0];
    self.titleOneLab.text = one.ItemName;
    self.dataLab.text = one.ItemValue.length>0?one.ItemValue:@"--";
    if (one.ParameterStatus == 1) {//偏高
        self.conditionLab.text = @"偏高";
        self.conditionLab.textColor = ORANGECOLOR;
    }
 else   if (one.ParameterStatus == 2) {//正常
        self.conditionLab.text = @"正常";
        self.conditionLab.textColor = [UIColor colorWithHexString:@"3BBD51"];
    }
   else if (one.ParameterStatus == 3) {//偏低
        self.conditionLab.text = @"偏低";
        self.conditionLab.textColor = ORANGECOLOR;
    }
    else
        
    self.conditionLab.text = @"--";
    
    ReportModel *two = _arrayModel[1];
    self.titleTwoLab.text = two.ItemName;
    self.diastolicBloodLab.text = two.ItemValue.length>0?two.ItemValue:@"--";
    //    self.normalTwoLab.text = two.ParameterName;
    if (two.ParameterStatus == 1) {
        self.diastolicBloodConditionLab.text = @"偏高";
        self.diastolicBloodConditionLab.textColor = ORANGECOLOR;
    }
   else if (two.ParameterStatus == 2) {
        self.diastolicBloodConditionLab.text = @"正常";
        self.diastolicBloodConditionLab.textColor = [UIColor colorWithHexString:@"3BBD51"];
    }
   else if (two.ParameterStatus == 3) {
        self.diastolicBloodConditionLab.text = @"偏低";
        self.diastolicBloodConditionLab.textColor = ORANGECOLOR;
    }
    else
         self.diastolicBloodConditionLab.text = @"--";
//    self.diastolicBloodConditionLab.text = [NSString stringWithFormat:@"%@",two.ReferenceValue];
    
    ReportModel *three = _arrayModel[2];
    self.titleThreeLab.text = three.ItemName;
    self.heartRateLab.text = three.ItemValue.length>0?three.ItemValue:@"--";
    if (three.ParameterStatus == 1) {
        self.heartRateConditionLab.text = @"偏高";
        self.heartRateConditionLab.textColor = ORANGECOLOR;
    }
   else if (three.ParameterStatus == 2) {
        self.heartRateConditionLab.text = @"正常";
        self.heartRateConditionLab.textColor = [UIColor colorWithHexString:@"3BBD51"];
    }
   else if (three.ParameterStatus == 3) {
        self.heartRateConditionLab.text = @"偏低";
        self.heartRateConditionLab.textColor = ORANGECOLOR;
    }
   else  self.heartRateConditionLab.text = @"--";
    self.timeLab.text = [NSString stringWithFormat:@"%@",three.TestTime];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
