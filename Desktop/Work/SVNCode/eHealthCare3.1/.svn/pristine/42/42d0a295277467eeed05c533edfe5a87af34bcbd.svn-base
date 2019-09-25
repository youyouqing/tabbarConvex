//
//  MHTopic.h
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  话题模型

#import <Foundation/Foundation.h>


@interface MHTopic : NSObject



/** 所有评论 MHComment */
@property (nonatomic , strong) NSMutableArray *comments;


/**
 ReplyID
 Int32
 一级评论编号
 */
@property (nonatomic,assign) NSInteger ReplyID;


/**
ReplyerMemberID

 */
@property (nonatomic,assign) NSInteger ReplyerMemberID;

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

@property (nonatomic,strong) NSArray *SecondCommentList;
@end
