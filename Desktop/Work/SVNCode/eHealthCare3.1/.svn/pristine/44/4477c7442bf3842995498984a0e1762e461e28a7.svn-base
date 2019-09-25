//
//  NSTimer+addition.h
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

+ (NSTimer *)wy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block;

#pragma mark 自定义 倒计时转圈圈按钮 那边使用
+ (NSTimer *)at_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

- (void)pauseTimer;
- (void)resumeTimer;
- (void)stopTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
