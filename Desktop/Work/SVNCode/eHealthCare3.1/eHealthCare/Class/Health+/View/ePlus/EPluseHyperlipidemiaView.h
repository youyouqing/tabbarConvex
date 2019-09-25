//
//  EPluseHyperlipidemiaView.h
//  eHealthCare
//
//  Created by John shi on 2019/3/1.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalList.h"
NS_ASSUME_NONNULL_BEGIN

@protocol EPluseHyperlipidemiaViewDelegate <NSObject>

- (void)EPluseHyperlipidemiaViewGotestbuttonClick;

@end



@interface EPluseHyperlipidemiaView : UIView
@property (nonatomic, strong) NSArray *PhysicalMod;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, weak) id <EPluseHyperlipidemiaViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *backViewTwo;

@property (weak, nonatomic) IBOutlet UIView *backViewThree;

@property (weak, nonatomic) IBOutlet UIView *backViewFour;
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *FourDataLab;
@property (weak, nonatomic) IBOutlet UILabel *TwoLab;
@property (weak, nonatomic) IBOutlet UILabel *ThreeDataLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *dataLabThree;
@property (weak, nonatomic) IBOutlet UILabel *dataLabFour;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabThree;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabFour;
@property (weak, nonatomic) IBOutlet UIButton *testTimeBtn;

@end

NS_ASSUME_NONNULL_END
