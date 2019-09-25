//
//  XKManualInputView.h
//  PlayerTest
//
//  Created by xiekang on 2017/10/18.
//  Copyright © 2017年 ZM. All rights reserved.
//携康3.0居家检测手动输入共用页面

#import <UIKit/UIKit.h>
#import "XKDectingViewController.h"
typedef enum : NSUInteger {
    XKNormalStyle , //
    XKBloodFatStyleFill, //
    XKBloodPressureStyleFill,
} XKToolStyle;
@protocol XKManualInputViewDelegate <NSObject>
-(void)selectIndex:(NSString *)title manualText:(NSString *)manualText manualTwoText:(NSString *)manualTwoText manualThreeText:(NSString *)manualThreeText manualFourText:(NSString *)manualFourText sugarTag:(NSInteger)sugarTag;


-(void)checkClick:(float )num1  num:(NSInteger)num heart:(float)heart maxNum1:(float)maxNum1 maxNum2:(float)maxNum2 minPoint1:(float)minPoint1 minPoint2:(float)minPoint2 mealBeforeOrAfter:(NSInteger)mealBeforeOrAfter manual:(BOOL)manual;
@end
@interface XKManualInputView : UIView

@property(assign,nonatomic)XKToolStyle toolStyle;
@property(assign,nonatomic)XKDetectStyle style;

@property(weak,nonatomic)id<XKManualInputViewDelegate>delegate;

@end
