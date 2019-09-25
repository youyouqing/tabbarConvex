//
//  FamilyObject.h
//  eHealthCare
//
//  Created by John shi on 2018/11/3.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyObject : NSObject
@property(nonatomic, assign)NSInteger FamilyMemberID;
@property(nonatomic, assign)int FamilyRecordID;
@property(nonatomic, copy)NSString *FamilyName;
@property(nonatomic, copy)NSString *HeadImg;

@property(nonatomic, assign)int Sex;
@property(nonatomic, assign)int Age;
@end
