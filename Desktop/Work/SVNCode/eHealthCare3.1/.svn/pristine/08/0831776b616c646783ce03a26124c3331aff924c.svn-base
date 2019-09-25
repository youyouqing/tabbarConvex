//
//  MoodTableViewCell.h
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MoodTableViewCellCellDelegate <NSObject>

- (void)moodButtonClick:(NSInteger)buttonIndex;

@end
@interface MoodTableViewCell : UITableViewCell
@property (nonatomic, weak) id <MoodTableViewCellCellDelegate> delegate;

@end
