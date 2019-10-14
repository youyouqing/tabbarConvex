//
//  PersonalArcHeadView.h
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalArcModel.h"
#import "ExanubeReportModel.h"
#import "FamilyObject.h"
@protocol PersonalArcHeadViewDelegate <NSObject>
-(void)clickHeadBtn:(NSString *)btnName;
@end

@interface PersonalArcHeadView : UIView

@property (weak, nonatomic) IBOutlet UIButton *trendBtn;

@property (nonatomic,assign)id <PersonalArcHeadViewDelegate> delegate;
@property (nonatomic, strong) FamilyObject* model;


@property (nonatomic, strong) ExanubeReportModel *exanubeReportModel;

@end