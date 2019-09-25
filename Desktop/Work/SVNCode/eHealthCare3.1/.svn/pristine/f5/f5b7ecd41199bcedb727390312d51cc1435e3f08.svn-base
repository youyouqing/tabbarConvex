//
//  CountdownButton.h
//  eHealthCare
//
//  Created by John shi on 2018/7/19.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//倒计时转圈圈的按钮

#import <UIKit/UIKit.h>

@interface CountdownButton : UIButton

@property (nonatomic, strong) UIColor *progressColor;          //进度条颜色
@property (nonatomic, strong) UIColor *progressTrackColor;     //进度条轨道颜色
@property (nonatomic, assign) CGFloat progressWidth;           //进度条宽度

/**
 开始进度条动画
 
 @param duration 进度条时间
 @param block 以0.1s的粒度返回当前已经走过的时间
 @param completion 是否结束 (YES,时间到自动结束； NO,stop方法触发结束)
 */
- (void)startWithDuration:(CGFloat)duration block:(void (^)(CGFloat time))block completion:(void (^ __nullable)(BOOL finished))completion;

- (void)pause;           //暂停

- (void)resume;          //继续

- (void)stop;            //停止

@end
