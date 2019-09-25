//
//  HealthPlanTopCell.h
//  eHealthCare
//
//  Created by John shi on 2018/11/21.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHomePlanModel.h"
@class HealthPlanTopCell;
@protocol HealthPlanTopCellDelegate <NSObject>

-(void)HealthPlanTopCellJoinAction:(XKHomePlanModel *)cellModel;

@end
@interface HealthPlanTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *circleOneImage;
@property (weak, nonatomic) IBOutlet UIImageView *BGMimgaeView;

@property (assign, nonatomic)CGFloat progress;
@property (weak, nonatomic) IBOutlet UIImageView *circleTwoImage;


@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *planProtectLab;
@property (weak, nonatomic) IBOutlet UILabel *planNumberLab;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic)CAShapeLayer *layerCirCle;
@property (weak, nonatomic)id <HealthPlanTopCellDelegate>delegate;

@property (nonatomic,strong)XKHomePlanModel *planModel;
@end
