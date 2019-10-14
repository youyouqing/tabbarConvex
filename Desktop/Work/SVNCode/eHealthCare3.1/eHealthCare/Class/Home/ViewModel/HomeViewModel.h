//
//  MainViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/31.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject


/**
 获取首页热门话题以及进行中健康计划

 @param finish 请求回调
 */
+ (void)getHotTopicHealthPlanAndMoreWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 获取首页健康自测 试题题库

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getHealthTestWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;



/**
 获取话题分类或资讯分类或健康计划分类

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getTopicCategoryOrInformationCategoryOrHealthPlanCategoryWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


+ (void)gethometree_getHomeResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;


+ (void)gethomeAppointmentResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
@end