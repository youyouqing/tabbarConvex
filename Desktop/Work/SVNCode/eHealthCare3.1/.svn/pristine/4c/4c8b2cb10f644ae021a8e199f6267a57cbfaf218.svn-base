//
//  EPluseWeightView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalList.h"

@protocol EPluseWeightViewBloodPressureDelegate <NSObject>

- (void)EPluseWeightViewBloodPressurebuttonClick;

@end


@interface EPluseWeightView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *backViewTwo;

@property (weak, nonatomic) IBOutlet UIView *backViewThree;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *dataLabThree;

@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabThree;
@property (nonatomic, strong) NSArray *PhysicalMod;
@property (weak, nonatomic) IBOutlet UIButton *testTimeBtn;


@property (nonatomic, weak) id <EPluseWeightViewBloodPressureDelegate> delegate;


@end
