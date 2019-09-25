//
//  XKSearchToolView.h
//  eHealthCare
//
//  Created by xiekang on 2017/11/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADisplayLineImageView.h"
@protocol XKSearchToolViewDelegate <NSObject>
/**
 重新开始检测
 */
-(void)beginAgainToSearchDectTool;

@end
@interface XKSearchToolView : UIView
//{
//    
//    CADisplayLineImageView *displayImageView;
//}

@property (nonatomic,assign)id <XKSearchToolViewDelegate> delegate;

 @property (weak, nonatomic)IBOutlet CADisplayLineImageView *displayImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(assign,nonatomic)NSInteger style;

/**
 设备扫描中
 */
@property (weak, nonatomic) IBOutlet UILabel *equiptScanLab;

@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIImageView *bindResultImage;


@property (weak, nonatomic) IBOutlet UIView *loadGifView;
@end
