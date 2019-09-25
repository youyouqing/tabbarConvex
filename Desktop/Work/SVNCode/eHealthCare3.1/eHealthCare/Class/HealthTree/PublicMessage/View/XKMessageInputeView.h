//
//  XKMessageInputeView.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKMineReplyMod.h"

@interface XKMessageInputeView : UIView

/**
 文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txt;

@property (nonatomic,assign) NSInteger typeID;

@property (nonatomic,strong) XKMineReplyMod *model;


@end
