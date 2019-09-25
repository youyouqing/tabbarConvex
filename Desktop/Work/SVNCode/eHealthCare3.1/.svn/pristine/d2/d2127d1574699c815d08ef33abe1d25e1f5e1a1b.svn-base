//
//  XKCheckResultSugarView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKCheckResultSugarViewDelegate <NSObject>
-(void)selectIndex:(NSInteger)indexs andName:(NSString *)str andIsCloseView:(BOOL)ret;
@end
@interface XKCheckResultSugarView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,assign)id <XKCheckResultSugarViewDelegate> delegate;
-(void)openAllView;

-(void)closeAllView;
@end
