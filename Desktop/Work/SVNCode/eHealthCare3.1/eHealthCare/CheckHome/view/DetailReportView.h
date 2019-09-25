//
//  DetailReportView.h
//  eHealthCare
//
//  Created by xiekang on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailReportModel.h"

@protocol DetailReportViewDelegate <NSObject>
-(void)clickOpenBtn:(NSInteger)index;
@end

@interface DetailReportView : UIView
@property(nonatomic,strong)DetailReportModel *dataModel;
@property(nonatomic,assign)id <DetailReportViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

/**
 设置ImageView的点击事件
 */
-(void)setTarget:(id)target action:(SEL)action;

@end
