//
//  XKHotTopicTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/11/2.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKTopicModel.h"

@protocol XKHotTopicTableViewCellDelegate <NSObject>

-(void)changeHotTopicChildDataSoure:(XKTopicModel *)mdoel;
//查看大图
-(void)jumpTopTopicBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
@end
@interface XKHotTopicTableViewCell : UITableViewCell

@property (nonatomic,strong) XKTopicModel *model;

@property (nonatomic,weak) id<XKHotTopicTableViewCellDelegate> delegate;
@end
