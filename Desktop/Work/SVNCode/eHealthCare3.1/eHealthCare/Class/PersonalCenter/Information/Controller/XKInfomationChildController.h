//
//  XKInfomationChildController.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHealthPlanModel.h"
@interface XKInfomationChildController : BaseViewController
@property(strong,nonatomic) XKHealthPlanModel *model;
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf;
@end