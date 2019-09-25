//
//  XKSingleCheckMultipleCommonResultCell.h
//  PC300
//
//  Created by jamkin on 2017/8/16.
//  Copyright © 2017年 com.xiekang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestReportModel.h"
#import "ExchinereportModel.h"

@interface XKSingleCheckMultipleCommonResultCell : UITableViewCell


/**
 建议数据
 */
@property(strong,nonatomic) ExchinereportModel *statusModel;

@property(strong,nonatomic) SuggestReportModel *model;

/**
 收缩压正常异常
 */
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property(strong,nonatomic) NSArray *modelArr;
@end
