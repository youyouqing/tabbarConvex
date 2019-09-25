//
//  XKSportRunHeaderView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportDestinaMod.h"

@protocol XKSportRunHeaderViewDelegate <NSObject>

/**
 开始
 */
- (void)sportRunHeaderViewbuttonClick;

/**
 更换目标
 */
- (void)sportReplaceDestinaHeaderViewbuttonClick;
@end



@interface XKSportRunHeaderView : UIView
@property (nonatomic, weak) id <XKSportRunHeaderViewDelegate> delegate;
@property(nonatomic,strong)SportDestinaMod *destinaMod;//目标数据传值
@property (weak, nonatomic) IBOutlet UIImageView *runBgImage;

@end
