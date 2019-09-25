//
//  ExchinereportModel.h
//  PC300
//
//  Created by xiekang on 17/5/9.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuggestReportModel.h"
@interface ExchinereportModel : NSObject

/**
 检测项名称
 */
//@property (nonatomic,copy) NSString *ItemName;
//@property (nonatomic,strong) NSDictionary *SuggestListDic;
/**
 检测
 */
@property (nonatomic,strong) NSArray *SuggestList;


/**
 参考范围
 */
@property (nonatomic,copy) NSString *ParameterName;

/**
 参考范围
 */
@property (nonatomic,copy)NSString *ReferenceValue;

//是否异常(0是1否)
@property (nonatomic,assign) NSInteger ExStatus;

//1偏高2正常3偏低
@property (nonatomic,assign) NSInteger ParameterStatus;

@property (nonatomic,copy) NSString *Unit;


/**
 检目标识(BF_004：总胆固醇、BF_002：高密度脂蛋白、BF_001：低密度纸蛋白、BF_003：甘油三酯)
 
 检目标识(BP_002：收缩压、BP_001：舒张压、RHR：心率)
 
 
 检目标识(BCP_012：内脏脂肪等级、BCP_015：BMI、BCP_001：体脂脂率、BCP_008：身体水分、BCP_003：肌肉质量、BCP_013：身高、BCP_014：体重、BCP_025：皮下脂肪、BCP_026：骨骼肌率、BCP_028：去脂体重、BCP_004：蛋白质、BCP_011：基础代谢、BCP_027：骨量、BCP_029：身体年龄、BCP_030：身体类型、BCP_031：身体得分)
 */
@property (nonatomic,copy) NSString *PhysicalItemIdentifier;
@end
