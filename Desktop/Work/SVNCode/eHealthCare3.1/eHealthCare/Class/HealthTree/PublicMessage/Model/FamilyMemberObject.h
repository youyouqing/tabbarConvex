//
//  FamilyMemberObject.h
//  eHealthCare
//
//  Created by John shi on 2018/11/15.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyMemberObject : NSObject
@property (nonatomic,assign) NSInteger FamilyMemberID;

@property (nonatomic,copy) NSString *FamilyName;

@property (nonatomic,assign) NSInteger FamilyAddID;


@property (nonatomic,assign) NSInteger PassStatus;
@end
