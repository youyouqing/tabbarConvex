//
//  XKTopicHotDetialController.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKTopicModel.h"

@interface XKTopicHotDetialController : BaseViewController

@property (nonatomic,assign) BOOL isOther;

@property (nonatomic,assign)NSInteger modelID;

@property (nonatomic, copy) void (^didRefreshPageBlock)(BOOL);

@end
