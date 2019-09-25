//
//  XKTopicModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKTopicModel : NSObject

/**
 话题编号
 */
@property (nonatomic,assign)NSInteger TopicID;

/**
 话题类别
 */
@property (nonatomic,copy)NSString *TopicTypeName;

/**
 话题内容
 */
@property (nonatomic,copy)NSString *TopicContent;

/**
 发布话题人的头像
 */
@property (nonatomic,copy)NSString *HeadImg;

/**
 CreateTime
 Long
 话题发布时间
 */
@property (nonatomic,assign)long CreateTime;

/**
 ReplyScount
 Int32
 话题回答人数
 */
@property (nonatomic,assign)NSInteger ReplyScount;

/**
 PraiseScount
 Int32
 话题点赞人数
 */
@property (nonatomic,assign)NSInteger PraiseScount;

/**
 是否已经点赞 0未点赞 1已点赞
 */
@property (nonatomic,assign) NSInteger IsPraise;

/**
 发布话题人的姓名
 */
@property (nonatomic,copy) NSString *NickName;


//发表内容标识 0、未发表图片和视频 1、发表图片 2、发表视频
@property (nonatomic,assign) NSInteger PublishFlag;

//图片地址，多个图片用|分隔
@property (nonatomic,copy)NSString *TopicImgUrl;

//视频地址
@property (nonatomic,copy)NSString *TopicVideoUrl;
@end
