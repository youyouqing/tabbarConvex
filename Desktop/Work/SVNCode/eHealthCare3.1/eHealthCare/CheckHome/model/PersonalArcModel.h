//
//  PersonalArcModel.h
//  eHealthCare
//
//  Created by xiekang on 16/8/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalArcModel : NSObject

/**手术**/
@property (nonatomic,copy)NSString *ProjectOperation;
@property (nonatomic,copy)NSString *ProjectOperationNo;
/**档案标示**/
@property (nonatomic, assign) int RecordID;

/**档案编号**/
@property (nonatomic, strong) NSString  *RecordNo;

/**姓名**/
@property (nonatomic, strong) NSString  *FullName;

/**性别**/
@property (nonatomic, strong) NSString  *Sex;

/**性别编号 **/
@property (nonatomic, assign) int  SexID;

/**出生日期  时间戳**/
@property (nonatomic, strong) NSString  *Birthday;
@property (nonatomic, assign) int Age;
@property (nonatomic, assign) int  Height;
@property (nonatomic, assign) int  Weight;
@property (nonatomic, strong) NSString  *PastHistoryIDList;
//过敏史，多个过敏药物名称之间用逗号分隔，如（青霉素、胺磺）
@property (nonatomic, strong) NSString  *AllergyDrug;

/**
 过敏史，多个过敏药物之间用逗号分隔，如（1，2，3）
 */
@property (nonatomic, strong) NSString  *AllergyDrugNo;
@property (nonatomic, strong) NSString  *FoodAllergy;
@property (nonatomic, strong) NSString  *FoodAllergyNo;
@property (nonatomic, strong) NSString  *LongTermMedicineNo;
@property (nonatomic, strong) NSString  *LongTermMedicine;
/**身份证**/
@property (nonatomic, strong) NSString  *IdCard;

/**现在居住地**/
@property (nonatomic, strong) NSString  *DetailAddress;

/**头像**/
@property (nonatomic, strong) NSString  *HeadImg;

/**籍贯**/
@property (nonatomic, strong) NSString  *PermanentAddress;

/**户口类型**/
@property (nonatomic, strong) NSString  *ResidenceType;

/**户口类型id**/
@property (nonatomic, strong) NSString  *ResidenceTypeID;

/**婚姻状态**/
@property (nonatomic, strong) NSString  *MaritalStatus;

/**婚姻状态id**/
@property (nonatomic, strong) NSString  *MaritalStatusID;

/**教育等级**/
@property (nonatomic, strong) NSString  *EducationLevel;

/**教育等级id**/
@property (nonatomic, strong) NSString  *EducationLevelID;

/**医疗支付类型列表**/
@property (nonatomic, strong) NSString  *MedicalPaymentIDList;

/**医疗支付名称**/
@property (nonatomic,copy)NSString *MedicalPaymentNameList;

/**家族病史编号**/
@property (nonatomic, strong) NSString  *PastHistory;

/**既往史项目 外伤**/
@property (nonatomic, strong) NSString  *ProjectTrauma;

/**既往史项目 输血**/
@property (nonatomic, strong) NSString  *ProjectTransfusion;

/**家族病史**/
@property (nonatomic, strong) NSString  *FamilyHistory;

/**家族病史列表id**/
@property (nonatomic, strong) NSString  *FamilyHistoryIDList;

/**民族**/
@property (nonatomic, strong) NSString  *Nation;

/**名族id**/
@property (nonatomic, strong) NSString  *NationID;

/**手机**/
@property (nonatomic, strong) NSString  *Mobile;

/**血型**/
@property (nonatomic, strong) NSString  *BloodType;

//血型名称
@property (nonatomic, strong) NSString  *BloodTypeName;
/**血型id**/
@property (nonatomic, strong) NSString  *BloodTypeID;

/**职业**/
@property (nonatomic, strong) NSString  *Occupation;

/**职业id**/
@property (nonatomic, strong) NSString  *OccupationID;

/**居住环境 id**/
@property (nonatomic, strong) NSString  *LifeEnvironmentID;

/**居住环境名称**/
@property (nonatomic, strong) NSString  *LifeEnvironmentName;

/**抽烟状态id**/
@property (nonatomic, strong) NSString  *SmokingStatusID;

/**抽烟状态名字**/
@property (nonatomic, strong) NSString  *SmokingStatusName;

/**抽烟年龄**/
@property (nonatomic, strong) NSString  *SmokingAge;

/**每天抽烟的数量**/
@property (nonatomic, strong) NSString  *SmokingAmountDay;

/**喝酒状态编号**/
@property (nonatomic, strong) NSString  *DrinkingStatusID;

/**喝酒状态名称**/
@property (nonatomic, strong) NSString  *DrinkingStatusName;

/**睡眠是否规律**/
@property (nonatomic, strong) NSString  *SleepRule;

/**长期服药**/
@property (nonatomic, strong) NSString  *LongMedication;

@end
