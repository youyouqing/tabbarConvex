/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

@interface ChatViewController : EaseMessageViewController <EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>

@property (nonatomic,strong) NSDictionary  *doctorInfoAllDic;
@property (nonatomic,assign) BOOL isPresentToVC;
@property (nonatomic,strong) NSString  *SysDoctorID;
@property (nonatomic,assign) BOOL isCollect;
@property (nonatomic,strong) NSString  *easeDoctorID;

/**判断是否医生是否在线*/
@property (nonatomic,assign) NSInteger  onlineStaus;
@property (nonatomic,strong) NSString  *doctorNickName;

/**判断是否是在线客服进入*/
@property (nonatomic,assign) BOOL isOnline;

/**判断是否是从消息列表进入客服聊天*/
@property (nonatomic,assign) BOOL isMessageOnline;

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

@end
