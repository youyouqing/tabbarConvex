//
//  HealthRecordMedical TableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientInfo.h"
@interface HealthRecordMedical_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dotOneLab;
@property (weak, nonatomic) IBOutlet UILabel *dotTwoLab;
@property (weak, nonatomic) IBOutlet UILabel *dotThreeLab;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong)PatientInfo *modle;
@end
