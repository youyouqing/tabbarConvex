//
//  ShareView.h
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "ShareModel.h"

typedef NS_ENUM(NSInteger, sharePlatform) {
    ShareTypeWechatSession,
    ShareTypeWechatTimeLine,
    ShareTypeQQ,
    ShareTypeQZone,
    ShareTypeSina
};

@interface ShareView : UIView

typedef void(^shareTree)(BOOL isShareTree);
//@property (nonatomic, copy) shareTree isTreeShare;
@property (nonatomic,assign) void(^block)(NSInteger tag);
/**
 调用shareSDK官方UI分享

 @param useFor 分享的用途
 @param shareType 分享的内容类型 比如图片 文字 或网页
 @param controller 分享所在的Controller 一般self
 @param shareModel 需要分享的model
 */
+ (void)shareActionOfShareUseFor:(shareUseFor)useFor shareType:(shareType)shareType WithViewcontroller:(UIViewController *)controller ShareModel:(ShareModel *)shareModel Block:(void(^)(NSInteger tag))block shareTree:(BOOL)shareTree;

@end
