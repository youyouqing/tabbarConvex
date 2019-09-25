//
//  TrendDetailDataCell.h
//  eHealthCare
//
//  Created by xiekang on 16/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTrendDataModel.h"
#import "TrendSuggestModel.h"
#import "XKTrendSuggestSurgarModel.h"
#import "XKNewTrendDataSugarModel.h"
@interface TrendDetailDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLal1;
@property (weak, nonatomic) IBOutlet UILabel *titleLal2;
@property (weak, nonatomic) IBOutlet UILabel *timeLal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *windthCon;
@property (nonatomic,strong) TrendSuggestModel *suggestModel;
@property (nonatomic,strong) NewTrendDataModel *model;


//血糖
@property (nonatomic,strong) XKTrendSuggestSurgarModel *sugarsuggestModel;
@property (nonatomic,strong) XKNewTrendDataSugarModel *sugarmodel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@end
