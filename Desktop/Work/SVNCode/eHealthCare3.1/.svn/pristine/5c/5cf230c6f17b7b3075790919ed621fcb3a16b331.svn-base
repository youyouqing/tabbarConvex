//
//  XKDetectView.h
//  eHealthCare
//
//  Created by xiekang on 2017/10/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XKDetectViewDelegate <NSObject>
-(void)dectUnableBind:(NSString *)title;


@end

@interface XKDetectView : UIView
@property (weak, nonatomic) IBOutlet UIButton *unbindBtn;
@property(weak,nonatomic)id<XKDetectViewDelegate>delegate;
@end
