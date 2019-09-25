//
//  XKHotTopicBigViewCollectionViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/12/26.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKHotTopicBigViewCollectionViewCell : UICollectionViewCell
//@property (nonatomic,strong) XKPatientPhotoModel *model;

@property (nonatomic,assign) NSInteger xkpage;

@property (nonatomic,assign) NSInteger counPage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightCons;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *countLab;
@end
