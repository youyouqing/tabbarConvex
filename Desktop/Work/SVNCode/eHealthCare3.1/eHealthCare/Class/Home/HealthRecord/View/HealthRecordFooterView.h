//
//  HealthRecordFooterView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopRecordModel;
@protocol HealthRecordFooterViewDelegate <NSObject>

- (void)HealthRecordFooterViewButtonClick:(TopRecordModel *)tModel remind:(BOOL)remind;

@end

@interface HealthRecordFooterView : UIView
@property (nonatomic, strong) NSArray *basicArr;
@property(assign,nonatomic)NSInteger userMemberID;
@property (nonatomic, assign) BOOL planOrArchive;
@property (nonatomic, weak) id <HealthRecordFooterViewDelegate> delegate;

@end
