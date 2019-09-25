//
//  XKTopicHomeCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKTopicModel.h"

@protocol XKTopicHomeCellDelegate <NSObject>

-(void)changeDataSource:(XKTopicModel *)model;

@end

@interface XKTopicHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic,strong) XKTopicModel *model;

@property (nonatomic,weak) id<XKTopicHomeCellDelegate> delegate;

@end
