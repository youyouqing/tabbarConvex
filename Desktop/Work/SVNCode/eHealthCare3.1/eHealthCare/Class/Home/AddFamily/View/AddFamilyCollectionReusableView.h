//
//  AddFamilyCollectionReusableView.h
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddFamilyCollectionReusableViewDelegate <NSObject>

-(void)CustomActionTools;

@end
@interface AddFamilyCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *CustomBtn;
@property(weak,nonatomic)id<AddFamilyCollectionReusableViewDelegate>delegate;
@end
