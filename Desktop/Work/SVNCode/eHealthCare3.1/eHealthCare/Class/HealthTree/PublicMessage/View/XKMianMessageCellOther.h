//
//  XKMianMessageCellOther.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKMineReplyMod.h"
@protocol XKMianMessageCellOtherDelegate <NSObject>
-(void)clickLookBtn:(XKMineReplyMod *)model;
-(void)clickCommentBtn:(XKMineReplyMod *)model typeID:(NSInteger)typeID xkMineReplyModTex:(UITextField *)xkMineReplyModTex;
@end


@interface XKMianMessageCellOther : UITableViewCell
@property(strong,nonatomic) XKMineReplyMod *model;

@property (nonatomic,assign)id <XKMianMessageCellOtherDelegate> delegate;
@end
