//
//  PlanDirectoryView.h
//  eHealthCare
//
//  Created by John shi on 2018/8/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChoseIndexOfDayBlock)(NSString *planDetailID);

@interface PlanDirectoryView : UIView

///数据源
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) ChoseIndexOfDayBlock choseBlock;

@end
