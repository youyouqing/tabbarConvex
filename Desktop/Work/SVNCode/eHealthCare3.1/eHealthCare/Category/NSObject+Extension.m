//
//  NSObject+Extension.m
//  eHealthCare
//
//  Created by John shi on 2018/8/28.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (BOOL)isEnptyOrNil:(id)object
{
    if(object == nil)
    {
        return NO;
    }
    
    if (!object)
    {
        return NO;
    }
    
    if([object isKindOfClass:[NSDictionary class]])
    {
        
    }
    else if([object isKindOfClass:[NSArray class]])
    {
        
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        if([(NSString *)object isEqualToString:@""])
            return NO;
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return NO;
    }
    else if ([object isKindOfClass:[NSSet class]])
    {
        
    }
    else if((NSNull *)object == [NSNull null])
    {
        return NO;
    }
    else if ([object isEqualToString:@"<null>"])
    {
        return NO;
    }
    
    return YES;
}

@end
