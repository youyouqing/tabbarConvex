//
//  XKSportsAcountModel.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSportsAcountModel.h"

@implementation XKSportsAcountModel

-(void)setCreateTime:(long)CreateTime{
    
    _CreateTime = CreateTime;
    
    self.markTime = [self loadTime2:_CreateTime];
        
}

/**通过时间戳返回时间**/
-(NSString *)loadTime2:(long)time{
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",time]] withFormat:@"MM-dd"];
    
    return timeStr;
    
}

@end