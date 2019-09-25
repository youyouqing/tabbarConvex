//
//  XKSingleCheckMultipleCommonResultCell.m
//  PC300
//
//  Created by jamkin on 2017/8/16.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import "XKSingleCheckMultipleCommonResultCell.h"
@interface XKSingleCheckMultipleCommonResultCell()

@property (weak, nonatomic) IBOutlet UILabel *DrinkSuggestLab;
@property (weak, nonatomic) IBOutlet UILabel *DrinkLab;//4

@property (weak, nonatomic) IBOutlet UILabel *HealthSuggestLab;
@property (weak, nonatomic) IBOutlet UILabel *HealthLab;//2

@property (weak, nonatomic) IBOutlet UILabel *SportLab;
@property (weak, nonatomic) IBOutlet UILabel *SporttLab;//1

@property (weak, nonatomic) IBOutlet UILabel *KnowledgeSuggestLab;
@property (weak, nonatomic) IBOutlet UILabel *KnowledgeLab;//3
@end

@implementation XKSingleCheckMultipleCommonResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setStatusModel:(ExchinereportModel *)statusModel
//{
//    _statusModel = statusModel;
//    SuggestReportModel *model = _statusModel.SuggestList[0];
//    NSLog(@"---PhysicalItemIdentifierPhysicalItemIdentifier-----%@",statusModel.PhysicalItemIdentifier);
//    if (model.HealthSuggest) {
//        self.HealthLab.text = [NSString stringWithFormat:@"养生建议：\n"];
//    }
//    else
//        self.HealthLab.text = @"";
//    if (model.DrinkSuggest) {
//        self.DrinkLab.text =  [NSString stringWithFormat:@"饮食建议：\n"];
//    }
//    else
//        self.DrinkLab.text = @"";
//    if (model.KnowledgeSuggest) {
//        self.KnowledgeLab.text =  [NSString stringWithFormat:@"健康常识：\n"];;
//    }
//    else
//        self.KnowledgeLab.text = @"";
//    if (model.SportSuggest) {
//        self.SporttLab.text =  [NSString stringWithFormat:@"运动建议：\n"];
//    }
//    else
//        self.SporttLab.text = @"";
//    
//    self.HealthSuggestLab.text = [NSString stringWithFormat:@"\n%@\n",model.HealthSuggest];
//    
//    self.DrinkSuggestLab.text = [NSString stringWithFormat:@"\n%@\n",model.DrinkSuggest];;
//    self.KnowledgeSuggestLab.text = [NSString stringWithFormat:@"\n%@\n",model.KnowledgeSuggest];;
//    self.SportLab.text = [NSString stringWithFormat:@"\n%@\n",model.SportSuggest];;
//    
//    if (statusModel.ParameterStatus == 1) {
//        NSString *jugeStr = @"偏高";
//        self.statusLab.textColor = [UIColor colorWithHexString:@"F63232"];
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_004"]) {
//              self.statusLab.text = [NSString stringWithFormat:@"总胆固醇偏高\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"高密度脂蛋白偏高\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"低密度纸蛋白偏高\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"甘油三酯偏高\n"];
//        }
//        
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"收缩压偏高\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"舒张压偏高\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"RHR"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"心率偏高\n"];
//        }
//        
//        
//           /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
//           self.statusLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_013"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身高%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_014"]) {
//           self.statusLab.text = [NSString stringWithFormat:@"体重%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
//           self.statusLab.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
//           self.statusLab.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
//        }
//
//    }
//    else if (statusModel.ParameterStatus == 3) {
//         self.statusLab.textColor = [UIColor colorWithHexString:@"EBC120"];
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_004"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"总胆固醇偏低\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"高密度脂蛋白偏低\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"低密度纸蛋白偏低\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
//             self.statusLab.text = [NSString stringWithFormat:@"甘油三酯偏低\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"收缩压偏低\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"舒张压偏低\n"];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"RHR"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"心率偏低\n"];
//        }
//        
//         NSString *jugeStr = @"偏低";
//        /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_013"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身高%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_014"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"体重%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
//        }
//        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
//            self.statusLab.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
//        }
//
//    }else
//        
//    
//      self.statusLab.text = @"";
//    
//
//    [self layoutIfNeeded];
//
//}
-(void)setStatusModel:(ExchinereportModel *)statusModel
{
    _statusModel = statusModel;
    if (statusModel.ParameterStatus == 1) {
        NSString *jugeStr = @"偏高";
                self.statusLab.textColor = [UIColor colorWithHexString:@"F63232"];
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_004"]||[statusModel.PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
            self.statusLab.text = [NSString stringWithFormat:@"总胆固醇偏高\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"高密度脂蛋白偏高\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"低密度脂蛋白偏高\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"甘油三酯偏高\n"];
        }
        
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"收缩压偏高\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"舒张压偏高\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"RHR"]) {
            self.statusLab.text = [NSString stringWithFormat:@"心率偏高\n"];
        }
        
        
        /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
            self.statusLab.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
            self.statusLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"HG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身高%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"WG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
            self.statusLab.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
            self.statusLab.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
            self.statusLab.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
            self.statusLab.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
        }
        
    }
    else if (statusModel.ParameterStatus == 3) {
                self.statusLab.textColor = [UIColor colorWithHexString:@"EBC120"];
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_004"]||[statusModel.PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
            self.statusLab.text = [NSString stringWithFormat:@"总胆固醇偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"高密度脂蛋白偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"低密度脂蛋白偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"甘油三酯偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"收缩压偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"舒张压偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"RHR"]) {
            self.statusLab.text = [NSString stringWithFormat:@"心率偏低\n"];
        }
        
        NSString *jugeStr = @"偏低";
        /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
            self.statusLab.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
            self.statusLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"HG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身高%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"WG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
            self.statusLab.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
            self.statusLab.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
            self.statusLab.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
            self.statusLab.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
        }
        
    }
    else if (statusModel.ParameterStatus == 4) {
        self.statusLab.textColor = [UIColor colorWithHexString:@"F63232"];
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_004"]||[statusModel.PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
            self.statusLab.text = [NSString stringWithFormat:@"总胆固醇偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"高密度脂蛋白偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"低密度脂蛋白偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"甘油三酯偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"收缩压偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"舒张压偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"RHR"]) {
            self.statusLab.text = [NSString stringWithFormat:@"心率偏低\n"];
        }
        
        NSString *jugeStr = @"超重";
        /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
            self.statusLab.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
            self.statusLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"HG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身高%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"WG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
            self.statusLab.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
            self.statusLab.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
            self.statusLab.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
            self.statusLab.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
        }
        
    }
    else if (statusModel.ParameterStatus == 5) {
        self.statusLab.textColor = [UIColor colorWithHexString:@"F63232"];
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_004"]||[statusModel.PhysicalItemIdentifier isEqualToString:@"CHOL"]) {
            self.statusLab.text = [NSString stringWithFormat:@"总胆固醇偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"高密度脂蛋白偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"低密度脂蛋白偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BF_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"甘油三酯偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_002"]) {
            self.statusLab.text = [NSString stringWithFormat:@"收缩压偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"舒张压偏低\n"];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"RHR"]) {
            self.statusLab.text = [NSString stringWithFormat:@"心率偏低\n"];
        }
        
        NSString *jugeStr = @"肥胖";
        /*  检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)*/
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_012"]) {
            self.statusLab.text = [NSString stringWithFormat:@"内脏脂肪等级%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BMI"]) {
            self.statusLab.text = [NSString stringWithFormat:@"BMI%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_001"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体脂脂率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_008"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体水分%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_003"]) {
            self.statusLab.text = [NSString stringWithFormat:@"肌肉质量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"HG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身高%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"WG"]) {
            self.statusLab.text = [NSString stringWithFormat:@"体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_025"]) {
            self.statusLab.text = [NSString stringWithFormat:@"皮下脂肪%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_026"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨骼肌率%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_028"]) {
            self.statusLab.text = [NSString stringWithFormat:@"去脂体重%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_004"]) {
            self.statusLab.text = [NSString stringWithFormat:@"蛋白质%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_011"]) {
            self.statusLab.text = [NSString stringWithFormat:@"基础代谢%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_027"]) {
            self.statusLab.text = [NSString stringWithFormat:@"骨量%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_029"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体年龄%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_030"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体类型%@\n",jugeStr];
        }
        if ([statusModel.PhysicalItemIdentifier isEqualToString:@"BCP_031"]) {
            self.statusLab.text = [NSString stringWithFormat:@"身体得分%@\n",jugeStr];
        }
        
    }else
       self.statusLab.text = @"";
    
    
    SuggestReportModel *model = nil;
    if (_statusModel.SuggestList.count>0) {
        model = _statusModel.SuggestList[0];
        if (model.SportSuggest.length>0) {
            self.SporttLab.text = [NSString stringWithFormat:@"健康常识：\n"];
            self.SportLab.text =  [NSString stringWithFormat:@"%@\n",model.KnowledgeSuggest];;
           
        }
        else
        {
            self.SporttLab.text = @"";
            self.SportLab.text = @"";
        }
        if (model.HealthSuggest.length>0) {
            self.HealthLab.text = [NSString stringWithFormat:@"养生建议：\n"];
            self.HealthSuggestLab.text = [NSString stringWithFormat:@"%@\n",model.HealthSuggest];
        }
        else
        {
            self.HealthLab.text = @"";
            self.HealthSuggestLab.text = @"";
        }
        if (model.DrinkSuggest.length>0) {
            self.DrinkLab.text = [NSString stringWithFormat:@"运动建议：\n"];
            self.DrinkSuggestLab.text =  [NSString stringWithFormat:@"%@\n",model.SportSuggest];;
            
        }
        else
        {
            
            self.DrinkLab.text = @"";
            self.DrinkSuggestLab.text = @"";
            
            
        }
        if (model.KnowledgeSuggest.length>0) {
            self.KnowledgeLab.text =  [NSString stringWithFormat:@"饮食建议：\n"];
            self.KnowledgeSuggestLab.text = [NSString stringWithFormat:@"%@\n",model.DrinkSuggest];;
            
        }
        else
        {
            self.KnowledgeLab.text = @"";
            self.KnowledgeSuggestLab.text = @"";
        }
    }
    else
    {
        self.SporttLab.text = @"";
        self.KnowledgeLab.text = @"";
        self.HealthLab.text = @"";
        self.DrinkLab.text = @"";
        self.HealthSuggestLab.text =@"";
        self.DrinkSuggestLab.text =@"";
        self.KnowledgeSuggestLab.text =@"";
        self.SportLab.text =@"";
    }
    
    NSLog(@"---PhysicalItemIdentifierPhysicalItemIdentifier-----%@",statusModel.PhysicalItemIdentifier);
    
    
    
    
    //  [self layoutIfNeeded];
    
    
    
}

//-(void)setModel:(SuggestReportModel *)model
//{
//
//    _model = model;
//    
//
//    
//    [self layoutIfNeeded];
//
//}
//-(void)setModelArr:(NSArray *)modelArr
//{
//    _modelArr = modelArr;
//    
//    if (modelArr.count==1) {
//        
//        
//        SuggestReportModel *mod = modelArr[0];
//        self.HealthSuggestLab.text = mod.HealthSuggest;
//          self.DrinkSuggestLab.text = mod.DrinkSuggest;
//          self.KnowledgeSuggestLab.text = mod.KnowledgeSuggest;
//         self.SportLab.text = mod.SportSuggest;
//    }
//    if (modelArr.count==2) {
////        self.DrinkSuggestLab.text = modelArr[1];
//        
//        
//        SuggestReportModel *mod = modelArr[1];
//        self.HealthSuggestLab.text = mod.HealthSuggest;
//        self.DrinkSuggestLab.text = mod.DrinkSuggest;
//        self.KnowledgeSuggestLab.text = mod.KnowledgeSuggest;
//        self.SportLab.text = mod.SportSuggest;
//    }
//    if (modelArr.count==3) {
////        self.KnowledgeSuggestLab.text = modelArr[2];
//        
//        
//        
//        SuggestReportModel *mod = modelArr[2];
//        self.HealthSuggestLab.text = mod.HealthSuggest;
//        self.DrinkSuggestLab.text = mod.DrinkSuggest;
//        self.KnowledgeSuggestLab.text = mod.KnowledgeSuggest;
//        self.SportLab.text = mod.SportSuggest;
//    }
//    if (modelArr.count==4) {
////        self.SportLab.text = modelArr[3];
//        
//        SuggestReportModel *mod = modelArr[3];
//        self.HealthSuggestLab.text = mod.HealthSuggest;
//        self.DrinkSuggestLab.text = mod.DrinkSuggest;
//        self.KnowledgeSuggestLab.text = mod.KnowledgeSuggest;
//        self.SportLab.text = mod.SportSuggest;
//        
//    }
//
//
//}

@end
