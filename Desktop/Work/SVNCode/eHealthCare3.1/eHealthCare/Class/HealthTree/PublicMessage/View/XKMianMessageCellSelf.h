//
//  XKMianMessageCellSelf.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKMineReplyMod.h"

@protocol XKMianMessageCellSelfDelegate <NSObject>
-(void)clickLookBtn:(XKMineReplyMod *)model;
-(void)clickCommentBtn:(XKMineReplyMod *)model typeID:(NSInteger)typeID xkMineReplyModTex:(UITextField *)xkMineReplyModTex;
//-(void)clickCommentBtn:(XKMineReplyMod *)model;
@end


@interface XKMianMessageCellSelf : UITableViewCell
@property(strong,nonatomic) XKMineReplyMod *model;


@property (nonatomic,assign)id <XKMianMessageCellSelfDelegate> delegate;
@end
