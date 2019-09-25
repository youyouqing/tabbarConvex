//
//  XKNewModel.h
//  eHealthCare
//
//  Created by mac on 16/12/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKNewModel : NSObject

/**
 新闻id
 */
@property (nonatomic,assign)NSInteger ID;

/**
 新闻关键词
 */
@property (nonatomic,copy)NSString *Keywords;

/**
 百科名称
 */
@property (nonatomic,copy)NSString *WikiName;

/**
 百科分类编号
 */
@property (nonatomic,assign)NSInteger CategoryID;

/**
 图片路径
 */
@property (nonatomic,copy)NSString *ImgUrl;

/**
 作者
 */
@property (nonatomic,copy)NSString *Author;

/**
 评论数
 */
@property (nonatomic,assign)NSInteger DiscussCount;
/**
 浏览次数
 */
@property (nonatomic,assign)NSInteger VisitCount;

/**
 收藏次数
 */
@property (nonatomic,assign)NSInteger FavorCount;

/**
 出版时间
 */
@property (nonatomic,copy)NSString *PublishTime;

/**
 详情路径
 */
@property (nonatomic,copy)NSString *LinkUrl;
/**
 简介
 */
@property (nonatomic,copy)NSString *Summary;


/**
 内容
 */
@property (nonatomic,copy)NSString *Content;

/**
 是否收藏 0、未收藏 1、收藏
 */
@property (nonatomic,assign)NSInteger CollectFlag;
@end
