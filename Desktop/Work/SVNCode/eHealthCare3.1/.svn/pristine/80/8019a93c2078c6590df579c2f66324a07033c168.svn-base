//
//  EPluseSugarDetailView.h
//  eHealthCare
//
//  Created by John shi on 2019/3/1.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalList.h"
NS_ASSUME_NONNULL_BEGIN



@protocol EPluseSugarDetailViewDelegate <NSObject>

- (void)EPluseSugarDetailViewbuttonClick:(NSInteger)sugarCondition;

@end



@interface EPluseSugarDetailView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, weak) id <EPluseSugarDetailViewDelegate> delegate;

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
@property (weak, nonatomic) IBOutlet UIButton *testTwoTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *testThreeTimeBtn;
@end

NS_ASSUME_NONNULL_END
