//
//  XKHomeAcountView.h
//  eHealthCare
//
//  Created by jamkin on 2017/9/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKSportsHomeModel.h"
#import "XKRecommendedWikiModel.h"
#import "StepModel.h"

/**
 协议对象
 */
@protocol XKHomeAcountViewDelegate <NSObject>

@optional
-(void)sendActionAcountData:(XKRecommendedWikiModel *)topic;

/**发送今日记步信息*/
-(void)sendStepMesage:(StepModel *) step;

@end

@interface XKHomeAcountView : UIView


/**
 代理属性
 */
@property (nonatomic,weak) id<XKHomeAcountViewDelegate> delegate;

/**
 数据源
 */
@property (nonatomic,strong) XKSportsHomeModel *model;


@end
