//
//  XKHealthPlanModel.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKHealthPlanModel : NSObject


/**
 分类名称
 */
@property(nonatomic, strong)NSString *TypeName;

/**
 分类编号
 */
@property (nonatomic,assign)NSInteger TypeID;

/**
 类型区分
 */
@property (nonatomic,assign)NSInteger TypeFlag;

/**
 是否选中的效果
 */
@property (nonatomic,assign) BOOL isSelect;

@end
