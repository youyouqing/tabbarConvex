//
//  XKHotTopicChildCell.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKTopicModel.h"

@protocol XKHotTopicChildCellDelegate <NSObject>

-(void)changeTopicDataSoure:(XKTopicModel *)mdoel;
-(void)jumpTopXKHotTopicChildCellBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;

@end

@interface XKHotTopicChildCell : UITableViewCell

@property (nonatomic,strong) XKTopicModel *model;

@property (nonatomic,weak) id<XKHotTopicChildCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *backSingleView;

@end
