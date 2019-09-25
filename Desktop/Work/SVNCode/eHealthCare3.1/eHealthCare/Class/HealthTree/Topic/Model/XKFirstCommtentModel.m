//
//  XKFirstCommtentModel.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKFirstCommtentModel.h"

@implementation XKFirstCommtentModel

-(void)setSecondCommentList:(NSArray *)SecondCommentList{
    
    _SecondCommentList = SecondCommentList;
    
    _SecondCommentList = [XKSecondeCommtentModel objectArrayWithKeyValuesArray:_SecondCommentList];
    
}

@end
