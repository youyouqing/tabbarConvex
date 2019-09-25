//
//  XKInformationDetailController.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTopic.h"
#import "XKWiKIInfoModel.h"
@interface XKInformationDetailController : BaseViewController
@property (nonatomic , strong) MHTopic *topic;

//@property (nonatomic , assign) NSInteger TopicID;

@property(strong,nonatomic) XKWiKIInfoModel *TopicID;


typedef void(^changeThumb)(NSInteger);

@property (nonatomic, copy) changeThumb changeThumbIsPraise;

@end
