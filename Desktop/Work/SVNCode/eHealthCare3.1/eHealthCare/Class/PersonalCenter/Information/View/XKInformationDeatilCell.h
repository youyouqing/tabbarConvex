//
//  XKInformationDeatilCell.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHComment.h"
@class XKInformationDeatilCell;
@protocol XKInformationDeatilCellDelegate <NSObject>

@optional



- (void)topicCellForClickedMoreAction:(XKInformationDeatilCell *)topicCell didSelectRow:(MHComment *)comment;



@end

@interface XKInformationDeatilCell : UITableViewCell

@property (nonatomic , strong) MHComment *comment ;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

@property (nonatomic , weak) id <XKInformationDeatilCellDelegate> delegate;
@end
