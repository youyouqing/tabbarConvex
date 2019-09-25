//
//  MineElectronicMedicCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MineElectronicMedicCell.h"

@implementation MineElectronicMedicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;//[UIColor getColor:@"EEF7FD"];
    self.dotOneLab.layer.cornerRadius = 2;
    self.dotOneLab.clipsToBounds = YES;
    self.dotTwoLab.backgroundColor = kMainColor;
    self.dotTwoLab.layer.cornerRadius = 2;
    self.dotTwoLab.clipsToBounds = YES;
    self.dotOneLab.backgroundColor = kMainColor;
    self.dotThreeLab.layer.cornerRadius = 2;
    self.dotThreeLab.clipsToBounds = YES;
    self.dotThreeLab.backgroundColor = kMainColor;
    
    self.backView.layer.cornerRadius = 3;
    self.backView.clipsToBounds = YES;
}
-(void)setModel:(XKPatientModel *)model{
    
    _model = model;
    
    self.hospitalName.text =  [NSString stringWithFormat:@"就诊科室：%@",_model.DepartmentsName.length>0?_model.DepartmentsName:@""];
    
    self.typeLab.text =  [NSString stringWithFormat:@"就诊类型：%@",_model.AttendanceTypeName.length>0 ? _model.AttendanceTypeName:@"未知"];
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_model.AttendanceTime]] withFormat:@"yyyy-MM-dd"];
    self.timeLab.text = [NSString stringWithFormat:@"就诊时间：%@",timeStr];
    
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.PatientPicUrl] placeholderImage:[UIImage imageNamed:@" "]];
    NSMutableAttributedString *AttributedStr =  [NSMutableAttributedString boldChangeLabelWithText:self.timeLab.text withBigFont:15 withNeedchangeText:@"就诊时间"  excisionColor:kMainTitleColor];
    [self.timeLab setAttributedText:AttributedStr];
    
    NSMutableAttributedString *AttributedStr2 =  [NSMutableAttributedString boldChangeLabelWithText:self.typeLab.text withBigFont:15 withNeedchangeText:@"就诊类型"  excisionColor:kMainTitleColor];
    [self.typeLab setAttributedText:AttributedStr2];

    NSMutableAttributedString *AttributedStr3 =  [NSMutableAttributedString boldChangeLabelWithText:self.hospitalName.text withBigFont:15 withNeedchangeText:@"就诊科室"  excisionColor:kMainTitleColor];
    [self.hospitalName setAttributedText:AttributedStr3];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
