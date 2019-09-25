//
//  NewFamilyAddMessagMod.h
//  eHealthCare
//
//  Created by John shi on 2018/11/9.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewFamilyAddMessagMod : NSObject
@property (nonatomic,copy) NSString *CreateTime;
@property (nonatomic,assign) NSInteger ReadNum;
/**
 最新家人添加消息
 */
@property (nonatomic,copy) NSString *FamilyAddTitle;

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,copy) NSString *TitleName;
@end
