//
//  XKMorningCircleView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKMorningCircleViewDelegate <NSObject>

/**
 开始  暂停 播放音乐
 */
-(void)pauseAndBeginMusic:(BOOL)isPlay;


@end
@interface XKMorningCircleView : UIView

@property(weak,nonatomic) id<XKMorningCircleViewDelegate> delegate;
@property(assign,nonatomic)float progress;
@property (weak, nonatomic) IBOutlet UILabel *countTimeLab;

/**
 中断按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@end
