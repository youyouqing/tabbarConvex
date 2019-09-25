//
//  XKSportsHomeModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/9/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSportsTypeModel.h"
#import "XKSportsAcountModel.h"
#import "XKRecommendedWikiModel.h"

@interface XKSportsHomeModel : NSObject


/**
 当天步数、总跑步公里数总骑行公里数列表
 */
@property (nonatomic,strong) NSArray *modelList;

/**
 最近7条步数记录列表
 */
@property (nonatomic,strong) NSArray *TopList;

/**
 健康资讯列表
 */
@property (nonatomic,strong) NSArray *WikiList;

@end
