//
//  XKMultiFunctionResuiltsuccessUploadView.h
//  eHealthCare
//
//  Created by xiekang on 2017/11/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKMultiFunctionResuiltsuccessUploadViewDelegate <NSObject>

-(void)successUploadViewPushOtherController;


/**
 重新开始检测
 */
-(void)beginAgainToDectTool;
@end
@interface XKMultiFunctionResuiltsuccessUploadView : UIView
@property (nonatomic,assign)id <XKMultiFunctionResuiltsuccessUploadViewDelegate> delegate;
@end
