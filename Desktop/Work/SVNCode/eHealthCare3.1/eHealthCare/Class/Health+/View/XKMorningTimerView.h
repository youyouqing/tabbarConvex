//
//  XKMorningTimerView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKMorningTimerViewDelegate <NSObject>

/**
 取消时间
 */
-(void)cancelSelectTime;


/**
 开始确定的时间

 @param time <#time description#>
 */
-(void)checkSelectTime:(int )time;

@end

@interface XKMorningTimerView : UIView

@property(weak,nonatomic) id<XKMorningTimerViewDelegate> delegate;


@end
