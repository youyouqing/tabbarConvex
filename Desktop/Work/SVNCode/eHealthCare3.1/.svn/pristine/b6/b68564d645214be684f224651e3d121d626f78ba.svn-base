//
//  NSDictionary+SafeCategory.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeCategory)

+ (id)dictionaryWithObjectSafe:(id)object forKey:(id<NSCopying>)key;

- (id)objectForKeySafe:(id)aKey;

- (NSString*)stringForKeySafe:(id)akey;

- (NSNumber*)numberForKeySafe:(id)aKey;

- (NSInteger)integerForKeySafe:(id)aKey;

- (BOOL)boolForKeySafe:(id)aKey;

- (NSArray*)arrayForKeySafe:(id)aKey;

- (NSDictionary*)dictionaryForKeySafe:(id)aKey;

@end

#pragma mark NSMutableDictionary
@interface NSMutableDictionary (SafeCategory)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;

@end
