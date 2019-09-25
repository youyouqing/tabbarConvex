//
//  singleTon.m
//  eHealthCare
//
//  Created by John shi on 2018/6/26.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "SingleTon.h"

#import <CoreLocation/CoreLocation.h>

@interface SingleTon () <CLLocationManagerDelegate>

@end

@implementation SingleTon

static SingleTon *sharedSingleton = nil;

+ (SingleTon *)shareInstance{
    
    static dispatch_once_t  once;
    dispatch_once(&once,^{
        
        sharedSingleton = [[SingleTon alloc] init];
        
    });
    
    return sharedSingleton;
}


@end
