//
//  XKInformationCancelView.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKInformationCancelViewDelegate <NSObject>

@optional

- (void)takePicktureBtn;

/**
 取消
 */
- (void)cancelForClicked;
/**
 发表评论

 @param topicString topicString description
 */
- (void)sureForClickedAction:(NSString *)topicString;

//删除图片后更新textview的高度
- (void)deleteDataUpdateHeghtAction;


//对图片点击完成后弹出textview
- (void)finishPicturePopTextViewAction;
/**
 开始输入数据时

 @param myTextView myTextView description
 */
- (void)beginTextViewInputData:(UITextView *)myTextView;
@end

@interface XKInformationCancelView : UIView
@property (assign, nonatomic) BOOL isTopic;//是否是话题还是资讯

@property (weak, nonatomic) IBOutlet UICollectionView *pCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pCollectionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightCons;

@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTextViewTop;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewLabTop;
@property (weak, nonatomic) IBOutlet UILabel *textViewLal;


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property (assign, nonatomic)  NSInteger ReplyerMemberID;
@property (strong, nonatomic)NSMutableArray *selectedPhotos;
@property (strong, nonatomic)NSMutableArray *selectedAssets;
@property(weak,nonatomic) id<XKInformationCancelViewDelegate>delegate;
@end
