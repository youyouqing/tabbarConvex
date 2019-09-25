//
//  SureConditionCollectionViewCell.m
//  MultipleSelectedWindow
//
//  Created by 刘硕 on 2016/12/23.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "SureConditionCollectionViewCell.h"
#define SureQuickSetRed [UIColor \
colorWithRed:236.0/255.0 \
green:73.0/255.0 \
blue:73.0/255.0 \
alpha:1.0]
#define SureQuickSetWhite [UIColor \
colorWithRed:245.0/255.0 \
green:245.0/255.0 \
blue:245.0/255.0 \
alpha:1.0]
@implementation SureConditionCollectionViewCell

- (void)loadDataFromModel:(DictionaryMsg *)model {
    _conditionLabel.text = model.DictionaryName;
    if (model.isSelected) {
        _selectImage.hidden = NO;
        _conditionLabel.textColor = kMainColor;
     
      
        
    } else {
        _selectImage.hidden = YES;
        _conditionLabel.textColor = [UIColor getColor:@"364F6E"];
       
       
      
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _conditionLabel.font = [UIFont systemFontOfSize:15.0];
    self.layer.borderWidth = .5;
     self.layer.borderColor = [UIColor getColor:@"DEE5EB"].CGColor;
}

@end
