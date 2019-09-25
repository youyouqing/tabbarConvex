//
//  PersonalArcModel.m
//  eHealthCare
//
//  Created by xiekang on 16/8/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonalArcModel.h"

@implementation PersonalArcModel

-(NSString *)description{
    
    NSDictionary *dict=[self properties_aps];
    
    return [NSString stringWithFormat:@"你是逗逼吗%@",dict];
    
}

- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

@end
