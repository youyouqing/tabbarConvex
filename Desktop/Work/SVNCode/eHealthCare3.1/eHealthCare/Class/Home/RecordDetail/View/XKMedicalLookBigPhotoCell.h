//
//  XKMedicalLookBigPhotoCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPatientPhotoModel.h"
@interface XKMedicalLookBigPhotoCell : UICollectionViewCell

@property (nonatomic,strong) XKPatientPhotoModel *model;

@property (nonatomic,assign) NSInteger xkpage;

@property (nonatomic,assign) NSInteger counPage;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end
