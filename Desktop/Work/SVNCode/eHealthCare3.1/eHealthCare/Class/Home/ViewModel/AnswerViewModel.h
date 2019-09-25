//
//  AnswerViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/8/7.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerViewModel : NSObject


/**
 获取测试试题

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getTestQuestionWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 上传测试结果

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)uploadTestResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 获取体质检测试题

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getPhysicalTestingDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 上传体质测试结果

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)uploadPhysicalTestResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;


/**
 获取体质检测结果

 @param dic 请求参数
 @param finish 请求回调
 */
+ (void)getPhysicalTestResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

@end
