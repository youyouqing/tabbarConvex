//
//  XKCheckResultView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExchinereportModel.h"


@class XKCheckResultView;
@protocol XKCheckResultViewDelegate <NSObject>
-(void)Again:(XKCheckResultView *)view;
@end
@interface XKCheckResultView : UIView

/**
 体重
 */
@property (weak, nonatomic) IBOutlet UILabel *weightLab;
@property (weak, nonatomic) IBOutlet UILabel *weightKgLab;

/**
 BMI值
 */
@property (weak, nonatomic) IBOutlet UILabel *BMILab;
@property (weak, nonatomic) IBOutlet UILabel *BMIKgLab;
@property(weak,nonatomic)id<XKCheckResultViewDelegate>delegate;

/**
 
 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
/**
 脂肪率
 */
@property (weak, nonatomic) IBOutlet UILabel *sLvLab;

@property (weak, nonatomic) IBOutlet UILabel *slvkgLab;

/**
 模型数据
 */
@property(strong,nonatomic)ExchinereportModel *mode;
@property(strong,nonatomic)NSArray *modeArr;
/**
 再来一次
 */
@property (weak, nonatomic) IBOutlet UIButton *againBtn;


@property (weak, nonatomic) IBOutlet UILabel *fatLabOne;
@property (weak, nonatomic) IBOutlet UILabel *fatLabTwo;
@property (weak, nonatomic) IBOutlet UILabel *fatLabThree;
@property (weak, nonatomic) IBOutlet UILabel *fatLabFour;
@property (weak, nonatomic) IBOutlet UILabel *fatLabFive;
@property (weak, nonatomic) IBOutlet UILabel *fatLabSix;
@property (weak, nonatomic) IBOutlet UILabel *fatLabSeven;
@property (weak, nonatomic) IBOutlet UILabel *fatLabEight;
@property (weak, nonatomic) IBOutlet UILabel *fatLabNine;
@property (weak, nonatomic) IBOutlet UILabel *fatLabTen;
@property (weak, nonatomic) IBOutlet UILabel *fatLabElev;
@property (weak, nonatomic) IBOutlet UILabel *fatLabTwel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgFive;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgSix;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgSeven;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgEight;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgNine;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgTen;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgElev;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgTwel;
-(void)TouchCircleAndHide;
-(void)StopCircleAninmationAndHide;
@end
