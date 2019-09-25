//
//  XKNewHomeInSectionHeadView.h
//  eHealthCare
//
//  Created by mac on 16/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKNewHomeInSectionHeadViewDelegate <NSObject>
/**
 讲按钮的点击事件传递过去
 
 @param buttonIndex 主页面
 */
- (void)buttonClickMainAtIndex:(NSString *)url title:(NSString *)title index:(NSInteger)tag;
@end
@interface XKNewHomeInSectionHeadView : UIView

@property (weak, nonatomic) IBOutlet UIView *lienView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic,strong)NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (nonatomic,weak) id<XKNewHomeInSectionHeadViewDelegate> delegate;

@end
