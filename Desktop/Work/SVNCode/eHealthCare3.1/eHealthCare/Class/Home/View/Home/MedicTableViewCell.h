//
//  MedicTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MedicCollectionViewCell,WikiEncyTypeList;
@protocol MedicTableViewCellDelegate <NSObject>

-(void)XKMedicTableViewCellJoinAction:(NSInteger )cellIndex  mod:(WikiEncyTypeList *)WikiEncyTypeListMod;

@end
@interface MedicTableViewCell : UITableViewCell
@property (weak, nonatomic)id <MedicTableViewCellDelegate>delegate;
@property (nonatomic,strong)NSArray *WikiEncyTypeList;
@end