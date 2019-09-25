//
//  StepModel.m
//  eHealthCare
//
//  Created by jamkin on 16/9/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "StepModel.h"

@implementation StepModel

-(void)setCreateTime:(long)CreateTime{
    
    _CreateTime = CreateTime;
    
    self.completeDate = [self loadTime:CreateTime];
    self.weekDay = [self loadTime2:CreateTime];
    self.dayTime = [self loadTime3:CreateTime];
    
}

/**通过时间戳返回完整的日期**/
-(NSString *)loadTime:(long)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"MM月dd日"];
    
    return timeStr;
    
}

/**通过时间戳返回今日是周几**/
-(NSString *)loadTime2:(long)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"EEE"];
    
    return timeStr;
    
}

/**通过时间戳返回今日是多少号**/
-(NSString *)loadTime3:(long)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"dd"];
    
    return timeStr;
    
}

@end
