//
//  WebProgress.h
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WebProgress : CAShapeLayer

+ (instancetype)layerWithFrame:(CGRect)frame;

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
