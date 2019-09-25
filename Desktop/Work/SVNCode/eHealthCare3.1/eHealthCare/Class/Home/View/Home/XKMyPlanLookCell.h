//
//  XKMyPlanLookCell.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKHomePlanModel.h"

@class XKMyPlanLookCell;
@protocol XKMyPlanLookCellDelegate <NSObject>

-(void)XKMyPlanLookCellJoinAction:(XKHomePlanModel *)cellModel;

@end


@interface XKMyPlanLookCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *planProtectLab;
@property (weak, nonatomic) IBOutlet UILabel *planNumberLab;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic)id <XKMyPlanLookCellDelegate>delegate;

@property (nonatomic,strong)XKHomePlanModel *planModel;
@property (strong, nonatomic)CAShapeLayer *layerCirCle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topbackViewCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBackViewCons;

@end
