//
//  XKHealthIntegralKTrendModel.m
//  eHealthCare
//
//  Created by mac on 2017/10/26.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本k值趋势实体类

#import "XKHealthIntegralKTrendModel.h"

@implementation XKHealthIntegralKTrendModel

-(void)setCreateTime:(long)CreateTime{
    _CreateTime = CreateTime;
    self.strTime = [self loadTime:CreateTime];
    self.strTime1 = [self loadTime1:CreateTime];
    self.strTime2 = [self loadTime2:CreateTime];
}

/**通过时间戳返回时间**/
-(NSString *)loadTime:(long)time{
    Dateformat *dateFor = [[Dateformat alloc] init];
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"MM/dd"];
    return timeStr;
}

/**通过时间戳返回时间**/
-(NSString *)loadTime1:(long)time{
    Dateformat *dateFor = [[Dateformat alloc] init];
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"yyyy-MM-dd"];
    return timeStr;
}
-(NSString *)loadTime2:(long)time{
    Dateformat *dateFor = [[Dateformat alloc] init];
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"yyyy"];
    return timeStr;
}
@end
