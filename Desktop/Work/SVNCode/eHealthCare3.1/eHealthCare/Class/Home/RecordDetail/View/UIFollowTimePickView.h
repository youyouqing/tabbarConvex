//
//  UIFollowTimePickView.h
//  DoctorVersion
//
//  Created by xiekang on 16/12/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIFollowTimePickViewDelegate <NSObject>
@optional
-(void)birthDayPickerChange:(NSString *)dateStr andBtnTitle:(NSString *)title;

@end
@interface UIFollowTimePickView : UIView
@property (nonatomic,assign)id <UIFollowTimePickViewDelegate> delegate;
-(void)hiddenTimeView;
@end
