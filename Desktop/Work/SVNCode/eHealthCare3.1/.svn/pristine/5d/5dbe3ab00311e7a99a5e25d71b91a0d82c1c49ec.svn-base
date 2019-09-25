//
//  AddFamilyViewModel.m
//  eHealthCare
//
//  Created by John shi on 2018/11/3.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "AddFamilyViewModel.h"

@implementation AddFamilyViewModel
+ (void)addFamilyPersonWithParmas:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    [NetWorkTool postAction:checkHomeaddFamilyRelationUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
+ (void)addFamilyInformationPersonWithParmas:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;
{
    [NetWorkTool postAction:checkHomeaddFamilyInformationUrl params:dic finishedBlock:^(ResponseObject *response) {
        
        finish(response);
    }];
    
}
@end
