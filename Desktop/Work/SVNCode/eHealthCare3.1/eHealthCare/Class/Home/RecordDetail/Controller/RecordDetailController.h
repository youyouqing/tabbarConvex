//
//  RecordDetailController.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthRecordViewModel.h"
#import "PersonalArcModel.h"
typedef void(^refreshUserId)(NSInteger memberId);

@interface RecordDetailController :BaseViewController
 @property(assign,nonatomic) NSInteger userMemberID;

 @property(assign,nonatomic) NSInteger SelectTab;
// 网络状态改变通知
@property (nonatomic, copy) refreshUserId UserMemberId;
@end
