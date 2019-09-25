//
//  TrendSuggestModel.h
//  eHealthCare
//
//  Created by xiekang on 16/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendSuggestModel : NSObject
@property (nonatomic,strong) NSString *SportSuggest;
@property (nonatomic,strong) NSString *DrinkSuggest;
@property (nonatomic,strong) NSString *HealthSuggest;
@property (nonatomic,strong) NSString *KnowledgeSuggest;
@property (nonatomic,assign) NSInteger Status;

@property (nonatomic,strong) NSString *PhysicalItemNameOne;
@property (nonatomic,strong) NSString *PhysicalItemNameTwo;
@property (nonatomic,strong) NSString *PhysicalItemUnitOne;
@property (nonatomic,strong) NSString *PhysicalItemUnitTwo;


@property (nonatomic,copy) NSString *ReferenceValue;

@end
