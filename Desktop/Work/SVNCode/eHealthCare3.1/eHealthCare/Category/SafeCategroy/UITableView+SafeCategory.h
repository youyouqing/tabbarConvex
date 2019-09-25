//
//  UITableView+SafeCategory.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SafeCategory)

- (void)reloadRowsAtIndexPathsSafe:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end
