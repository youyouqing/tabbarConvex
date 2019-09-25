//
//  XKMultiFunctionCheckResultBottomView.m
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMultiFunctionCheckResultBottomView.h"

@implementation XKMultiFunctionCheckResultBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 点击事件协议代理

 @param sender <#sender description#>
 */
- (IBAction)clickUploadAction:(id)sender {
    
    if (self.upBtnIsOrNot == YES) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(enterUploadView)]) {
            [self.delegate enterUploadView];
        }
    }
    
  
    
}

@end
