//
//  RemindModel.h
//  eHealthCare
//
//  Created by John shi on 2018/11/26.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject
@property (nonatomic,assign)NSInteger IsWaterRemind;

/**
 IsWorkRemind
 */
@property (nonatomic,assign)NSInteger IsWorkRemind;


@property (nonatomic,assign)NSInteger IsMedicineRemind;



@property (nonatomic,assign)NSInteger IsHealthPlanRemind;



@property (nonatomic,assign)NSInteger IsHealthTreeRemind;

@end
