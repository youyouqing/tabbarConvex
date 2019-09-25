//
//  BaseWeatherSceneView.h
//  ParticleSystemDemo
//
//  Created by terrywang on 16/1/6.
//  Copyright © 2016年 iTerry.com All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @description 天气类型
 */
typedef NS_ENUM(NSUInteger, WeatherSceneType) {
    LightSnowScene = 0, //小雪
    MidSnowScene = 1,   //中雪
    HeavySnowScene = 2, //大雪
    
    HeavyRainScene = 3
};

@interface BaseWeatherSceneView : UIView
@property (nonatomic, strong) CAEmitterLayer *emitter;


/**
 @description 开始动画
 */
- (void)startSceneAnimation;

/**
 @description 停止动画
 */
- (void)stopSceneAnimation;

/**
 @description 初始化
 @param frame 天气动画视图frame
 @return 天气动画视图
 */
- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initEmitterWithFrame:(CGRect)frame;

/**
 @description 创建天气动画场景视图
 @param type 天气动画类型
 */
- (void)updateSceneWithSceneType:(WeatherSceneType)type imgName:(NSString *)imgName ;
@end
