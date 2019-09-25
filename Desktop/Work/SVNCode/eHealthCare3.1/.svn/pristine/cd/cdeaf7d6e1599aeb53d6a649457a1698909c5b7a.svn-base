//
//  AlterView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AlterView.h"

@interface AlertView()

@property (nonatomic, strong) UIWindow *lastWindow;

@end

@implementation AlertView

#pragma mark lazy
- (UIWindow *)lastWindow{
    
    if (!_lastWindow) {
        
        _lastWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return _lastWindow;
}

#pragma mark Alert
//1、一个按钮：按钮文本默认 取消
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];

    [self showAlertController:alertController];
}

//2、一个按钮：按钮文本自定义 没有回调
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:action];
    
    [self showAlertController:alertController];
}

//3、一个按钮：按钮文本自定义 有回调
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle buttonClick:(ButtonClick)buttonClick
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick();
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:action];
    
    [self showAlertController:alertController];
}

//4、两个按钮：一个按钮文本自定义 一个按钮文本默认取消 有回调
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle buttonClickAttachValue:(ButtonClickAttachValue)buttonClick
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(0);
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(1);
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    [self showAlertController:alertController];
}

//5、两个按钮：按钮文本自定义 有回调
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title sureButtonTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle buttonClickAttachValue:(ButtonClickAttachValue)buttonClick
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(0);
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(1);
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    [self showAlertController:alertController];
}

#pragma mark ActionSheet
//一个取消按钮 一个自定义按钮
+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message sureButtonTitle:(NSString *)sureTitle buttonClickAttachValue:(ButtonClickAttachValue)buttonClick
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(0);
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(1);
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self showAlertController:alertController];
}

//一个取消按妞 另外两个自定义
+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message sureButtonTitle:(NSString *)sureTitleF sureTitleS:(NSString *)sureTitleS buttonClickAttachValue:(ButtonClickAttachValue)buttonClick
{
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(0);
    }];
    
    UIAlertAction *sureActionF = [UIAlertAction actionWithTitle:sureTitleF style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(1);
    }];
    
    UIAlertAction *sureActionS = [UIAlertAction actionWithTitle:sureTitleS style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        buttonClick(2);
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:sureActionF];
    [alertController addAction:sureActionS];
    [alertController addAction:cancelAction];
    [self showAlertController:alertController];
}

+ (NSArray *)checkTheParameter:(NSString *)message{
    
    if ([message containsString:@"#$&"]) {
        
        NSArray *array = [message componentsSeparatedByString:@"#$&"];
        return array;
    }
    
    return nil;
    
}


+ (void)showAlertController:(UIAlertController *)alertController{
    
    AlertView *alert = [[AlertView alloc]init];
    
    [alert.lastWindow.rootViewController presentViewController:alertController animated:true completion:nil];
    
}
@end
