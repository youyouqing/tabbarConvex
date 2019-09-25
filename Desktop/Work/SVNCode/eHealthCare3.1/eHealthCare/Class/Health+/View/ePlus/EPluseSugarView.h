//
//  EPluseSugarView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalList.h"
@interface EPluseSugarView : UIView
@property (weak, nonatomic) IBOutlet UIView *trajecView;

@property (weak, nonatomic) IBOutlet UIView *trajecViewTwo;


@property (weak, nonatomic) IBOutlet UIView *trajecViewThree;


@property (weak, nonatomic) IBOutlet UIView *smTrajectView;
@property (weak, nonatomic) IBOutlet UIView *smTrajectViewTwo;
@property (weak, nonatomic) IBOutlet UIView *smTrajectViewThree;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewTwoWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trajectViewThreeWidth;
@property (weak, nonatomic) IBOutlet UIView *backView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranLabCenterX;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranTwoLabCenterX;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranThreeLabCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranFourLabCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranFiveLabCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smTranSixLabCenterX;

@property (nonatomic, strong) NSArray *PhysicalMod;
@property (nonatomic, assign) BOOL isSugar;
@end
