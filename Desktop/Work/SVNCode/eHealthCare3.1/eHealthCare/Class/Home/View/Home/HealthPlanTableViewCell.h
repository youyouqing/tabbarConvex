//
//  HealthPlanTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/11/20.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHomePlanModel.h"
@class HealthPlanTableViewCell;
@protocol HealthPlanTableViewCellDelegate <NSObject>

-(void)HealthPlanTableViewCellJoinAction:(XKHomePlanModel *)cellModel;

@end

@interface HealthPlanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *planProtectLab;
@property (weak, nonatomic) IBOutlet UILabel *planNumberLab;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic)CAShapeLayer *layerCirCle;

@property (weak, nonatomic)id <HealthPlanTableViewCellDelegate>delegate;

@property (nonatomic,strong)XKHomePlanModel *planModel;
@end


