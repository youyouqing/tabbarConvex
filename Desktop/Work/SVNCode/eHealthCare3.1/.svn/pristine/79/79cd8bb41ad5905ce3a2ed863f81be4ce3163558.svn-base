//
//  MHCommentCell.h
//  MHDevelopExample
//
//  Created by CoderMikeHe on 17/2/8.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHCommentFrame,MHCommentCell;

@protocol MHCommentCellDelegate <NSObject>

@optional
/** 点击评论的昵称 */
- (void) commentCell:(MHCommentCell *)commentCell ;

@end


@interface MHCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 评论Frame */
@property (nonatomic , strong) MHCommentFrame *commentFrame;
/** 代理 */
@property (nonatomic , weak) id <MHCommentCellDelegate> delegate;
@end
