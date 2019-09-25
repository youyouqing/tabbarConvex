//
//  HealthRecordViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/11/3.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthRecordViewModel : NSObject
///获取用户个人档案信息
+ (void)getRecordResultDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;

/**
 获取个人档案相关字典

 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+ (void)editRecordResultDataWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
+ (void)getRecordFamilyPersonWithParmas:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;

+ (void)getHealthRecordHomeResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
//提醒家人
+ (void)getRecordRemindFamilyPersonWithParmas:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
/**
 获取健康档案首页上半部分查看今天健康记录148
 
 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+(void)getTopRecordDataResultWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
@end
