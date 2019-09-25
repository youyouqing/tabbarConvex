//
//  SensoryResultViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/8/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//柔韧度

#import "BaseViewController.h"
#import "SensoryTestViewController.h"

@interface SensoryResultViewController : BaseViewController

///感官测试类型
@property (nonatomic, assign) sensoryType testType;

/******************视力测试用到的属性******************/
///左眼视力
@property (nonatomic, assign) float leftEyeNum;

///右眼视力
@property (nonatomic, assign) float rightEyeNum;

/******************色觉测试用到的属性******************/
///检测结果 (正常 色弱 先天性色盲)
@property (nonatomic, copy) NSString *colorResult;

/******************色觉测试用到的属性******************/
///柔韧度和挥拳测评的得分
@property (nonatomic, assign) int score;

@end
