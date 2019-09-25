//
//  CheckResult.h
//  eHealthCare
//
//  Created by jamkin on 16/8/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckListModel.h"

@interface CheckResult : NSObject

/**
 自测套题名称
 */
@property (nonatomic,copy)NSString *SetCategoryName;

/**
 自测问卷id
 */
@property (nonatomic,assign)NSInteger AnswerID;

/**
 自测结果标题
 */
@property (nonatomic,copy)NSString *Title;

/**
 自测答案内容
 */
@property (nonatomic,copy)NSString *AnswerContent;

/**
 是否推荐产品
 */
@property (nonatomic,assign)NSInteger IsRecommendProduct;

/**
 测试类型
 */
@property (nonatomic,assign)NSInteger TestType;

/**
 自测时间
 */
@property (nonatomic,assign)long PostDate;

/**
 套题信息
 */
@property (nonatomic,strong)NSDictionary * SeftTestInfo;

/**
 转换之后的套题信息
 */
@property (nonatomic,strong)CheckListModel *listModel;

@end
