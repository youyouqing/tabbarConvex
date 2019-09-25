//
//  UITabBar+XKTabBar.m
//  CLProprietaryTabBar
//
//  Created by zhangmin on 2018/10/24.
//  Copyright © 2018年 chenlin. All rights reserved.
//

#import "UITabBar+XKTabBar.h"
#import "UITabBarItem+XKTabBarItem.h"

#import <objc/runtime.h> 
@implementation UITabBar (XKTabBar)

static char kAssociatedObjectKey_doubleTapBlock;

- (void)setGs_doubleTapBlock:(void (^)(UITabBarItem *, NSInteger))gs_doubleTapBlock {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_doubleTapBlock, gs_doubleTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITabBarItem *, NSInteger))gs_doubleTapBlock {
    return (void (^)(UITabBarItem *, NSInteger))objc_getAssociatedObject(self, &kAssociatedObjectKey_doubleTapBlock);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    
    if (self.items.count < 2) {
        return [super hitTest:point withEvent:event];
    }
    
    UITabBarItem *item = self.items[2];
    UIImageView *itemImageView  = [item gs_imageView];
    
    if (!itemImageView) {
        return [super hitTest:point withEvent:event];
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil){
        //转换坐标
        CGPoint tempPoint = [itemImageView convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(itemImageView.bounds, tempPoint)){
            //返回按钮
            return itemImageView;
        }
        
        //******************    或者使用这个方法     ****************
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ([itemImageView pointInside:point withEvent:event]) {
            return itemImageView;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    return view;
}


@end

