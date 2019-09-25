//
//  SureConditionCollectionViewCell.h
//  MultipleSelectedWindow
//
//  Created by 刘硕 on 2016/12/23.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SureConditionModel.h"
#import "DictionaryMsg.h"
@interface SureConditionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;

@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
- (void)loadDataFromModel:(DictionaryMsg*)model;
@end
