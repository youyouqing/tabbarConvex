//
//  HealthPlanView.h
//  eHealthCare
//
//  Created by John shi on 2018/8/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthPlanHead : UIView

///头部视图按钮的宽度
@property (nonatomic, assign) float itemWidth;

///item的字体大小
@property (nonatomic, strong) UIFont *itemFont;

///item字体颜色
@property (nonatomic, strong) UIColor *textColor;

///item被点击中的颜色
@property (nonatomic, strong) UIColor *selectedColor;

///item下滑线
@property(nonatomic,assign)float linePercent;
@property(nonatomic,assign)float lineHieght;

@end

typedef void(^ItemHasBeenClickBlcok)(NSInteger index,BOOL animation);

@interface HealthPlanView : UIScrollView

@property(nonatomic, strong) HealthPlanHead *headView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic,assign)BOOL isPublicFont;//是否是资讯的字体,资讯字体要小,其他字体17
///默认是YES
@property(nonatomic, assign) BOOL tapAnimation;
@property(nonatomic, readonly) NSInteger currentIndex;

@property (nonatomic, copy) ItemHasBeenClickBlcok ItemHasBeenClickBlcok;

/// scrollViewDidScroll 会被调用
-(void)moveToIndex:(float)index;
- (NSInteger)changeProgressToInteger:(float)x;
/// scrollViewDidEndDecelerating 会被调用
-(void)endMoveToIndex:(float)index;

@end