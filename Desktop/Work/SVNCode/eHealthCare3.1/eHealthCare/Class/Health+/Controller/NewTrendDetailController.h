//
//  NewTrendDetailController.h
//  eHealthCare
//
//  Created by xiekang on 16/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPhySicalItemModel.h"//血脂四项基本数据实体

@interface NewTrendDetailController : BaseViewController
@property (nonatomic,assign) NSInteger PhysicalItemID;

@property (nonatomic,assign) NSInteger shareType;

/**
 [838] 3.0 获取血脂四项检测项目列表(需登录状态)
 */
@property (nonatomic,strong) NSArray *PhysicalItemArr;

@end