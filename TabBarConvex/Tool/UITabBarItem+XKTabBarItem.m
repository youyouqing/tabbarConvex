//
//  UITabBarItem+XKTabBarItem.m
//  CLProprietaryTabBar
//
//  Created by zhangmin on 2018/10/24.
//  Copyright © 2018年 chenlin. All rights reserved.
//

#import "UITabBarItem+XKTabBarItem.h"
#import "UIBarItem+XKBarItem.h"

@implementation UITabBarItem (XKTabBarItem)

- (UIImageView *)gs_imageView {
    return [self.class gs_imageViewInTabBarButton:self.gs_view];
}

+ (UIImageView *)gs_imageViewInTabBarButton:(UIView *)tabBarButton {
    
    if (!tabBarButton) {
        return nil;
    }
    
    for (UIView *subview in tabBarButton.subviews) {
        // iOS10及以后，imageView都是用UITabBarSwappableImageView实现的，所以遇到这个class就直接拿
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITabBarSwappableImageView"]) {
            return (UIImageView *)subview;
        }
        
//        if (IOS_VERSION < 10) {
//            // iOS10以前，选中的item的高亮是用UITabBarSelectionIndicatorView实现的，所以要屏蔽掉
//            if ([subview isKindOfClass:[UIImageView class]] && ![NSStringFromClass([subview class]) isEqualToString:@"UITabBarSelectionIndicatorView"]) {
//                return (UIImageView *)subview;
//            }
//        }
    }
    return nil;
}

@end
