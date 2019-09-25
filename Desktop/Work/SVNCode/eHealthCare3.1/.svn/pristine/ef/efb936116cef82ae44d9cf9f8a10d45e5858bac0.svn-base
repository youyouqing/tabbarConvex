//
//  XKBindToolTableViewCell.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKDeviceMod.h"
@class XKBindToolTableViewCell;
@protocol XKBindToolTableViewCellDelegate <NSObject>

/**
绑定商品
 
 @param cell <#cell description#>
 */
-(void)bindView:(XKBindToolTableViewCell *)cell;
/**
 购买商品
 
 @param cell <#cell description#>
 */
-(void)buyTools:(XKBindToolTableViewCell *)cell;

@end

@interface XKBindToolTableViewCell : UITableViewCell
@property(weak,nonatomic)id<XKBindToolTableViewCellDelegate>delegate;

@property(strong,nonatomic)XKDeviceMod *model;
@end
