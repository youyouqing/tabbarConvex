//
//  XKRecordPhotoCollectionCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPatientPhotoModel.h"

@protocol XKRecordPhotoCollectionCellDelegate <NSObject>

@optional
/**
协议方法 删除图片
 */
-(void)deletePhoto:(XKPatientPhotoModel *) model;

/**
 协议方法 添加图片图片
 */
-(void)addPhoto:(XKPatientPhotoModel *) model;

@end

@interface XKRecordPhotoCollectionCell : UICollectionViewCell

@property (nonatomic,strong) XKPatientPhotoModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

@property (weak, nonatomic) IBOutlet UIButton *delegateBtn;

/**
 代理对象
 */
@property (nonatomic,weak) id<XKRecordPhotoCollectionCellDelegate> delegate;

@end
