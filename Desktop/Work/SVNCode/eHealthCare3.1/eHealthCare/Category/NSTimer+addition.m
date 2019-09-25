//
//  NSTimer+addition.m
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

- (void)pause
{
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume
{
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time
{
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

+ (NSTimer *)wy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block
{
    
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(timeFired:) userInfo:block repeats:yesOrNo];
}

+ (void)timeFired:(NSTimer *)timer
{
    void(^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

#pragma mark 自定义 倒计时转圈圈按钮 那边使用
+ (void)_yy_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)at_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_yy_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

- (void)pauseTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)stopTimer {
    if (!([self isValid])) {
        return;
    }
    [self invalidate];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
