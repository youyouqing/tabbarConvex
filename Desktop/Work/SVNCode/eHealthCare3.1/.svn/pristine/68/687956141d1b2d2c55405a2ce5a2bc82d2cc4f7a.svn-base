//
//  XKMultiFunctionCheckResultHeadView.h
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//携康3.0版本pc300检测报告页面头部

#import <UIKit/UIKit.h>

@protocol XKMultiFunctionCheckResultHeadViewDelegate <NSObject>

-(void)enterMainView:(int)DeviceIdtag DeviceClasstag:(int)DeviceClasstag Name:(NSString *)Name;



@end
@interface XKMultiFunctionCheckResultHeadView : UIView
@property(weak,nonatomic)id<XKMultiFunctionCheckResultHeadViewDelegate>delegate;


@property(strong,nonatomic)NSArray *dataArr;
@end
