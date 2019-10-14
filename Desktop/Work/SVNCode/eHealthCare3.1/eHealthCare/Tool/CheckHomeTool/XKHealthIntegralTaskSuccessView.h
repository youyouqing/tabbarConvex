//
//  XKHealthIntegralTaskSuccessView.h
//  eHealthCare
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本任务完成页面弹窗

#import <UIKit/UIKit.h>
#import "XKCompleteTaskModel.h"



@interface XKHealthIntegralTaskSuccessView : UIView

/**
 数据源
 */
@property (nonatomic,strong)XKCompleteTaskModel *completeModel;

/**福利任务图片*/
@property (weak, nonatomic) IBOutlet UIImageView *kangImg;



@end