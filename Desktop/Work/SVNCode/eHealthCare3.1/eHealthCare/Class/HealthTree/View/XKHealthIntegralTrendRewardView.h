//
//  XKHealthIntegralTrendRewardView.h
//  eHealthCare
//
//  Created by John shi on 2018/12/6.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHealthIntegralKTrendModel.h"
@interface XKHealthIntegralTrendRewardView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topKValueCons;
/*头部视图作图部分*/
@property (weak, nonatomic) IBOutlet UIView *topDrawView;

/**
 底部视图显示数据部分
 */
@property (weak, nonatomic) IBOutlet UIView *bottomDataView;

/**
 白色的线条
 */
@property (nonatomic,strong) CAShapeLayer *bigLightLayer;

/**
 白色线条的路径
 */
@property (nonatomic,strong) UIBezierPath *bigLigthPath;

/**
 显示数据的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *showDataLabOne;
@property (weak, nonatomic) IBOutlet UILabel *showDataLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *showDataLabThree;
@property (weak, nonatomic) IBOutlet UILabel *showDataLabFour;
@property (weak, nonatomic) IBOutlet UILabel *showDataLabFive;
@property (weak, nonatomic) IBOutlet UILabel *showDataLabSix;
@property (weak, nonatomic) IBOutlet UILabel *showDataLabSeven;
//定义数组存放标签
@property (nonatomic,strong) NSArray *showLabArray;

//显示数据标签头部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsSix;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showTopConsSeven;
@property (nonatomic,strong) NSArray *consArray;

/**
 数组存放数据源
 */
@property (nonatomic,strong) NSArray *dataArray;

/**
 存放头部底部时间标签
 */
@property (nonatomic,strong) NSArray *timeArray;
@property (nonatomic,strong) NSArray *YtimeArray;
//存放底部数据的数组
@property (nonatomic,strong) NSArray *KArray;
@property (nonatomic,strong) NSArray *KtimeArray;
@end
