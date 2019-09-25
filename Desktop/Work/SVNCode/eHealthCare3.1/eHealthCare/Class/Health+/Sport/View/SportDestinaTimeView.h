//
//  SportDestinaTimeView.h
//  eHealthCare
//
//  Created by John shi on 2018/11/17.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SportDestinaTimeViewDelegate <NSObject>

- (void)SportDestinaTimeViewCompleteClick:(NSString *)dataStr minute:(NSString *)minute;

@end
@interface SportDestinaTimeView : UIView
@property (nonatomic, weak) id <SportDestinaTimeViewDelegate> delegate;
@end
