//
//  RunningView.h
//  RCSports
//
//  Created by liveidzong on 9/21/16.
//  Copyright © 2016 SBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSpLongGestureStopBtn.h"
typedef NS_ENUM(NSInteger,RunningViewCommonType){
    RunningTypeMinute = 1,//时钟倒计时
    RunningTypeKilometer = 2,
};

@protocol XKRunAndHideViewDelegate <NSObject>
@optional;
/**
 开始计时
 */
- (void)lockOrunLockBtn;

- (void)suspendOrunKeep:(BOOL)keep;

-(void)stopActionBtn;

-(void)enterTrendPage;
@end
@interface RunningView : UIView
/**
 点击进入地图按钮
 */
@property(nonatomic,weak)IBOutlet UIButton *mapButton;
@property (nonatomic,strong) UILabel *distanceLB;
@property (nonatomic,strong) UILabel *timeLB;//配速
@property (nonatomic,strong) UILabel *runDistanceLB;
@property(nonatomic,weak)IBOutlet UIView *timeBackView;
@property (nonatomic, strong) UILabel *minuteCountLab;//倒计时显示
@property (nonatomic)id<XKRunAndHideViewDelegate> delegate;
@property(nonatomic,weak)IBOutlet UIImageView *imageBack ;

/**继续  结束。 两边的距离*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnSpace;

/**继续按钮*/
@property (weak, nonatomic) IBOutlet UIButton *keepGoBtn;
/**长按结束按钮*/
@property (weak, nonatomic) IBOutlet XKSpLongGestureStopBtn *stopBtn;
/**开始按钮 */
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *keepLab;
@property (weak, nonatomic) IBOutlet UILabel *pauseLab;
@property (weak, nonatomic) IBOutlet UILabel *endLab;

@property (nonatomic,strong) UILabel *unitLabel;//目标分钟的显示
@property (nonatomic,strong) UILabel *unit4Time;//平均配速
- (void)updateProgressCircle:(float)progress;
@property(assign,nonatomic)RunningViewCommonType runDesMinute;
@end