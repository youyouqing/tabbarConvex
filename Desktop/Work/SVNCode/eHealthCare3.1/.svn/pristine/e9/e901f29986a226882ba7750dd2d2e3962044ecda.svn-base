//
//  RecordLookTopTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/27.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPatientDetailModel.h"
@protocol RecordLookTopTableViewCellDelegate <NSObject>

@optional
-(void)RecordLookTopDataSource:(XKPatientDetailModel *) model;
-(void)hospitalMessageFix:(XKPatientDetailModel *) data;
-(void)typeFixDataSource:(XKPatientDetailModel *) model;
-(void)basisFixDataSource:(XKPatientDetailModel *) data;

@end
@interface RecordLookTopTableViewCell : UITableViewCell
@property (nonatomic,strong) XKPatientDetailModel *model;

@property (nonatomic,strong) NSArray *typeArray;

@property (nonatomic,weak) id<RecordLookTopTableViewCellDelegate> delegate;
@property (nonatomic,assign) BOOL isEnableEdit;

@end





