//
//  HealthRecordMedical TableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordMedical TableViewCell.h"

@interface HealthRecordMedical_TableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *roomLab;

@end

@implementation HealthRecordMedical_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.dotOneLab.layer.cornerRadius = 2;
    self.dotOneLab.clipsToBounds = YES;
    self.dotTwoLab.backgroundColor = kMainColor;
    self.dotTwoLab.layer.cornerRadius = 2;
    self.dotTwoLab.clipsToBounds = YES;
    self.dotOneLab.backgroundColor = kMainColor;
    self.dotThreeLab.layer.cornerRadius = 2;
    self.dotThreeLab.clipsToBounds = YES;
    self.dotThreeLab.backgroundColor = kMainColor;
    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModle:(PatientInfo *)modle
{
    
    _modle = modle;
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_modle.AttendanceTime]] withFormat:@"yyyy-MM-dd"];
    self.timeLab.text =  [NSString stringWithFormat:@"就诊时间：%@",timeStr];
    self.typeLab.text =  [NSString stringWithFormat:@"就诊类型：%@",modle.AttendanceType.length>0 ? modle.AttendanceType:@"未知"];
    self.roomLab.text = [NSString stringWithFormat:@"就诊科室：%@",modle.DepartmentsName.length>0?modle.DepartmentsName:@""];
    
    [self.picture sd_setImageWithURL:[NSURL URLWithString:modle.PatientPic] placeholderImage:[UIImage imageNamed:@" "]];
    
    
    NSMutableAttributedString *AttributedStr =  [NSMutableAttributedString boldChangeLabelWithText:self.timeLab.text withBigFont:15 withNeedchangeText:@"就诊时间"  excisionColor:kMainTitleColor];
    [self.timeLab setAttributedText:AttributedStr];
    
    NSMutableAttributedString *AttributedStr2 =  [NSMutableAttributedString boldChangeLabelWithText:self.typeLab.text withBigFont:15 withNeedchangeText:@"就诊类型"  excisionColor:kMainTitleColor];
    [self.typeLab setAttributedText:AttributedStr2];
    
    NSMutableAttributedString *AttributedStr3 =  [NSMutableAttributedString boldChangeLabelWithText:self.roomLab.text withBigFont:15 withNeedchangeText:@"就诊科室"  excisionColor:kMainTitleColor];
    [self.roomLab setAttributedText:AttributedStr3];
    
}
@end
