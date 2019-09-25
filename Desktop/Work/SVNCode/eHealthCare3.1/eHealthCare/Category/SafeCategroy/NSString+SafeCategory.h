//
//  NSString+SafeCategory.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SafeCategory)

- (NSString *)substringFromIndexSafe:(NSUInteger)from;

- (NSString *)substringToIndexSafe:(NSUInteger)to;

- (NSString *)substringWithRangeSafe:(NSRange)range;

- (NSString *)stringByReplacingCharactersInRangeSafe:(NSRange)range withString:(NSString *)replacement;

- (double)doubleValueSafe;

- (float)floatValueSafe;

- (int)intValueSafe;

- (NSInteger)integerValueSafe NS_AVAILABLE(10_5, 2_0);

- (long long)longLongValueSafe NS_AVAILABLE(10_5, 2_0);

- (BOOL)boolValueSafe NS_AVAILABLE(10_5, 2_0);

@end
