//
//  MessagePublicCell.h
//  eHealthCare
//
//  Created by xiekang on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWikiModel.h"
#import "NewFamilyAddMessagMod.h"
#import "NewHealthNoticeMod.h"

@interface MessagePublicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lineLab;


@property (nonatomic,strong)NewWikiModel *NewNotice;

///**
// 系统消息
// */
//@property (nonatomic,strong)NewWikiModel *NewSysMessage;
//
///**
// 健康消息
// */
//@property (nonatomic,strong)NewHealthNoticeMod *NewHealthNotice;
//
///**
// 资讯消息
// */
//@property (nonatomic,strong)NewWikiModel *NewWikiMessage;
//
///**
// 话题消息
// */
//@property (nonatomic,strong)NewWikiModel *NewTopicMessage;
//
///**
// 添加家人消息
// */
//@property (nonatomic,strong)NewFamilyAddMessagMod * NewFamilyAddMessage;

@end