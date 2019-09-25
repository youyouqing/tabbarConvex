//
//  TodayPlanDetailView.h
//  eHealthCare
//
//  Created by John shi on 2018/8/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendPlanDetailViewHeightBlock)(CGFloat detailViewHeight);

@interface TodayPlanDetailView : UIView

///数据源
@property (nonatomic, strong) NSArray *dataArray;

///将自适应的高度传回TodayHealthPlanViewController 从而设置scrollView的ContentSize
@property (nonatomic, copy) SendPlanDetailViewHeightBlock heightBlock;

@end
