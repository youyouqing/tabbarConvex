//
//  EPluseNoneDataView.h
//  eHealthCare
//
//  Created by John shi on 2019/3/1.
//  Copyright © 2019 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EPluseNoneDataViewDelegate <NSObject>

- (void)EPluseNoneDataViewButtonClick:(NSString *)nameStr;

@end




@interface EPluseNoneDataView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (nonatomic, weak) id <EPluseNoneDataViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
