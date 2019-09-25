//
//  NewPublicFrame.h
//  eHealthCare
//
//  Created by xiekang on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicNoticeModel.h"
@interface NewPublicFrame : NSObject
@property (nonatomic, assign) CGRect backFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect imgFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect moreFrame;
@property (nonatomic, assign) CGRect lineFrame;
@property (nonatomic, assign) CGRect readAllFrame;
@property (nonatomic, assign) CGRect nextIconFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) PublicNoticeModel *publicModel;

@end
