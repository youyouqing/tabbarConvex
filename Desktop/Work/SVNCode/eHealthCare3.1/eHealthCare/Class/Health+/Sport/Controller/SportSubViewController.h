//
//  SportSubViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSportsHomeModel.h"
#import "StepModel.h"
@interface SportSubViewController : BaseViewController
/**
 首页数据模型属性
 */
@property (nonatomic,strong) XKSportsTypeModel *homeModel;
@property (nonatomic,strong) XKSportsHomeModel *SportsHomeModel;
@property (nonatomic, assign) NSInteger type;


@property (nonatomic, copy) void(^backStepBlock)(StepModel *stepM);
@end
