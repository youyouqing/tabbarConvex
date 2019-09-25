//
//  XKPatientTypeModel.h
//  eHealthCare
//
//  Created by jamkin on 2017/6/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKPatientTypeModel : NSObject

/**PatientTypeID
 Int32
 就诊类型编号*/
@property (nonatomic,assign) NSInteger PatientTypeID;

/**PatientTypeName
 String
 就诊类型名称*/
@property (nonatomic,copy) NSString *PatientTypeName;

@end
