//
//  XKSportsHomeModel.m
//  eHealthCare
//
//  Created by jamkin on 2017/9/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSportsHomeModel.h"

@implementation XKSportsHomeModel

/**
 当天步数、总跑步公里数总骑行公里数列
 @param modelList json序列化
 */
-(void)setModelList:(NSArray *)modelList{
    
    _modelList = modelList;
    
    _modelList = [XKSportsTypeModel objectArrayWithKeyValuesArray:modelList];
    
}

/**
 最近7条步数记录列表
 @param modelList json序列化
 */
-(void)setTopList:(NSArray *)TopList{
    
    _TopList = TopList;
    
    _TopList = [XKSportsAcountModel objectArrayWithKeyValuesArray:TopList];
    
}


/**
 咨询列表set方法重写
 @param modelList json序列化
 */
-(void)setWikiList:(NSArray *)WikiList{
    
    _WikiList = WikiList;
    
    _WikiList = [XKRecommendedWikiModel objectArrayWithKeyValuesArray:WikiList];
    
}

@end
