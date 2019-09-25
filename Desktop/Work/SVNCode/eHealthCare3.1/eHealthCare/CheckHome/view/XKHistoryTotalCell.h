//
//  XKHistoryTotalCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKReportOveralMod.h"

@interface XKHistoryTotalCell : UITableViewCell

@property (nonatomic,strong) XKReportOveralMod *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstain;

@end
