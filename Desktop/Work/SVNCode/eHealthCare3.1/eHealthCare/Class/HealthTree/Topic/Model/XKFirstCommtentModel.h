//
//  XKFirstCommtentModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSecondeCommtentModel.h"

@interface XKFirstCommtentModel : NSObject

/**
 ReplyID
 Int32
 一级评论编号
 */
@property (nonatomic,assign) NSInteger ReplyID;

/**
 ReplyContent
 String
 评论内容
 */
@property (nonatomic,copy) NSString *ReplyContent;

/**
 NickName
 String
 用户昵称
 */
@property (nonatomic,copy) NSString *NickName;

/**
 HeadImg
 Long
 用户头像
 */
@property (nonatomic,copy) NSString *HeadImg;

/**
 ReplyTime
 Long
 回复时间
 */
@property (nonatomic,assign) long ReplyTime;

/**
 ReplyScount
 Int32
 回复人数
 */
@property (nonatomic,assign) NSInteger ReplyScount;


/**
 PraiseScount
 Int32
 点赞人数
 */
@property (nonatomic,assign) NSInteger PraiseScount;

/**
 IsPraise
 Int32
 当前评论是否点赞过   0、未点赞 1、已点赞
 */
@property (nonatomic,assign) NSInteger IsPraise;

/**
 评论人id
 */
@property (nonatomic,assign) NSInteger ReplyerMemberID;

@property (nonatomic,strong) NSArray *SecondCommentList;

//一级评论对应图片 多个图片路径之前用|分隔    
@property (nonatomic,copy)NSString *ReplyImgUrl;

@end
