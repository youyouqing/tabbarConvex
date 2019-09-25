//
//  VersionHelp.m
//  eHealthCare
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VersionHelp.h"

#define SystemVersion [[NSUserDefaults standardUserDefaults] objectForKey:@"systemVersionxk"]

@implementation VersionHelp

+ (void)setSystemVersion:(NSMutableDictionary *)dict
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:dict forKey:@"systemVersionxk"];
    [user synchronize];
    
}

+ (VersionHelp *)getSystemVersion
{
    return [VersionHelp mj_objectWithKeyValues:SystemVersion];
}

+(NSMutableDictionary *)getSystemVersionCacheDic
{
    return SystemVersion;
}

+(void)removeVersion{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"systemVersionxk"];
    
}

@end
