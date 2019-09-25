//
//  NSArray+SafeCategory.m
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "NSArray+SafeCategory.h"

@implementation NSArray (SafeCategory)

+ (id)arrayWithObjectSafe:(id)anObject
{
    if (!anObject)
    {
        return nil;
    }
    return [self arrayWithObject:anObject];
}

- (id)objectAtIndexSafe:(NSUInteger)uindex
{
    NSInteger index=uindex;
    if (index<0||index>=self.count)
    {
        return nil;
    }
    return [self objectAtIndex:index];
}
- (NSArray *)arrayByAddingObjectSafe:(id)anObject
{
    if (!anObject)
    {
        return [self mutableCopy];
    }
    return [self arrayByAddingObject:anObject];
}

@end

#pragma mark NSMutableArray
@implementation NSMutableArray (SafeCategory)

- (void)addObjectSafe:(id)anObject
{
    if (!anObject)
    {
        return;
    }
    [self addObject:anObject];
}
- (void)insertObjectSafe:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject)
    {
        return;
    }
    if (index>=self.count)
    {
        [self addObjectSafe:anObject];
        return;
    }
    [self insertObject:anObject atIndex:index];
}
- (void)replaceObjectAtIndexSafe:(NSUInteger)uindex withObject:(id)anObject
{
    if (!anObject)
    {
        return;
    }
    NSInteger index = uindex;
    if (index < 0 ||index >= self.count)
    {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)removeObjectAtIndexSafe:(NSUInteger)uindex
{
    NSInteger index = uindex;
    if (index < 0|| index >= self.count)
    {
        return;
    }
    [self removeObjectAtIndex:index];
}

@end
