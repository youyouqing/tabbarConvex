//
//  XKSpLockedView.m
//  eHealthCare
//
//  Created by xiekang on 2017/9/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSpLockedView.h"

@interface XKSpLockedView ()
/**
 长按结束按钮计时
 */
@property(strong,nonatomic)NSTimer *longTimer;

@end

@implementation XKSpLockedView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.lockBtn.clipsToBounds = YES;
    
    
    self.lockBtn.layer.cornerRadius = 74/2.0;
    
    
    self.lockBtn.arcBackColor = kMainColor;
    
    self.lockBtn.arcFinishColor = kMainColor;
    
    [self.lockBtn addTarget:self action:@selector(stopTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lockBtn addTarget:self action:@selector(stopTouchDown) forControlEvents:UIControlEventTouchDown];
}
//当按下按钮以后调用该方法，增加一个延迟。
- (void)stopTouchDown
{
    
    
    self.lockBtn.percent = 0;
    self.longTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(longBtnCount) userInfo:nil repeats:YES];
    
}


//当离开按钮的时候取消所调用的方法
- (void)stopTouchUpInside
{
    
     self.lockBtn.percent = 0;
    
    [self cancelTimer];
    
    
}
-(void)longBtnCount
{
    self.lockBtn.percent +=0.02;
    //dzc todo a
    self.lockBtn.arcBackColor = [UIColor grayColor];
    self.lockBtn.arcUnfinishColor = [UIColor getColor:@"03C7FF"];
    if (self.lockBtn.percent >= 1) {
        
        
        [self cancelTimer];
        
        self.lockBtn.percent = 0;
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(unLocked)]) {
            
            [self.delegate unLocked];
        }

        
        return;
    }
}

-(void)cancelTimer{
   [self.longTimer  setFireDate:[NSDate distantFuture]];
  
    [self.longTimer invalidate];
    self.longTimer = NULL;
   
}

@end