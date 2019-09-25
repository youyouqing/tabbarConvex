//
//  HealthTestCollectionViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckListModel.h"
@class HealthTestCollectionViewCell;
@protocol HealthTestCollectionViewCellDelegate <NSObject>

-(void)HealthTestCollectionViewCellJoinAction:(HealthTestCollectionViewCell *)cell;


-(void)HealthTestdetailChangeDataSoure:(CheckListModel *)cellListMod;

@end
@interface HealthTestCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *BeginTestBtn;
@property (strong, nonatomic)CheckListModel *listMod;
@property (weak, nonatomic)id <HealthTestCollectionViewCellDelegate>delegate;

@end
