//
//  HealthTreeHeaderView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthData.h"
@protocol HealthTreeHeaderViewDelegate <NSObject>
//公告信息。 
-(void)messageDataSoure;
-(void)goHealthTaskDataSoure;

-(void)goHealthTreeWebUrl:(NSInteger)treeOrXRun;

-(void)goSportBtnAction;

-(void)sendStepCellMesage1:(int )step;

@end
@interface HealthTreeHeaderView : UIView
@property (nonatomic,weak) id<HealthTreeHeaderViewDelegate> delegate;
@property (nonatomic,strong) HealthData *HealthData;
@property (weak, nonatomic) IBOutlet UILabel *messageCountBadgeLab;
@property (weak, nonatomic) IBOutlet UIImageView *bgTreeImg;
@property (weak, nonatomic) IBOutlet UIButton *xuesuBtn;
@property (weak, nonatomic) IBOutlet UIButton *kangbiBtn;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@end