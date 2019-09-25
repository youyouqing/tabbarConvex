//
//  ProFileTopView.h
//  eHealthCare
//
//  Created by jamkin on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProFileTopViewDelegate <NSObject>
-(void)clickBtnProFileTopView:(NSInteger)viewTag;
@end
@interface ProFileTopView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameLal;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic,strong)NSDictionary *freshDic;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (assign, nonatomic) NSInteger editYesOrNO;
@property (weak, nonatomic) IBOutlet UIView *backView1;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UIView *backView3;
//@property (weak, nonatomic) IBOutlet UIView *backView4;
@property (weak, nonatomic) IBOutlet UIView *backView5;
@property (weak, nonatomic) IBOutlet UIView *backView6;
@property (weak, nonatomic) IBOutlet UIView *backView7;
//@property (weak, nonatomic) IBOutlet UIView *backView8;

/*图标**/
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV1;
/*标题**/
@property (weak, nonatomic) IBOutlet UILabel *titleLal1;

@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,assign)id <ProFileTopViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@end
