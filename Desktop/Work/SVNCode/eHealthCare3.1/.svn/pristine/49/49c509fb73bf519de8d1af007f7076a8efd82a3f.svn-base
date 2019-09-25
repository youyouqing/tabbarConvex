//
//  HealthInformationCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HealthInformationCellDelegate <NSObject>

- (void)HealthInformationCellDelegatebuttonClick;

@end


@interface HealthInformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (copy, nonatomic)NSString *dataStr;
@property (nonatomic, weak) id <HealthInformationCellDelegate> delegate;

@end
