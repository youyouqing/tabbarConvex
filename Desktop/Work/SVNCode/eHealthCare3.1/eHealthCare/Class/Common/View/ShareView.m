//
//  ShareView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/5.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@end

@implementation ShareView

#pragma mark Share自带的分享
+ (void)shareActionOfShareUseFor:(shareUseFor)useFor shareType:(shareType)shareType WithViewcontroller:(UIViewController *)controller ShareModel:(ShareModel *)shareModel Block:(void(^)(NSInteger tag))block shareTree:(BOOL)shareTree;
{
    if (shareModel.shareImageArray)
    {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:shareModel.shareContent
                                         images:shareModel.shareImageArray
                                            url:[NSURL URLWithString:shareModel.shareUrl]
                                          title:shareModel.shareTitle
                                           type:SSDKContentTypeAuto];
        
        [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {

            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    
                    [AlertView showMessage:@"分享成功" withTitle:@"提示" sureButtonTitle:@"确定"];
//                    if (shareTree == YES) {
                        if (block) {
                            block(1);
                        }
//                    }
                    break;
                }
                case SSDKResponseStateFail:
                {
                    
                    [AlertView showMessage:[NSString stringWithFormat:@"%@",error] withTitle:@"分享失败" sureButtonTitle:@"确定"];
                    
                    break;
                }
                default:
                    break;
            }
        }];
    }
    
}
@end