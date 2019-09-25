//
//  HealthRecordNoneDataCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HealthRecordNoneDataCellDelegate <NSObject>

/**
 来做事情
 */
- (void)addComebuttonClick:(NSString *)title;

@end
@interface HealthRecordNoneDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, weak) id <HealthRecordNoneDataCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@end
