//
//  AlterView.h
//  eHealthCare
//
//  Created by John shi on 2018/7/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClick)(void);
typedef void(^ButtonClickAttachValue)(NSInteger buttonIndex);

@interface AlertView : NSObject

/*Alert*/

/**
 1一个按钮：按钮文本默认 取消

 @param message 提示内容
 @param title 标题
 */
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title;


/**
 2、一个按钮：按钮文本自定义 没有回调

 @param message 提示内容
 @param title 标题
 @param sureTitle 确认按钮的名称
 */
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle;


/**
 3、一个按钮：按钮文本自定义 有回调

 @param message 提示内容
 @param title 标题
 @param sureTitle 确认按钮的名称
 @param buttonClick 确认回调
 */
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle buttonClick:(ButtonClick)buttonClick;


/**
 4、两个按钮：一个按钮文本自定义 一个按钮文本默认取消 有回调

 @param message 提示内容
 @param title 标题
 @param sureTitle 确认按钮的名称
 @param buttonClick 按钮回调
 */
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle buttonClickAttachValue:(ButtonClickAttachValue)buttonClick;


/**
 5、两个按钮：按钮文本自定义 有回调

 @param message 提示内容
 @param title 标题
 @param sureTitle 确认按钮的名称
 @param cancelTitle 取消按钮的名称
 @param buttonClick 按钮的回调
 */
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle buttonClickAttachValue:(ButtonClickAttachValue)buttonClick;

/*ActionSheet*/


/**
 ActionSheet 1、一个取消按钮 一个自定义按钮

 @param title 标题
 @param message 提示内容
 @param sureTitle 确认按钮的标题
 @param buttonClick 按钮的回调
 */
+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message sureButtonTitle:(NSString *)sureTitle buttonClickAttachValue:(ButtonClickAttachValue)buttonClick;


/**
 ActionSheet 一个取消按钮 另外两个自定义

 @param title 标题
 @param message 提示内容
 @param sureTitleF 第一个按钮的名称
 @param sureTitleS 第二个按钮的名称
 @param buttonClick 按钮的回调
 */
+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message sureButtonTitle:(NSString *)sureTitleF sureTitleS:(NSString *)sureTitleS buttonClickAttachValue:(ButtonClickAttachValue)buttonClick;

@end
