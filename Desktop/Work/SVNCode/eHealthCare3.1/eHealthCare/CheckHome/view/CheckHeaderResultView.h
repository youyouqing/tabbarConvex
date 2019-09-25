//
//  CheckHeaderResultView.h
//  NewEquipmentCheck
//
//  Created by xiekang on 2017/8/16.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchinereportModel.h"

@class CheckHeaderResultView;
@protocol CheckHeaderResultViewDelegate <NSObject>
-(void)AgainC:(CheckHeaderResultView *)view;
@end

@interface CheckHeaderResultView : UIView
{


    NSTimer *oxygenWaveformTime;
}
@property (strong, nonatomic)  UIView *backView;
//@property (strong, nonatomic)
@property(strong,nonatomic)ExchinereportModel *mode;

/**
 单位
 */
@property (weak, nonatomic) IBOutlet UILabel *BMILab;


@property (weak, nonatomic) IBOutlet UILabel *dataLab;



@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UIView *oxygenBottomView;

@property(weak,nonatomic)id<CheckHeaderResultViewDelegate>delegate;
@property (nonatomic , strong) NSArray *dataSource;//血氧波形图的数据数组
- (void)createWorkDataSourceWithTimeInterval:(NSTimeInterval )timeInterval;
- (void)TouchCircleAndHide;
- (void)StopCircleAninmationAndHide;
@end
