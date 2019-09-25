//
//  SettringSwitchCell.h
//  eHealthCare
//
//  Created by jamkin on 16/8/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettringSwitchCell;
@protocol SettringSwitchCellDelegate <NSObject>

- (void)openOrCloseButton:(NSInteger)isOn cell:(SettringSwitchCell *)cell;

@end


@interface SettringSwitchCell : UITableViewCell

@property (nonatomic,copy)NSString *msg;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic,assign) NSInteger switchStatus;
@property (nonatomic, weak) id <SettringSwitchCellDelegate> delegate;

@end
