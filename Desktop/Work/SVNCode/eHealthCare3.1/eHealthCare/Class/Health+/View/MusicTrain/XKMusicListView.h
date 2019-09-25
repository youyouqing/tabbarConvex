//
//  XKMusicListView.h
//  eHealthCare
//
//  Created by xiekang on 2018/3/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XKMusicListViewDelegate <NSObject>

-(void)prepare:(NSInteger)row;//准备好了方法


-(void)bottomTouchRemove;
@end
@interface XKMusicListView : UIView
@property(strong,nonatomic)NSArray *imageNameArr;

/**
 选中的数组
 */
@property(strong,nonatomic)NSMutableArray *selectedBoolArr;

/**
 背景图
 */
@property(strong,nonatomic)NSArray *bg_imageNameArr;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (nonatomic,weak) id<XKMusicListViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listViewHeight;
@end
