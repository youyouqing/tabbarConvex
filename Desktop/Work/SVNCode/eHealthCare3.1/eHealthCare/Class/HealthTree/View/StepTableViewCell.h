//
//  StepTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthData.h"

@protocol StepTableViewCellDelegate <NSObject>

- (void)sportbuttonClick;
-(void)sendStepCellMesage:(int )step;

@end
@interface StepTableViewCell : UITableViewCell
@property (nonatomic, weak) id <StepTableViewCellDelegate> delegate;
@property (nonatomic, strong)HealthData *data;
@property (weak, nonatomic) IBOutlet UILabel *stepLab;
@property (strong, nonatomic)CAShapeLayer *layerCirCle;

@property (nonatomic, assign)int steps;

@end