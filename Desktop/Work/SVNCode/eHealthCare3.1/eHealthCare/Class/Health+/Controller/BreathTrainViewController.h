//
//  BreathTrainViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/10/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BreathingTrainLevel){
    
    ///入门训练
    BreathingTrainLevelLow = 0,
    ///中级训练
    BreathingTrainLevelMiddle = 1,
    ///高级训练
    BreathingTrainLevelHigh = 2
};
@interface BreathTrainViewController : BaseViewController

@end
