//
//  XKRecordPhotoCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历原件信息

#import <UIKit/UIKit.h>
#import "XKPatientDetailModel.h"

@protocol XKRecordPhotoCellDelegate <NSObject>

@optional

/**
 修改图片
 @param data 原本显示得数据源
 */
-(void)photoFixDataSource:(XKPatientDetailModel *) data;

/**
查看大图的协议代理方法
 @param photoArray 当前图片的数据源
 @param page 当前点击查看图片的页面
 */
-(void)jumpTopBigPhoto:(NSArray *) photoArray withPage:(NSInteger) page;

/**
 改变图片视图的高度
 @param photoArray 当前显示图片的数据源
 */
-(void)reloadPhotoViewHeight:(NSArray *) photoArray;



-(void)takePhotoWithKeyboardDone;

@end

@interface XKRecordPhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;

/**
 显示数据源
 */
@property (nonatomic,strong) XKPatientDetailModel *model;

/**
 是否可以编辑的控制标示
 */
@property (nonatomic,assign) BOOL isEnableEdit;

/**
 代理对象
 */
@property (nonatomic,weak) id<XKRecordPhotoCellDelegate> delegate;

/**
 编辑状态和上床状态时的图片预览 1上传时的预览方式 2编辑时图片的预览方式
 */
@property (nonatomic,assign) NSInteger previewMothed;

@end
