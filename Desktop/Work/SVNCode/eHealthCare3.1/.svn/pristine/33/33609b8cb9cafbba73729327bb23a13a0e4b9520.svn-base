//
//  NSDictionary+SafeCategory.m
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "NSDictionary+SafeCategory.h"

@implementation NSDictionary (SafeCategory)

+ (id)dictionaryWithObjectSafe:(id)object forKey:(id<NSCopying>)key
{
    if (!key || !object)
    {
        return nil;
    }
    return [self dictionaryWithObject:object forKey:key];
}
- (id)objectForKeySafe:(id)aKey
{
    if (!aKey)
    {
        return nil;
    }
    return [self objectForKey:aKey];
}


- (NSString*)stringForKeySafe:(id)aKey
{
    NSString *value=[self objectForKeySafe:aKey];
    
    if (value &&! [value isKindOfClass:[NSNull class]])
    {
        if ([value isKindOfClass:[NSString class]])
        {
            return value;
            
        }else if ([value isKindOfClass:[NSNumber class]])
        {
            return [NSString stringWithFormat:@"%@",value];
        }
        return nil;
    }
    return nil;
}
- (NSNumber*)numberForKeySafe:(id)aKey
{
    NSNumber *value = [self objectForKeySafe:aKey];
    if (value && ![value isKindOfClass:[NSNull class]])
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            return value;
            
        }else if ([value respondsToSelector:@selector(doubleValue)])
        {
            return [NSNumber numberWithDouble:[value doubleValue]];
        }
        return nil;
    }
    return nil;
}
- (NSInteger)integerForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    
    if (value && [value respondsToSelector:@selector(integerValue)])
    {
        return [value integerValue];
    }
    return 0;
}

- (BOOL)boolForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value && [value respondsToSelector:@selector(boolValue)])
    {
        return [value boolValue];
    }
    return false;
}
- (NSArray*)arrayForKeySafe:(id)aKey
{
    NSArray *value = [self objectForKeySafe:aKey];
    if (value && [value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}
- (NSDictionary*)dictionaryForKeySafe:(id)aKey
{
    NSDictionary *value = [self objectForKeySafe:aKey];
    if (value && [value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

@end

#pragma mark NSMutableDictionary

@implementation NSMutableDictionary (SafeCategory)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey || !anObject)
    {
        return;
    }
    return [self setObject:anObject forKey:aKey];
}

@end
