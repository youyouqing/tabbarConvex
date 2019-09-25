//
//  PersonalArchiveViewController.h
//  eHealthCare
//
//  Created by xiekang on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalArchiveViewController : UIViewController
@property (nonatomic, assign) BOOL isfriend;
@property (nonatomic, assign) NSInteger MemberID;
@property (nonatomic, assign) NSInteger RecordID;




@property (nonatomic, assign) NSInteger isFirstLoadData;//isFirstLoadData== 1第一次加载数据，以后缓存
-(void)loadData;

@end


