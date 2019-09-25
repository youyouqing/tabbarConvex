//
//  BreathingTrainDetailViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/7/30.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseViewController.h"

@interface BreathingTrainDetailViewController : BaseViewController

/**
 呼吸间隔
 */
@property (nonatomic,assign) NSInteger jmhRank;



/**
 训练时间
 */
@property (nonatomic,assign) NSInteger trainTime;
@property (weak, nonatomic) UIImageView *backViewImage;

@end
