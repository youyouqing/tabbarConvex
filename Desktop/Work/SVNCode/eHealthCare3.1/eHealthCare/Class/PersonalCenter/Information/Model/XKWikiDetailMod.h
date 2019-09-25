//
//  XKWikiDetailMod.h
//  eHealthCare
//
//  Created by xiekang on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTopic.h"
#import "MHComment.h"
#import "XKInfoEntityMod.h"
@interface XKWikiDetailMod : NSObject
@property (nonatomic , strong) NSArray *FirstCommentList;



@property (nonatomic , strong) XKInfoEntityMod *WikiDetailEntity;
@end
