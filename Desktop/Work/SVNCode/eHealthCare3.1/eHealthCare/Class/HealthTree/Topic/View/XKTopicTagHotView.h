//
//  XKTopicTagHotView.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHealthPlanModel.h"

@protocol XKTopicTagHotViewDelegate <NSObject>

@optional
-(void)changeDataSoure:(NSArray *)array;

@end

@interface XKTopicTagHotView : UIView

/**
 类型数据源
 */
@property (nonatomic,strong) NSArray *typeArray;

@property (nonatomic,weak) id<XKTopicTagHotViewDelegate> delegate;

@end
