//
//  StepTool.m
//  eHealthCare
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StepTool.h"
#import <CoreMotion/CoreMotion.h>

@interface StepTool ()

@property (nonatomic, strong) CMPedometer *pedometer;

@property (nonatomic,strong) NSMutableArray *timeStepArray;

@end

@implementation StepTool

- (CMPedometer *)pedometer
{
    if (_pedometer == nil) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    return _pedometer;
}

-(void)updateBeforeDataToService{
    
    self.saccount=@"0";
    
    self.timeStepArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self getOnedayStep:[self takeTime:1] count:1 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self getOnedayStep:[self takeTime:2] count:2 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self getOnedayStep:[self takeTime:3] count:3 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self getOnedayStep:[self takeTime:4] count:4 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self getOnedayStep:[self takeTime:5] count:5 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self getOnedayStep:[self takeTime:6] count:6 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self getOnedayStep:[self takeTime:7] count:7 success:^(id json, NSInteger count1) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            [self.timeStepArray addObject:json];
            
            self.saccount=[NSString stringWithFormat:@"%li",count1];
        }
        
    }];
    
    [self addObserver:self forKeyPath:@"saccount" options:NSKeyValueObservingOptionNew context:nil];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"变化了%@",change);
    
//    NSInteger count=[change[@"new"] integerValue];
    
    if (self.timeStepArray.count==6) {
        
        NSDateFormatter *matter=[[NSDateFormatter alloc]init];
        [matter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *todayDateStr = [matter stringFromDate:[NSDate date]];
        
        NSString *history=[[NSUserDefaults standardUserDefaults]objectForKey:@"isHistory"];
        
        if (history.length==0 || ![history isEqualToString:todayDateStr]) {
            
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"338" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"HistoryStepList":self.timeStepArray} success:^(id json) {
                
                NSLog(@"返回的数据%@",json);
                
                if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                    
                    [[NSUserDefaults standardUserDefaults]setObject:@"isHistory" forKey:todayDateStr];
                    
                    NSLog(@"上传记录步数成功");
                    
                }else{
                    
                    NSLog(@"上传记录步数失败");
                }
                
            } failure:^(id error) {
                NSLog(@"%@---上传记录步数失败",error);
                
            }];
            
        }
        
    }
    
    NSLog(@"这是数组的大小%li",self.timeStepArray.count);
    
}

NSString *distanceStr1;
NSString *distanc1;
float dis1;
int steps1;

-(void)getOnedayStep:(NSDate *)date count:(NSInteger)count success:(void (^)(id json,NSInteger count1))succes{
    // 1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable]) {
        succes(@"没有获取到数据",0);
        return;
    }

    //统计某天的
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *todayDateStr = [dateFormatter stringFromDate:date];

    NSString *beginDateStr = [todayDateStr stringByAppendingString:@"-00-00-00"];
    
    NSString *endDateStr = [todayDateStr stringByAppendingString:@"-23-59-59"];

    //字符转日期
    NSDateFormatter *beginDateFormatter = [[NSDateFormatter alloc] init];
    [beginDateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    
    NSDate *beginDate = [beginDateFormatter dateFromString:beginDateStr];
    
    NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc] init];
    [beginDateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];

    NSDate *endDate = [beginDateFormatter dateFromString:endDateStr];
    
    [self.pedometer queryPedometerDataFromDate:beginDate toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error) {
            
            //            NSLog(@"%@",error);
            
            return;
        }
        
        //距离字符串
        distanceStr1 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
        
        distanc1=[NSString stringWithFormat:@"%@",pedometerData.distance];
        dis1=[distanc1 floatValue];
        
        steps1 = [distanceStr1 intValue];
        
        NSDictionary *dict=@{@"CreateTime":todayDateStr,@"StepCount":@(steps1),@"KilometerCount":@(dis1/1000),@"KilocalorieCount":@(dis1/1000*65)};
        succes(dict,count);
    }];
    
//    [self.pedometer startPedometerUpdatesFromDate:beginDate withHandler:^(CMPedometerData *pedometerData, NSError *error) {
//
//        if (error) {
//
//            //            NSLog(@"%@",error);
//
//            return;
//        }
//
//        //距离字符串
//        distanceStr1 = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
//        
//        distanc1=[NSString stringWithFormat:@"%@",pedometerData.distance];
//        dis1=[distanc1 floatValue];
//
//        steps1 = [distanceStr1 intValue];
//        
//        NSDictionary *dict=@{@"CreateTime":todayDateStr,@"StepCount":@(steps1),@"KilometerCount":@(dis1/1000),@"KilocalorieCount":@(dis1/1000*65)};
//        succes(dict,count);
//
//    }];

}

-(NSDate *)takeTime:(NSInteger)day{
    
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:-day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    
    return newdate;
    
}



@end