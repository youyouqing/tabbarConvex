//
//  XKSingleCheckMultipleCommonResultHeadView.h
//  PC300
//
//  Created by jamkin on 2017/8/16.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKSingleCheckMultipleCommonResultHeadView;
@protocol XKSingleCheckMultipleCommonResultHeadViewDelegate <NSObject>
-(void)AgainR:(XKSingleCheckMultipleCommonResultHeadView *)view;
@end
@interface XKSingleCheckMultipleCommonResultHeadView : UIView


/**
 转圈
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiViewOne;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiTwo;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiThree;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiFour;
@property (weak, nonatomic) IBOutlet UIButton *dataOneBtn;
@property (weak, nonatomic) IBOutlet UILabel *scopeOneLab;


@property (weak, nonatomic) IBOutlet UIButton *dataTwoBtn;
@property (weak, nonatomic) IBOutlet UILabel *scopeTwoLab;

/**
 再测一次按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *OnceAgainBtn;

@property (weak, nonatomic) IBOutlet UILabel *scopeThreeLab;
@property (weak, nonatomic) IBOutlet UIButton *dataThreeBtn;


@property (weak, nonatomic) IBOutlet UIButton *dataFourBtn;
@property (weak, nonatomic) IBOutlet UILabel *scopeFourLab;


@property (weak, nonatomic) IBOutlet UILabel *nameOneLab;
@property (weak, nonatomic) IBOutlet UILabel *nameTwolab;
@property (weak, nonatomic) IBOutlet UILabel *nameThreeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameFourLab;



@property(weak,nonatomic)id<XKSingleCheckMultipleCommonResultHeadViewDelegate>delegate;


/**
 检测的数据
 */
@property(strong,nonatomic)NSArray *exAmineArray;

-(void)stopAninmayion;

-(void)startAnimation;
@end
