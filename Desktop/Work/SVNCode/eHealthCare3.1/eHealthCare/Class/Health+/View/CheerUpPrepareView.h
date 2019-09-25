//
//  CheerUpPrepareView.h
//  eHealthCare
//
//  Created by John shi on 2018/7/20.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheerYourselPrepareViewDelegate <NSObject>

- (void)prepare;

@end

@interface CheerUpPrepareView : UIView

@property (nonatomic, weak) id <CheerYourselPrepareViewDelegate> delegate;

@end
