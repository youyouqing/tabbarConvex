//
//  HealthKitTool.h
//  eHealthCare
//
//  Created by John shi on 2018/7/6.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportsStatisticsTool : NSObject

/**CoreMotion*/

///开始监测步数变化
//+ (void)startStepCount:(void(^)(float stepCount, float distance, float calories, NSError *error))completion;
//
/////停止监测步数变化数据
//+ (void)stopStepCount;
//
/////获取(从当日凌晨开始到当前时间段)运动步数、运动里程数以及卡里路。 备注：一次性获取
//+ (void)getSportsStatisticsMessage:(void(^)(float stepCount, float distance, float calories, NSError *error))completion;
//
///******************************************************************************************/
//
///**healthKit部分*///HealthKit是一个小时更新一次，不能及时更新  根据当前的需求，暂时不用HealthKit
/////查看是否具有访问HealthKit权限
//+ (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))completion;
//
/////获取步数
//+ (void)getStepCount:(void(^)(double value, NSError *error))completion;
//
/////获取公里数
//+ (void)getDistance:(void(^)(double value, NSError *error))completion;

@end


//示范：viewDidLoad 里调用此方法
//  [SportsStatisticsTool getSportsStatisticsMessage:^(float stepCount, float distance, float calories, NSError *error) {
//
//NSLog(@"行走步数：%f,距离数:%.2f,卡路里：%.2f",stepCount,distance,calories);
//dispatch_async(dispatch_get_main_queue(), ^{
//
//    self.phoneText.text = [NSString stringWithFormat:@"%.0f",stepCount];
//    self.codeText.text = [NSString stringWithFormat:@"%.2f",distance];
//
//});
//
//}];

//示范：viewWillAppear 里调用此方法
////开始实时更新
//[SportsStatisticsTool startStepCount:^(float stepCount, float distance, float calories, NSError *error) {
//
//    NSLog(@"😂😂😂😂😂😂😂😂😂😂😂😂😂😂😂");
//    NSLog(@"行走步数：%f,距离数:%.2f,卡路里：%.2f",stepCount,distance,calories);
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        self.phoneText.text = [NSString stringWithFormat:@"%.0f",stepCount];
//        self.codeText.text = [NSString stringWithFormat:@"%.2f",distance];
//
//    });
//
//}];
