//
//  XKCheckHeaderCommonResultView.h
//  eHealthCare
//
//  Created by xiekang on 2017/11/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKExChinereportModel.h"
#import "ExchinereportModel.h"

@class XKCheckHeaderCommonResultView;

@protocol CheckHeaderResultViewDelegate <NSObject>

-(void)AgainCheckResult:(XKCheckHeaderCommonResultView *)view;

@end

@interface XKCheckHeaderCommonResultView : UIView

@property(strong,nonatomic) ExchinereportModel *mode;
@property(strong,nonatomic) NSArray *modeArr;
/**
 单位
 */
@property (weak, nonatomic) IBOutlet UILabel *BMILab;


@property (weak, nonatomic) IBOutlet UILabel *dataLab;



@property (weak, nonatomic) IBOutlet UIButton *againBtn;


@property(weak,nonatomic)id<CheckHeaderResultViewDelegate>delegate;
- (void)TouchCircleAndHide;
- (void)StopCircleAninmationAndHide;
@end
