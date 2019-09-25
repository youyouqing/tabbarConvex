//
//  RecordDetalInfoViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalArcModel.h"
@interface RecordDetalInfoViewController : BaseViewController
@property (nonatomic, strong) NSArray *bigArr;
@property (nonatomic, assign)NSInteger typeTag;
///数据源
@property (nonatomic, strong) PersonalArcModel *personalMsg;
 @property(assign,nonatomic) NSInteger userMemberID;
@end
