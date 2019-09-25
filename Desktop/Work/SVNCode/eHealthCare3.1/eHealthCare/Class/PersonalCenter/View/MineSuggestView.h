//
//  MineSuggestView.h
//  eHealthCare
//
//  Created by xiekang on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol MineSuggestViewDelegate <NSObject>
//
//-(void)chooseFeedBackMessage;
//
//@end

@interface MineSuggestView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

/*反馈类型标签*/
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

//@property (nonatomic,weak) id<MineSuggestViewDelegate> delegate;

@end
