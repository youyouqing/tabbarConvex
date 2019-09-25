//
//  BreathSlider.h
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
//title显示在滑块的上方或下方
typedef enum : NSUInteger{
    TopTitleStyle,
    BottomTitleStyle
}TitleStyle;
@interface BreathSlider : UISlider
@property (nonatomic,assign) int lineWidth;
@property (nonatomic,setter=changeAngle:) CGPoint angle;
//是否分。还是。秒
@property (nonatomic,assign) BOOL isMinute;
@property (nonatomic,assign) TitleStyle titleStyle;
@property(nonatomic, strong) UILabel *sliderValueLabel;//滑块下面的值
@end
