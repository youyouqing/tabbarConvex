//
//  XKValidationAndAddScoreTools.h
//  eHealthCare
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKCompleteTaskModel.h"

@interface XKValidationAndAddScoreTools : NSObject

-(XKCompleteTaskModel *)validationAndAddScore:(NSDictionary *)validationDict withAdd:(NSDictionary *)addScoreDcit isPopView:(BOOL)isPopView;



@end
