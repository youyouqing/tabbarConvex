//
//  MusicTrainViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/24.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicTrainViewModel : NSObject


/**
 健康+ 上传用户行为记录

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)updateUseBehaviorWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



/**
 健康+ 获取早晚安与正念列表

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getMorningEverningAndMindfulnessListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 获取E加首页信息（用户当日健康基本信息以及最近一次体检信息）

 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+ (void)getEPluseListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 设置用户心情

 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+ (void)setUserMoodWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



/**
 用户心情

 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+ (void)getUserMoodWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;
@end
