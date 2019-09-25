//
//  TopRecordModel.h
//  eHealthCare
//
//  Created by John shi on 2018/11/6.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopRecordModel : NSObject

/**
 标题（运动步数、饮水量等）
 */
@property(nonatomic, copy)NSString *Title;

/**
 标题内容（具体内容，如1564步、300ml）
 */
@property(nonatomic, copy)NSString *TitleDetail;



/**
 是否达标1、达标 0、未达标
 */
@property(nonatomic, assign)int  IsOK;

/**类型1、运动 2、饮水 3、健康计划  4、服药 5、休息
类型1、运动 2、饮水 3、健康计划  4、服药
 */
@property(nonatomic, assign)int RemindType;


@property (nonatomic,assign)NSInteger PlanMainID;

/**
 用户加入计划记录ID
 */
@property (nonatomic,assign)NSInteger MemPlanID;
//1、饮食 2、运动 3、调理
@property (nonatomic,assign)NSInteger PlanTypeID;
@end
