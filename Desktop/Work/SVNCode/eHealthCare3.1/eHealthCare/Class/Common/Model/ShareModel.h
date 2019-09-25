//
//  ShareModel.h
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

///分享的内容类型
typedef NS_ENUM(NSInteger,shareType)
{
    shareText = 0,
    shareImage = 1,
    shareVideo = 2,
    shareUrl = 3,
};

///分享的用途
typedef NS_ENUM(NSInteger,shareUseFor)
{
    shareUseForShareContent = 0,
    shareUseForInviteFriend = 1,
};

@interface ShareModel : NSObject

///分享的标题
@property (nonatomic,copy) NSString *shareTitle;

///分享的内容
@property (nonatomic,copy) NSString *shareContent;

///分享的图片
@property (nonatomic,strong) UIImage *shareImage;

///分享的视频链接
@property (nonatomic,copy) NSString *shareVideoUrl;

///分享的url
@property (nonatomic,copy) NSString *shareUrl;

///分享缩略图
@property (nonatomic,strong) UIImage *thumImage;

///分享的图片数组
@property (nonatomic,retain) NSArray *shareImageArray;

@end
