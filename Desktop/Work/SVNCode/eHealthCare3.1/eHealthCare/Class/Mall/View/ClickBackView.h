//
//  ClickBackView.h
//  eHealthCare
//
//  Created by xiekang on 16/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClickBackView : UIView
/**
 设置View的点击事件
 */
-(void)setTarget:(id)target action:(SEL)action;
@end
