//
//  LoginViewController.h
//  eHealthCare
//
//  Created by John shi on 2018/6/29.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "BaseViewController.h"
#import "SportsStatisticsTool.h"

typedef void(^LoginSuccessBlock)(UIViewController *viewController);

@interface LoginViewController : BaseViewController

@property (nonatomic, strong) LoginSuccessBlock loginSuccess;

@end
