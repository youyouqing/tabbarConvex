//
//  TrendNewModel.h
//  eHealthCare
//
//  Created by xiekang on 16/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendNewModel : NSObject
@property (nonatomic,assign) NSInteger PhysicalItemID;
@property (nonatomic,strong) NSString *PhysicalItemName;
@property (nonatomic,assign) NSInteger TestCount;
@property (nonatomic,strong) NSString *iconImgStr;
@end
