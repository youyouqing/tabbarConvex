//
//  ArchiveHeaderView.h
//  eHealthCare
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArchiveHeaderViewDelegate <NSObject>

@optional

-(void)stopWave;

-(void)showNum:(NSInteger)num;

@end

@interface ArchiveHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *arrowOne;
@property (weak, nonatomic) IBOutlet UIImageView *arrowTwo;
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;


@property (nonatomic,weak) id<ArchiveHeaderViewDelegate> delegate;

-(void)changeTabBarControlReloadMessage;

@property (nonatomic,strong)NSArray *imgArray;

@property (weak, nonatomic) IBOutlet UIView *pCircalView;

-(void)hideCir;

@property (nonatomic,assign)BOOL isBackToZore;

/**控制是否执行过动画**/
@property (nonatomic,assign)BOOL isAnimaiton;

/**异常项的lab标签**/
@property (nonatomic,weak)UILabel *countLabel;

/**定义标示标示广告图是否加载出来**/
@property (nonatomic,assign)BOOL isNetPhoto;

@end
