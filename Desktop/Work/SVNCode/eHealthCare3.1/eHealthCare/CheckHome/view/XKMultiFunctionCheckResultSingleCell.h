//
//  XKMultiFunctionCheckResultSingleCell.h
//  NM
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportModel.h"

@interface XKMultiFunctionCheckResultSingleCell : UITableViewCell
@property (nonatomic,strong)ReportModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@end
