//
//  XKInformationDetail.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKWiKIInfoModel.h"

@interface XKInformationDetail : BaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property(strong,nonatomic) XKWiKIInfoModel *mod;
@property (nonatomic,assign) BOOL isOther;
@property (nonatomic, copy) void (^didRefreshPageBlock)(BOOL);

@end