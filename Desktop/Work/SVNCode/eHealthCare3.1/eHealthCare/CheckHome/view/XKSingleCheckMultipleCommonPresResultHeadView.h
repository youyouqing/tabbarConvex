//
//  XKSingleCheckMultipleCommonPresResultHeadView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchinereportModel.h"
@class XKSingleCheckMultipleCommonPresResultHeadView;
@protocol XKSingleCheckMultipleCommonPresResultHeadViewDelegate <NSObject>
-(void)AgainV:(XKSingleCheckMultipleCommonPresResultHeadView *)view;
@end
@interface XKSingleCheckMultipleCommonPresResultHeadView : UIView

/**
 转圈一
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiViewOne;
/**
 转圈二
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiTwo;


/**
 转圈三
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activiThree;

/**
 模型数据
 */
@property(strong,nonatomic)ExchinereportModel *mode;

/**
 数据数组
 */
@property(strong,nonatomic)NSArray *modeArr;


@property (weak, nonatomic) IBOutlet UIButton *dataOneBtn;
@property (weak, nonatomic) IBOutlet UILabel *scopeOneLab;


@property (weak, nonatomic) IBOutlet UIButton *dataTwoBtn;
@property (weak, nonatomic) IBOutlet UILabel *scopeTwoLab;



@property (weak, nonatomic) IBOutlet UILabel *nameOneLab;
@property (weak, nonatomic) IBOutlet UILabel *nameTwolab;
@property (weak, nonatomic) IBOutlet UILabel *nameThreeLab;
/**
 代理
 */
@property(weak,nonatomic)id<XKSingleCheckMultipleCommonPresResultHeadViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *scopeThreeLab;
@property (weak, nonatomic) IBOutlet UIButton *dataThreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;

@property (weak, nonatomic) IBOutlet UIImageView *statusImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgThree;
-(void)stopAninmayion;

-(void)startAnimation;
@end
