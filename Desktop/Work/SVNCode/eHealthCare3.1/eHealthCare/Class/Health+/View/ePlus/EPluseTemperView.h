//
//  EPluseTemperView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysicalList.h"
@interface EPluseTemperView : UIView
{
    UILabel *circlelabel;
    
}
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *TemperatureImage;
@property (weak, nonatomic) IBOutlet UIView *TempertureBackView;

@property (weak, nonatomic) IBOutlet UILabel *testTimeLab;
@property (strong, nonatomic)  UIImageView *circle;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (nonatomic, strong) NSArray *PhysicalMod;
@end
