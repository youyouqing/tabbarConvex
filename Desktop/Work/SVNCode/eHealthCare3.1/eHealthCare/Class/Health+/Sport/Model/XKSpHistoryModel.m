//
//  XKSpHistoryModel.m
//  eHealthCare
//
//  Created by xiekang on 2017/9/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSpHistoryModel.h"

@implementation XKSpHistoryModel
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)otherDay;
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:otherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    //    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"时间1快了");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"时间1慢了");
        return -1;
    }
    //NSLog(@"两个时间相等");
    return 0;
    
}

-(void)setCreateTime:(long)CreateTime{
    
    _CreateTime = CreateTime;
    self.strTime = [self loadTime2:CreateTime];
    self.rankTime = [self loadTime1:CreateTime];
}

/**通过时间戳返回时间**/
-(NSString *)loadTime2:(long)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"yyyy年MM月dd日"];
    
    return timeStr;
    
}
-(NSString *)loadTime1:(long)time{
    Dateformat *dateFor = [[Dateformat alloc] init];
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"yyyy年MM月"];
    return timeStr;
}
@end
