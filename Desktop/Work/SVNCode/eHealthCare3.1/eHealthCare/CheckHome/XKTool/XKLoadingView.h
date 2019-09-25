//
//  XKLoadingView.h
//  eHealthCare
//
//  Created by xiekang on 16/9/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKLoadingView : UIView

/**加载中*/
-(void)showLoadingText:(NSString *)text;

/**亲，网速不给力哇~*/
-(void)errorloadingText:(NSString *)text;

/**关闭加载框*/
-(void)hideLoding;

+(XKLoadingView *)shareLoadingView;

-(void)loginError:(NSString *)str;

@end
