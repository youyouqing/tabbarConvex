//
//  MedicCollectionViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiEncyTypeList.h"
@interface MedicCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)WikiEncyTypeList *WikiEncyTypeListModel;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage;

@end
