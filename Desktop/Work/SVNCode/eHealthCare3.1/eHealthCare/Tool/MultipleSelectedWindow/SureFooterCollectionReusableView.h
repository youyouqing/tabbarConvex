//
//  SureFooterCollectionReusableView.h
//  MultipleSelectedWindow
//
//  Created by 刘硕 on 2016/12/23.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureFooterCollectionReusableView : UICollectionReusableView
@property (nonatomic, copy) void(^confirmBlock)(void);
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (weak, nonatomic) IBOutlet UIView *backTextInputView;

/**
 年龄底部的试图
 */
@property (weak, nonatomic) IBOutlet UIView *ageView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end
