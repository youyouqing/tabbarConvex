//
//  XKPhySicalItemModel.h
//  eHealthCare
//
//  Created by xiekang on 2017/11/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKPhySicalItemModel : NSObject
/**
 PhysicalItemID
 Int
 检测项目编号
 */
@property (nonatomic,assign) int PhysicalItemID;

/**
 PhysicalItemName
 String
 项目名称
 */
@property (nonatomic,copy) NSString *PhysicalItemName;

/**
 PhysicalItemIdentifier
 String
 项目标识
 */
@property (nonatomic,copy) NSString *PhysicalItemIdentifier;

/**表示是否选中*/
@property (nonatomic,assign) BOOL IsSelect;





@end