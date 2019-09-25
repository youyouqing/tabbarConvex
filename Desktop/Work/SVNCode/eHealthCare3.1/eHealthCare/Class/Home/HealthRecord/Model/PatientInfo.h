//
//  PatientInfo.h
//  eHealthCare
//
//  Created by John shi on 2018/11/3.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientInfo : NSObject
@property(nonatomic, assign)int PatientID;
@property(nonatomic, copy)NSString *AttendanceType;
@property(nonatomic, copy)NSString *DepartmentsName;

@property(nonatomic, copy)NSString *PatientPic;

@property(nonatomic, assign)long AttendanceTime;
@end
