//
//  IanAlert.m
//  SVProgressHUD
//  loading弹窗
//  Created by ian on 14/11/27.
//
//

#import "IanAlert.h"

#import "UIAlertView+Blocks.h"
@implementation IanAlert

//+(void)alertError:(NSString *)string
//{
//    ShowErrorStatus(string];
//}
//+(void)alertError:(NSString *)string length:(NSTimeInterval)length
//{
//    ShowErrorStatus(string duration:length];
//}

+(void)alertSuccess:(NSString *)string
{
    [SVProgressHUD showSuccessWithStatus:string];
}

//+(void)alertSuccess:(NSString *)string length:(NSTimeInterval)length
//{
//    [SVProgressHUD showSuccessWithStatus:string duration:length];
//}

+(void)showloading
{
    [SVProgressHUD show];
}

+(void)showloadingAllowUserInteraction:(BOOL)allowUserInteraction
{
    if (allowUserInteraction)
    {
        [SVProgressHUD show];
    }
    else
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    }
}

+(void)showLoading:(NSString *)string
{
    [SVProgressHUD showWithStatus:string];
}

+(void)showLoading:(NSString *)string allowUserInteraction:(BOOL)allowUserInteraction
{
    if (allowUserInteraction)
    {
        [SVProgressHUD showWithStatus:string];
    }
    else
    {
        [SVProgressHUD showWithStatus:string maskType:SVProgressHUDMaskTypeClear];
    }
}

//+ (void)showLoading:(NSString *)string inView:(UIView *)view
//{
//    [SVProgressHUD showWithtatus:string inView:view];
//}

+ (void)hideLoadingWithReflash:(UIView *)view
{
    NSLog(@"isnoshow-%d",[SVProgressHUD isVisible]);
    UIView * a = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    a.center = view.center;
    a.backgroundColor = StyleColor;
    [view addSubview:a];
//    [self hideLoading];
    [SVProgressHUD dismiss];
    

}

+(void)hideLoading
{
    [SVProgressHUD dismiss];
    
}

//+(void)hideLoading:(void(^)(BOOL finished))completion
//{
//    [SVProgressHUD dismiss:completion];
//}

+(void)confirmWithTitle:(NSString *)title message:(NSString *)message yes:(NSString *)yes actionYes:(void (^)(void))actionYes andno:(NSString *)no actionNo:(void (^)(void))actionNo
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                       cancelButtonItem:[RIButtonItem itemWithLabel:no action:^{
                                         actionNo();
    }]
                       otherButtonItems:[RIButtonItem itemWithLabel:yes action:^{

        actionYes();
    }], nil] show];
}

+(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                       cancelButtonItem:[RIButtonItem itemWithLabel:NSLocalizedString(@"confirm_ok", nil) action:^
                                         {
                                             
                                         }]
                       otherButtonItems:nil] show];
}

+(void)alertWithTitle:(NSString *)title message:(NSString *)message yes:(NSString *)yes confirm:(void(^)())confirm
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                       cancelButtonItem:[RIButtonItem itemWithLabel:yes action:^
                                         {
                                             if (confirm)
                                             {
                                                 confirm();
                                             }
                                         }]
                       otherButtonItems:nil] show];
}


@end