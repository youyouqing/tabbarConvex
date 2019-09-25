//
//  XKHealthyCheck.h
//  eHealthCare
//
//  Created by mac on 16/12/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKBtton.h"

@protocol XKHealthyCheckDelegate <NSObject>

-(void)clickBackGround:(UIViewController *) controller withBotton:(XKBtton *)btn;

@end

@interface XKHealthyCheck : UIViewController

@property (nonatomic,strong)UITableView *hCheckTableview;

@property (nonatomic,weak) id<XKHealthyCheckDelegate> delegate;

@property (nonatomic,assign)BOOL isAccordingPersonalCheck;

@end
