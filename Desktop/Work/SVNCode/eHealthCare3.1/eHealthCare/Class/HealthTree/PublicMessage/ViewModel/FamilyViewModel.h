//
//  FamilyViewModel.h
//  eHealthCare
//
//  Created by John shi on 2018/11/15.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyViewModel : NSObject
+ (void)gethometree_getFamilyResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;

+ (void)gethometree_getFamilyAddMessageResultUrlWithParams:(NSDictionary *)dic FinishedBlock:(void (^)(ResponseObject *))finish;

@end
