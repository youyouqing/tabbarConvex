//
//  XKInfoDetailView.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHTopic.h"
@class XKInfoDetailView;
@protocol XKInfoDetailViewDelegate <NSObject>

@optional



- (void)topicCellForClickedRow:(MHTopic *)topic XKInfoDetailView:(XKInfoDetailView *)cell;

- (void)topicCellForMoreLikeClicked:(MHTopic *)topic  XKInfoDetailView:(XKInfoDetailView *)cell;

@end

@interface XKInfoDetailView : UIView

@property (nonatomic , strong) MHTopic *topic;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic , weak) id <XKInfoDetailViewDelegate> delegate;
@end
