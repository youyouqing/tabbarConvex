//
//  MHTopic.m
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHTopic.h"
#import "MHComment.h"
@interface MHTopic ()

/** 点赞数string */
@property (nonatomic , copy) NSString * thumbNumsString;

@end

@implementation MHTopic

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化
        _comments = [NSMutableArray array];
        // 由于这里只是评论一个视频
//        _mediabase_id = @"89757";
    }
    return self;
}

-(void)setSecondCommentList:(NSArray *)SecondCommentList
{

    _SecondCommentList = SecondCommentList;


    _SecondCommentList = [MHComment objectArrayWithKeyValuesArray:_SecondCommentList];

}

@end
