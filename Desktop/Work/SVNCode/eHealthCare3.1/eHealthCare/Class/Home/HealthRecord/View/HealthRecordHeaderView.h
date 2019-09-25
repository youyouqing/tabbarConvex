//
//  HealthRecordHeaderView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMoodModel.h"

@protocol HealthRecordHeaderViewDelegate <NSObject>

- (void)HealthRecordHeaderViewButtonClick:(NSString *)nameStr;

@end

@interface HealthRecordHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic, weak) id <HealthRecordHeaderViewDelegate> delegate;

@property(nonatomic, assign)int MoodID;
@end
