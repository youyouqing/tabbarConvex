//
//  HealthTestHeadView.h
//  eHealthCare
//
//  Created by John shi on 2018/8/3.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthTestHeadViewDelegate <NSObject>


/**
 讲按钮的点击事件传递过去

 @param buttonIndex 从0 - 8 分别代表了 亚健康、日常行为、健商、体质检测、视力、色觉、柔韧度、挥拳
 */
- (void)buttonClickAtIndex:(NSInteger)buttonIndex;

@end

@interface HealthTestHeadView : UIView

@property (nonatomic, weak) id <HealthTestHeadViewDelegate> delegate;

@end
