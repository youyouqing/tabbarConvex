//
//  XKExChinereportModel.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuggestReportModel.h"
@interface XKExChinereportModel : NSObject
/**
 检测
 */
@property (nonatomic,strong) NSArray *SuggestList;

@property(nonatomic,strong) SuggestReportModel *SuggestReportModel;
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
 */
@property (nonatomic,copy) NSString *PhysicalItemIdentifier;
@end
