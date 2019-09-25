//
//  HudTool.h
//  eHealthCare
//
//  Created by John shi on 2018/6/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HudTool : NSObject

extern void ShowAutoDissmissMessage(NSString *statues);

/**
 普通展示

 @param statues 需要展示的信息
 */
extern void ShowNormailMessage(NSString *statues);

/**
 展示成功信息

 @param statues 需要展示的信息
 */
extern void ShowSuccessStatus(NSString *statues);

/**
 展示错误信息
 
 @param statues 需要展示的信息
 */
extern void ShowErrorStatus(NSString *statues);

/**
 普通展示
 
 @param statues 需要展示的信息
 */
extern void ShowMaskStatus(NSString *statues);

/**
 显示文字信息
 
 @param statues 需要展示的信息
 */
extern void ShowMessage(NSString *statues);

/**
 显示进度
 
 @param progress 进度
 */
extern void ShowProgress(CGFloat progress);

/**
 设置延时隐藏
 
 @param time 需要延时的时间
 */
extern void DismissHudTime(CGFloat time);

/**
 隐藏掉
 */
extern void DismissHud(void);

/**
 显示出来
  */
extern void Show(void);

@end
