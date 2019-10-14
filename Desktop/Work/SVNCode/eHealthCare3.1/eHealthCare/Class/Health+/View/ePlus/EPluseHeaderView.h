//
//  EPluseHeaderView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EPluseHeaderViewDelegate <NSObject>
/**
 讲按钮的点击事件传递过去
 
 @param buttonIndex 主页面
 */
- (void)buttonClickEPluseHeaderViewAtIndex:(NSString *)url title:(NSString *)title index:(NSInteger)tag;
@end
@interface EPluseHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *lienView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic,strong)NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (nonatomic,weak) id<EPluseHeaderViewDelegate> delegate;
//判断是家人就隐藏   自己就显示数据箭头
@property(assign,nonatomic)BOOL isUserMemberIdPauseHiden;
@end