//
//  SportCommonMod.m
//  eHealthCare
//
//  Created by John shi on 2018/11/16.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "SportCommonMod.h"

@implementation SportCommonMod
static SportCommonMod *sharedSportCommon = nil;

+ (SportCommonMod *)shareInstance;
{
    static dispatch_once_t  once;
    dispatch_once(&once,^{
        
        sharedSportCommon = [[SportCommonMod alloc] init];
        
    });
    
    return sharedSportCommon;
    
}
@end
