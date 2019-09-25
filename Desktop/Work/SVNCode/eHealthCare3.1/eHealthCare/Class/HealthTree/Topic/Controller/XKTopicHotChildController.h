//
//  XKTopicHotChildController.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHealthPlanModel.h"

@interface XKTopicHotChildController : BaseViewController

@property (nonatomic,strong) XKHealthPlanModel *model;

/**
 话题类型数组
 */
@property (nonatomic,strong) NSArray *typeArray;
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf;
@end
