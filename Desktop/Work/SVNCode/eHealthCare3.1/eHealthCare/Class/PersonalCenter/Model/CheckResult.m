//
//  CheckResult.m
//  eHealthCare
//
//  Created by jamkin on 16/8/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CheckResult.h"

@implementation CheckResult

-(void)setSeftTestInfo:(NSDictionary *)SeftTestInfo{
    _SeftTestInfo=SeftTestInfo;
    self.listModel=[CheckListModel objectWithKeyValues:_SeftTestInfo];
}

@end
