//
//  XKNewHomeHeadView.h
//  eHealthCare
//
//  Created by mac on 16/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XKNewHomeHeadViewDelegate <NSObject>

@optional

-(void)stopWave;

-(void)showNum:(NSInteger)num;


/**
 讲按钮的点击事件传递过去
 
 @param buttonIndex 从0 - 8 分别代表了 健康生活
 */
- (void)buttonClickAtIndex:(NSInteger)buttonIndex;



-(void)buttonClickController:(NSString *)nameController urlString:(NSString *)url title:(NSString *)title;


//-(void)buttonClickEnterMall;

@end

@interface XKNewHomeHeadView : UIView

@property (nonatomic,strong)NSArray *imgArray;

@property (nonatomic,weak) id<XKNewHomeHeadViewDelegate> delegate;


@end
