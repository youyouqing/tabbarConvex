//
//  XKSpLockedView.h
//  eHealthCare
//
//  Created by xiekang on 2017/9/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSpLongGestureStopBtn.h"
@protocol XKSpLockedViewDelegate <NSObject>

- (void)unLocked;

@end
@interface XKSpLockedView : UIView
/**
 param : 代理
 */
@property (weak, nonatomic) IBOutlet XKSpLongGestureStopBtn *lockBtn;
@property (nonatomic)id<XKSpLockedViewDelegate> delegate;
@end
