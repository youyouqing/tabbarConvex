//
//  XKCheckResultSugarTopView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKCheckResultSugarTopViewDelegate <NSObject>

/**
 选中某一行数据

 @param indexs <#indexs description#>
 @param str <#str description#>
 @param ret <#ret description#>
 */
-(void)selectIndex:(NSInteger)indexs andName:(NSString *)str andIsCloseView:(BOOL)ret;
@end

@interface XKCheckResultSugarTopView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,assign)id <XKCheckResultSugarTopViewDelegate> delegate;
/**
 打开数据
 */
-(void)openAllView;

-(void)closeAllView;
@end
