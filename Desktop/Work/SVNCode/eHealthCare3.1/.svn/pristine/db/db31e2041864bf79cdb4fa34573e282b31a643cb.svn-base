//
//  HealthRecordNoDataFooterView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/19.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthRecordNoDataFooterViewDelegate <NSObject>

/**
 来做事情
 */
- (void)ComebuttonClick:(NSString *)title;

@end



@interface HealthRecordNoDataFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (nonatomic, weak) id <HealthRecordNoDataFooterViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
