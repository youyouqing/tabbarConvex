//
//  WebProgress.m
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "WebProgress.h"
#import "NSTimer+addition.h"

static NSTimeInterval const kFastTimeInterval = 0.03;

@implementation WebProgress
{
    CAShapeLayer *_layer;
    
    NSTimer *_timer;
    CGFloat _plusWidth; ///< 增加点
}
+ (instancetype)layerWithFrame:(CGRect)frame {
    WebProgress *progress = [self new];
    progress.frame = frame;
    
    return progress;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.anchorPoint = CGPointMake(0, 0.5);
    self.lineWidth = 2;
    
    self.strokeColor = MainCOLOR.CGColor;
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer wy_scheduledTimerWithTimeInterval:kFastTimeInterval repeats:YES block:^(NSTimer *timer) {
        [weakSelf pathChanged:timer];
    }];
    [_timer pause];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(KScreenWidth, 2)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.01;
}


- (void)pathChanged:(NSTimer *)timer {
    if (self.strokeEnd >= 0.97) {
        [_timer pause];
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd += _plusWidth;
    
    if (self.strokeEnd > 0.8) {
        _plusWidth = 0.001;
    }
    [CATransaction commit];
}

- (void)startLoad {
    [_timer resumeWithTimeInterval:kFastTimeInterval];
}

- (void)finishedLoad {
    [self closeTimer];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd = 1.0;
    [CATransaction commit];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
}

- (void)dealloc {
    NSLog(@"progressView dealloc");
    [self closeTimer];
}

#pragma mark - private
- (void)closeTimer {
    [_timer invalidate];
    _timer = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
