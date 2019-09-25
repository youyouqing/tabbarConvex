//
//  MusicTrainViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/7/24.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MusicTrainViewModel.h"

@implementation MusicTrainViewModel

+ (void)updateUseBehaviorWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:updateHealthPlusUserBehaviorUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}

+ (void)getMorningEverningAndMindfulnessListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:getMorningEverningAndMindfulnessListUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
+ (void)getEPluseListWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;
{
    
    
    [NetWorkTool postAction:getEpluseDataListUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
+ (void)setUserMoodWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;
{
    [NetWorkTool postAction:setUserMoodUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}


/**
 用户心情
 
 @param dic <#dic description#>
 @param finish <#finish description#>
 */
+ (void)getUserMoodWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *response))finish;
{
    
    [NetWorkTool postAction:getUserMoodUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
@end
