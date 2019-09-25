//
//  NSArray+SafeCategory.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeCategory)

+ (id)arrayWithObjectSafe:(id)anObject;

- (id)objectAtIndexSafe:(NSUInteger)uindex;

- (NSArray *)arrayByAddingObjectSafe:(id)anObject;

@end

#pragma mark NSMutableArray
@interface NSMutableArray (SafeCategory)

- (void)addObjectSafe:(id)anObject;

- (void)insertObjectSafe:(id)anObject atIndex:(NSUInteger)index;

- (void)replaceObjectAtIndexSafe:(NSUInteger)index withObject:(id)anObject;

- (void)removeObjectAtIndexSafe:(NSUInteger)index;

@end
