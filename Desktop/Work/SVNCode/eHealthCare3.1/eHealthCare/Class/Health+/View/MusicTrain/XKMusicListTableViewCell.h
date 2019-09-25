//
//  XKMusicListTableViewCell.h
//  eHealthCare
//
//  Created by xiekang on 2018/3/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKMusicListTableViewCell;
@protocol XKMusicListTableViewCellDelegate <NSObject>

-(void)listPrepare:(XKMusicListTableViewCell *)cell;//准备好了方法

@end
@interface XKMusicListTableViewCell : UITableViewCell
@property (nonatomic,weak) id<XKMusicListTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIImageView *plus_list_choose_img;

@end
