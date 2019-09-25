//
//  FamilyViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/11/15.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "FamilyViewModel.h"

@implementation FamilyViewModel
+ (void)gethometree_getFamilyResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish
{
    [NetWorkTool postAction:hometree_getFamilyMessageListResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
}
+ (void)gethometree_getFamilyAddMessageResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    [NetWorkTool postAction:hometree_getFamilyAddMessageResultUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
@end
