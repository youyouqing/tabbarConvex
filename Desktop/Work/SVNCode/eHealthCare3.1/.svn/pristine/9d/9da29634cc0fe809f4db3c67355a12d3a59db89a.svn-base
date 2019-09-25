//
//  WeatherSceneManager.m
//  ParticleSystemDemo
//
//  Created by terrywang on 16/1/6.
//  Copyright © 2016年 iTerry.com All rights reserved.
//

#import "WeatherSceneManager.h"
#import "XKWeatherScene.h"
#import "SnowSceneView.h"

/*
 天气动画场景
 */
@interface WeatherSceneManager ()
@property (nonatomic, strong) BaseWeatherSceneView *sceneView;//当前显示的动画视图


@property (nonatomic, strong) XKWeatherScene *weatherSceneView;//当前显示的动画视图
@end

@implementation WeatherSceneManager

+ (WeatherSceneManager *)sharedSceneManager {
    static WeatherSceneManager *sharedSceneManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSceneManager = [[WeatherSceneManager alloc] init];
    });
    return sharedSceneManager;
}

- (BaseWeatherSceneView *)showWeatherSceneWithFrame:(CGRect)frame weatherType:(WeatherSceneType)type imgName:(NSString *)imgName{
    
    
    //根据天气动画类型创建天气动画view
    _sceneView = [[SnowSceneView alloc] initEmitterWithFrame:frame];
    [_sceneView updateSceneWithSceneType:type imgName:imgName];
    
    return _sceneView;
}
- (XKWeatherScene *)showWeatherWithFrame:(CGRect)frame weatherType:(NSInteger)type imgName:(NSString *)imgName{
    
    
    _weatherSceneView = [[XKWeatherScene alloc] initEmitterWithFrame:frame type:type imageName:imgName];
    
    return _weatherSceneView;
}
//开始动画
- (void)startWeatherSceneAnimation {
    if (_sceneView) {
        [_sceneView startSceneAnimation];
    }
}


//暂停动画
- (void)stopWeatherSceneAnimation {
    if (_sceneView) {
        [_sceneView stopSceneAnimation];
    }
}

//删除动画视图
- (void)removeSceneView {
    if (_sceneView) {
        [_sceneView removeFromSuperview];
        _sceneView = nil;
    }
}

//根据天气编号ID获取天气动画类型
- (WeatherSceneType)sceneTypeByWeatherId:(NSInteger)weatherId {
    switch (weatherId) {
        case 1:
            return MidSnowScene;
            break;
        case 2:
            return LightSnowScene;
            break;
        case 3:
            return HeavySnowScene;
            break;
        default:
            break;
    }
    
    return LightSnowScene;
}

@end
