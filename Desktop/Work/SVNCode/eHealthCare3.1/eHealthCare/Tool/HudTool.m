//
//  HudTool.m
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HudTool.h"
#import "SVProgressHUD.h"

#import <AVFoundation/AVFoundation.h>

@implementation HudTool

+ (void)load {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

void ShowAutoDissmissMessage(NSString *statues){
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:statues];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        });
    } else {
        [SVProgressHUD showWithStatus:statues];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    }
    [SVProgressHUD dismissWithDelay:1.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void ShowNormailMessage(NSString *statues) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:statues];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        });
    } else {
        [SVProgressHUD showWithStatus:statues];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void Show() {
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD show];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        });
    } else {
        [SVProgressHUD show];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void ShowSuccessStatus(NSString *statues) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:statues];
        });
    } else {
        [SVProgressHUD showSuccessWithStatus:statues];
    }
    [SVProgressHUD dismissWithDelay:1.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void ShowMessage(NSString *statues) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:statues];
        });
    } else {
        [SVProgressHUD showInfoWithStatus:statues];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void ShowErrorStatus(NSString *statues) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:statues];
            [SVProgressHUD showProgress:0.5 status:@"上传"];
        });
    } else {
        
        [SVProgressHUD showErrorWithStatus:statues];
        [SVProgressHUD dismissWithDelay:2.0];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void ShowMaskStatus(NSString *statues) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:statues];
        });
    } else {
        [SVProgressHUD showWithStatus:statues];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void ShowProgress(CGFloat progress) {
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showProgress:progress];
        });
    } else {
        [SVProgressHUD showProgress:progress];
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

void DismissHud(void) {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } else {
        [SVProgressHUD dismiss];
    }
}

extern void DismissHudTime(CGFloat time) {
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [SVProgressHUD dismissWithDelay:time];
                   });
}

@end
