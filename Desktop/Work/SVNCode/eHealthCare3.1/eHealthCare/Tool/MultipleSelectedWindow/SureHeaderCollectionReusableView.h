//
//  SureHeaderCollectionReusableView.h
//  MultipleSelectedWindow
//
//  Created by 刘硕 on 2016/12/23.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SureHeaderCollectionReusableViewDelegate <NSObject>


/**
点击事件传递过去
 */
- (void)SureHeaderCollectionbuttonClickAtIndex;

@end




@interface SureHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) id <SureHeaderCollectionReusableViewDelegate> delegate;
@end
