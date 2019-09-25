//
//  DetailReportModel.h
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKReportOveralMod.h"

@interface DetailReportModel : NSObject
@property(nonatomic, strong)NSString *ExceptionContent;
@property(nonatomic, strong)NSString *ExceptionFlag;
@property(nonatomic, strong)NSString *ExceptionStatus;
@property(nonatomic, strong)NSString *KnowledgeSuggest;
@property(nonatomic, strong)NSString *SportSuggest;
@property(nonatomic, strong)NSString *DrinkSuggest;
@property(nonatomic, strong)NSString *ScoreTypeID;
@property(nonatomic, strong)NSString *TypeParameter;
@property(nonatomic, strong)NSString *PhysicalItemName;
@property(nonatomic, strong)NSString *HealthSuggest;
@property(nonatomic, strong)NSString *ReferenceValue;
@property(nonatomic, strong)NSString *ScoreTypeName;

/**检测项单位**/
@property (nonatomic,copy)NSString *PhysicalItemUnits;

@property(nonatomic, strong)NSArray *suggestArr;
@property(nonatomic, assign)NSInteger cellindex;


@property(nonatomic, strong)XKReportOveralMod  *reportOveralMod;
@end
