//
//  NewTrendHomeCell.h
//  eHealthCare
//
//  Created by xiekang on 16/12/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrendNewModel.h"

@interface NewTrendHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLal;
@property (weak, nonatomic) IBOutlet UILabel *textLal;
@property (weak, nonatomic) IBOutlet UIImageView *nextIconV;
@property (nonatomic,strong) TrendNewModel *model;
@end
