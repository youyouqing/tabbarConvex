//
//  EPluseWeightQView.h
//  eHealthCare
//
//  Created by John shi on 2019/3/5.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalList.h"
NS_ASSUME_NONNULL_BEGIN

@interface EPluseWeightQView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (nonatomic, strong) NSArray *PhysicalMod;

@property (weak, nonatomic) IBOutlet UILabel *testTimeLab;
@end

NS_ASSUME_NONNULL_END
