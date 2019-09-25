//
//  UITableView+SafeCategory.m
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "UITableView+SafeCategory.h"

@implementation UITableView (SafeCategory)

- (void)reloadRowsAtIndexPathsSafe:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:indexPaths.count];
    NSInteger totalSelections =  [self numberOfSections];
    
    for (NSIndexPath *indexPath in indexPaths)
    {
        NSInteger totalRows = [self numberOfRowsInSection:indexPath.section];
        if(indexPath.section < 0 || indexPath.section >= totalSelections || indexPath.row >= totalRows)
        {
            
        }else
        {
            [tempArray addObject:indexPath];
        }
    }
    [self reloadRowsAtIndexPaths:tempArray withRowAnimation:animation];
}

+ (void)initialize
{
    if (@available(iOS 11.0, *))
    {
        [[self appearance] setEstimatedRowHeight:0];
        [[self appearance] setEstimatedSectionHeaderHeight:0];
        [[self appearance] setEstimatedSectionFooterHeight:0];
    }
}

@end
