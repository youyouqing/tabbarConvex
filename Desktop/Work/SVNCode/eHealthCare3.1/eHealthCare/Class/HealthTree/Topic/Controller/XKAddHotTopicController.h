//
//  XKAddHotTopicController.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKAddHotTopicController : BaseViewController

@property (nonatomic,strong) NSArray *typeArray;

@property (nonatomic, copy) void (^didRefreshPageBlock)(BOOL,NSInteger);

@end
