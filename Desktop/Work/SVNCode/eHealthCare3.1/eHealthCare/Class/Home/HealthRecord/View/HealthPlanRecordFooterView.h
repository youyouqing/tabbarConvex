//
//  HealthPlanRecordFooterView.h
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthPlanRecordFooterViewDelegate <NSObject>

- (void)HealthPlanRecordFooterViewbuttonClick;

@end

@interface HealthPlanRecordFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, weak) id <HealthPlanRecordFooterViewDelegate> delegate;

@end
