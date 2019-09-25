//
//  XKBindMobileViewController.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
@interface XKBindMobileViewController : BaseViewController

/**
 绑定类型:1.微信  2.QQ  3.新浪微博  4.腾讯微博 5支付宝 6微信公众平台
 */
@property(nonatomic,assign)NSInteger bindType;
@end
