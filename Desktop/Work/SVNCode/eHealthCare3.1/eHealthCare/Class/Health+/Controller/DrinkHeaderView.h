//
//  DrinkHeaderView.h
//  eHealthCare
//
//  Created by jamkin on 16/8/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DrinkController.h"
//#import "WealkCountController.h"
#import "DrinkData.h"
#import "StepModel.h"
#import "XKPhySicalItemModel.h"
@protocol DrinkHeaderViewDelegate  <NSObject>

@optional
-(void)clickBtnToIndex:(NSString *)btnTagModel;

-(void)clickDateToTakeData:(NSInteger)type;


@optional

-(void)clearData;

@end

@interface DrinkHeaderView : UIView

@property (nonatomic,strong)NSMutableArray *yellowLabArray;
@property (nonatomic,strong)NSMutableArray *greenLabArray;
/*图片视图容器*/
@property (weak, nonatomic) IBOutlet UIView *chartView;
/*数据源*/
@property (nonatomic,strong)NSArray *dataArray;

/*第二组数据源*/
@property (nonatomic,strong)NSArray *otherDataArray;

/*时间轴*/
@property (nonatomic,strong)NSArray *labArray;

/*年份数组*/
@property (nonatomic, strong) NSArray *yearDataArr;

/*代理对象*/
@property (nonatomic,weak)id<DrinkHeaderViewDelegate> delegate;

/*用户控制是显示气泡还是单位计量*/
@property (nonatomic,assign)BOOL isShowAir;

/*描述用于展示线 控制按钮是否可以点击*/
@property (nonatomic,assign)BOOL descriptionStr;

/*描述用于展示线 控制线是否为定格显示是否为实现*/
@property (nonatomic,assign)BOOL lineStyle;

/*描述用于展示线 最大值的计量单位*/
@property (nonatomic,copy)NSString *markStr;
/*贝瑟尔曲线*/
@property (nonatomic,strong)CAShapeLayer *lineLayer;
/*计量单位uibutton*/
@property (weak, nonatomic) IBOutlet UIButton *acountOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *acountTwoBtn;

/*属性控制最大值*/
@property (nonatomic,assign)NSInteger maxScore;

@property (nonatomic,strong)NSArray *titleReloaddataArray;
@property (nonatomic,assign)BOOL isMulitueDataOrSingle;
@end