//
//  PersonalDictionaryMsg.h
//  eHealthCare
//
//  Created by jamkin on 16/9/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryMsg.h"

@interface PersonalDictionaryMsg : NSObject

/**户口类型**/
@property (nonatomic,strong)NSArray *ResidenceType;

/**饮水类型**/
@property (nonatomic,strong)NSArray *DrinkingWater;

/**既往病史**/
@property (nonatomic,strong)NSArray *PastHistory;

/**厕所卫生**/
@property (nonatomic,strong)NSArray *Toilet;

/**厨房环境**/
@property (nonatomic,strong)NSArray *ExhaustMeasures;

/**婚姻状况**/
@property (nonatomic,strong)NSArray *MaritalStatus;

/**医疗支付类型**/
@property (nonatomic,strong)NSArray *MedicalPayment;

/**吸烟状况**/
@property (nonatomic,strong)NSArray *SmokingStatus;

/**血型**/
@property (nonatomic,strong)NSArray *BloodType;

/**喝酒状态**/
@property (nonatomic,strong)NSArray *DrinkingStatus;

/**家庭燃料**/
@property (nonatomic,strong)NSArray *FuelType;

/**文化等级**/
@property (nonatomic,strong)NSArray *EducationLevel;

/**名族**/
@property (nonatomic,strong)NSArray *NationList;

/**
 过敏药物
 */
@property (nonatomic,strong)NSArray *AllergyDrug;


/**
 手术和外伤
 */
@property (nonatomic,strong)NSArray *OperationTrauma;


/**
 食物和接触物过敏
 */
@property (nonatomic,strong)NSArray *FoodAllergy;

/**
 长期服用药物
 */
@property (nonatomic,strong)NSArray * LongTermMedicine;

@end
