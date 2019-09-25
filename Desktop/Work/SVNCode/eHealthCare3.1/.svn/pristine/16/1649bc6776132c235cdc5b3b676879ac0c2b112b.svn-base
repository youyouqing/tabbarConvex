//
//  EidtArchvieHeaderView.h
//  eHealthCare
//
//  Created by jamkin on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalArcModel.h"
#import "PersonalDictionaryMsg.h"


@class EidtArchvieHeaderView;
@protocol EidtArchvieHeaderViewDelegate <NSObject>

@optional
-(void)justSelfHeight:(CGFloat)height withMothed:(BOOL)isMoreReduce withWay:(NSInteger)way;

-(void)changeSelf:(EidtArchvieHeaderView *)head withHeight:(CGFloat) Height;

-(void)callNormalMsg;

@end

@interface EidtArchvieHeaderView : UIView

@property (nonatomic,weak)id<EidtArchvieHeaderViewDelegate> delegate;

/**上次保存的文档信息**/
@property (nonatomic,strong)PersonalArcModel *personArc;

/**文档匹配信息**/
@property (nonatomic,strong)PersonalDictionaryMsg *personalDictionaryMsg;

@end
