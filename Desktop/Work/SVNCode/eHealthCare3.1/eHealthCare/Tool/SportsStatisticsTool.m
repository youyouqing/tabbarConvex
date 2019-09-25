//
//  HealthKitTool.m
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SportsStatisticsTool.h"

//#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>
#import <CoreMotion/CoreMotion.h>

static CMPedometer *_pedonmeter;//CoreMotion

//static HKHealthStore *_healthStore;//HealthKit

#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.sdqt.healthError"

@implementation SportsStatisticsTool

#pragma mark CoreMotion
//+ (void)getSportsStatisticsMessage:(void(^)(float stepCount, float distance, float calories, NSError *error))completion
//{
//    _pedonmeter = [[CMPedometer alloc] init];
//    if ([CMPedometer isStepCountingAvailable]) {
//        
//        //设置起始时间为当天凌晨
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        NSDate *now = [NSDate date];
//        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
//        NSDate *startDate = [calendar dateFromComponents:components];
//        
//        [_pedonmeter queryPedometerDataFromDate:startDate toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//            
//            if (error)
//            {
//                NSLog(@"error===%@",error);
//                completion(0,0,0,error);
//            }
//            else {
//                NSLog(@"步数===%@",pedometerData.numberOfSteps);
//                NSLog(@"距离===%@",pedometerData.distance);
//                
//                //这里的距离单位是米，我们需要转换为公里数
//                completion([pedometerData.numberOfSteps floatValue],[pedometerData.distance floatValue] / 1000,[pedometerData.distance floatValue] / 1000 * 65,error);
//            }
//            
//        }];
//    
//    }else{
//        NSLog(@"不可用===");
//    }
//}

//+ (void)startStepCount:(void(^)(float stepCount, float distance, float calories, NSError *error))completion
//{
//    //设置起始时间为当天凌晨
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *now = [NSDate date];
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
//    NSDate *startDate = [calendar dateFromComponents:components];
//
//    [_pedonmeter startPedometerUpdatesFromDate:startDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//
//        if (error)
//        {
//            NSLog(@"error===%@",error);
//            completion(0,0,0,error);
//        }
//        else {
//            NSLog(@"步数===%@",pedometerData.numberOfSteps);
//            NSLog(@"距离===%@",pedometerData.distance);
//
//            //这里的距离单位是米，我们需要转换为公里数
//            completion([pedometerData.numberOfSteps floatValue],[pedometerData.distance floatValue] / 1000,[pedometerData.distance floatValue] / 1000 * 65,error);
//        }
//
//    }];
//}

//+ (void)stopStepCount
//{
//    [_pedonmeter stopPedometerUpdates];
//}
//
//#pragma mark HealthKit
//+ (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))completion
//{
//    if(HKVersion >= 8.0)
//    {
//        if (![HKHealthStore isHealthDataAvailable]) {
//            NSError *error = [NSError errorWithDomain: @"com.raywenderlich.tutorials.healthkit" code: 2 userInfo: [NSDictionary dictionaryWithObject:@"HealthKit is not available in th is Device"                                                                      forKey:NSLocalizedDescriptionKey]];
//            if (completion != nil) {
//                completion(false, error);
//            }
//            return;
//        }
//        if ([HKHealthStore isHealthDataAvailable]) {
//            if(_healthStore == nil)
//                _healthStore = [[HKHealthStore alloc] init];
//            /*
//             组装需要读写的数据类型
//             */
//            NSSet *writeDataTypes = [self dataTypesToWrite];
//            NSSet *readDataTypes = [self dataTypesRead];
//
//            /*
//             注册需要读写的数据类型，也可以在“健康”APP中重新修改
//             */
//            [_healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
//
//                if (completion != nil) {
//                    NSLog(@"error->%@", error.localizedDescription);
//                    completion (success, error);
//                }
//            }];
//        }
//    }
//    else {
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"iOS 系统低于8.0"                                                                      forKey:NSLocalizedDescriptionKey];
//        NSError *aError = [NSError errorWithDomain:CustomHealthErrorDomain code:0 userInfo:userInfo];
//        completion(0,aError);
//    }
//}
//
//
/////获取步数
//+ (void)getStepCount:(void(^)(double value, NSError *error))completion
//{
//    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
//
//    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
//    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:[self predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
//        if(error)
//        {
//            completion(0,error);
//        }
//        else
//        {
//            NSInteger totleSteps = 0;
//            for(HKQuantitySample *quantitySample in results)
//            {
//                HKQuantity *quantity = quantitySample.quantity;
//                HKUnit *heightUnit = [HKUnit countUnit];
//                double usersHeight = [quantity doubleValueForUnit:heightUnit];
//                totleSteps += usersHeight;
//            }
//            NSLog(@"当天行走步数 = %ld",(long)totleSteps);
//            completion(totleSteps,error);
//        }
//    }];
//
//    [_healthStore executeQuery:query];
//}
//
/////获取公里数
//+ (void)getDistance:(void(^)(double value, NSError *error))completion
//{
//    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
//    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[self predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
//
//        if(error)
//        {
//            completion(0,error);
//        }
//        else
//        {
//            double totleSteps = 0;
//            for(HKQuantitySample *quantitySample in results)
//            {
//                HKQuantity *quantity = quantitySample.quantity;
//                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
//                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
//                totleSteps += usersHeight;
//            }
//            NSLog(@"当天行走距离 = %.2f",totleSteps);
//            completion(totleSteps,error);
//        }
//    }];
//    [_healthStore executeQuery:query];
//}
//
////写权限
//+ (NSSet *)dataTypesToWrite
//{
//    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
//    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
//    HKQuantityType *temperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
//    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
//
//    return [NSSet setWithObjects:heightType, temperatureType, weightType,activeEnergyType,nil];
//}
//
////读权限
//+ (NSSet *)dataTypesRead
//{
//    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
//    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
//    HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
//    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
//    HKCharacteristicType *sexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
//    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
//
//    return [NSSet setWithObjects:heightType, temperatureType,birthdayType,sexType,weightType,stepCountType, distance, activeEnergyType,nil];
//}
//
///*!
// *  @brief  当天时间段
// *
// *  @return 时间段
// */
//+ (NSPredicate *)predicateForSamplesToday {
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *now = [NSDate date];
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
//    [components setHour:0];
//    [components setMinute:0];
//    [components setSecond: 0];
//
//    NSDate *startDate = [calendar dateFromComponents:components];
//    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
//    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
//    return predicate;
//}


@end
