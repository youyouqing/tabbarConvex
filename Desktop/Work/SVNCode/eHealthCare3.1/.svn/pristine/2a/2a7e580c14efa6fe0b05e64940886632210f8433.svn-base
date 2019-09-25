//
//  XKWeatherScene.h
//  eHealthCare
//
//  Created by xiekang on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKWeatherScene : UIImageView

- (instancetype)initEmitterWithFrame:(CGRect)frame  type:(NSInteger)type imageName:(NSString *)imageName;

-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x;

#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time;

/**
 浮动动画  树叶飘落

 @param image 背景图片
 */
-(void)animateFloat:(NSString *)imageName floatImagetwo:(NSString *)imageTwoName bgImage:(UIImageView *)image  rotate:(BOOL)rotate;

- (void)pauseAnimation ;

- (void)resumeAnimation ;

@end
