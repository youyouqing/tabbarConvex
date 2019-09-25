//
//  CoreStatusProtocol.h
//  DecentTrainUser
//
//  Created by John shi on 2018/6/20.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#ifndef CoreStatusProtocol_h
#define CoreStatusProtocol_h

#import "CoreNetworkStatus.h"

@protocol CoreStatusProtocol <NSObject>

@property (nonatomic,assign) NetworkStatus currentStatus;

@optional

/** 网络状态变更 */
-(void)coreNetworkChangeNoti:(NSNotification *)noti;

@end


#endif /* CoreStatusProtocol_h */
