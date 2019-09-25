//
//  PhysicalList.h
//  eHealthCare
//
//  Created by John shi on 2018/11/1.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhysicalList : NSObject
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
 项目单位
 */
@property (nonatomic,copy) NSString *PhysicalItemUnits;


/**
 项目值
 */
@property (nonatomic,copy) NSString *TypeParameter;

/**
 是否异常 1、正常 0、异常
 */
@property (nonatomic,assign) int ExceptionFlag;

/**
 异常名称
 */
@property (nonatomic,copy) NSString *ParameterName;



/**
 参考范围
 */
@property (nonatomic,copy) NSString *ReferenceValue;


/**
 唯一标识（TC对应体温
 */
@property (nonatomic,copy) NSString *PhysicalItemIdentifier;

/**
 检测时间
 */
@property (nonatomic,assign)long TestTime;

/**
 范围最小值
 */
@property (nonatomic,assign)CGFloat MinValue;

/**
 
 */
@property (nonatomic,assign)CGFloat MaxValue;

/**
 <#Description#>是否绑定设备1、是 0、否
 */
@property (nonatomic,assign) int IsBind;

@end
