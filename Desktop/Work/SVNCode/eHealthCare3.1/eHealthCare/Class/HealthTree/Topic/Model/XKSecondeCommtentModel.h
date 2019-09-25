//
//  XKSecondeCommtentModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKSecondeCommtentModel : NSObject

/**
 CNickName
 String
 评论人
 */
@property (nonatomic,copy) NSString *CNickName;

/**
 评论人id
 */
@property (nonatomic,assign) NSInteger ReplyerMemberID;

/**
 用户头像
 */
@property (nonatomic,copy) NSString *HeadImg;

/**RNickName
 String
 回复人*/
@property (nonatomic,copy) NSString *RNickName;

/**ReplyContent
 String
 回复内容*/
@property (nonatomic,copy) NSString *ReplyContent;

/**ParentID
 Int32
 当前评论的父评论编号(一级评论编号)*/
@property (nonatomic,assign) NSInteger ParentID;

/**ReplyID
 Int32
 当前评论编号*/
@property (nonatomic,assign) NSInteger ReplyID;

/**ReplyTime
 Long
 回复时间*/
@property (nonatomic,assign) long ReplyTime;


//一级评论对应图片 多个图片路径之前用|分隔
@property (nonatomic,copy)NSString *ReplyImgUrl;
@end
