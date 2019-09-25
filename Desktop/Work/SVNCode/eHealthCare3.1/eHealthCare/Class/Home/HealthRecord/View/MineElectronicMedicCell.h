//
//  MineElectronicMedicCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKPatientModel.h"
@interface MineElectronicMedicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dotOneLab;
@property (weak, nonatomic) IBOutlet UILabel *dotTwoLab;
@property (weak, nonatomic) IBOutlet UILabel *dotThreeLab;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
/**
 医院名称标签
 */
@property (weak, nonatomic) IBOutlet UILabel *hospitalName;

/**
 治疗类型标签
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

/**
 整治时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *backView;
/**
 电子病历数据源
 */
@property (nonatomic,strong) XKPatientModel *model;
@end
