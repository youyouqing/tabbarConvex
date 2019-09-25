//
//  PayReusltController.m
//  eHealthCare
//
//  Created by xiekang on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PayReusltController.h"
#import "XKValidationAndAddScoreTools.h"
#import "MallViewController.h"
@interface PayReusltController ()
@property (weak, nonatomic) IBOutlet UIButton *seeOderBtn;
@property (weak, nonatomic) IBOutlet UIButton *returnHomeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHighCons;

@end

@implementation PayReusltController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"支付成功";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.seeOderBtn.clipsToBounds = YES;
    self.seeOderBtn.layer.cornerRadius = 45/2.0;
    self.seeOderBtn.layer.borderColor = kMainColor.CGColor;
    self.seeOderBtn.layer.borderWidth = 1.0;
    
    self.returnHomeBtn.clipsToBounds = YES;
    self.returnHomeBtn.layer.cornerRadius = 45/2.0;
    self.returnHomeBtn.layer.borderColor = kMainColor.CGColor;
    self.returnHomeBtn.layer.borderWidth = 1.0;
    
    if (IS_IPHONE5) {
        self.headViewHighCons.constant = 220;
    }
    
    [self.leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
//    [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(2),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(6)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(2),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(6)}];
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"624" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderCode":self.tradeCode} success:^(id json) {//完成支付回调
        
        NSLog(@"624:----%@",json);
        
        if ([[NSString stringWithFormat:@"%@",json[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            [[XKLoadingView shareLoadingView]hideLoding];
            NSLog(@"回调成功");
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
        }
        
    } failure:^(id error) {
        [[XKLoadingView shareLoadingView]errorloadingText:@"亲，网速不给力哇~"];
        NSLog(@"%@",error);
    }];
    
}

-(void)clickBack{
    if (self.fromIndex==0) {//回退到上一个控制器
        //11-16号改动
        //通知刷新商城首页
        MallViewController *mall = [[MallViewController alloc]initWithType:pageTypeNormal];
        
        [self.navigationController pushViewController:mall animated:NO];

    }
    
    if (self.fromIndex==1) {//回退到体检产品详情页面 或者 调理养生详情页面
        NSMutableArray *viewsControl=(NSMutableArray *)self.navigationController.viewControllers;
        
        if (self.method==1) {//回退到体检产品详情页面
            
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKMedicalDetail class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
            
        }
        
        if (self.method==2) {//回退到理疗产品详情页面
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKPhysicaltherapyDetial class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
        }
        
    }
    
    if (self.fromIndex==2) {//2体检理疗中心 或者理疗中心
        NSMutableArray *viewsControl=(NSMutableArray *)self.navigationController.viewControllers;
        if (self.method==1) {//回退到体检产品详情页面
            
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKMedicalCenter class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
            
        }
        
        if (self.method==2) {//回退到理疗产品详情页面
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKXKPhysicaltherapyCenter class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
        }
        
    }
    
    if (self.fromIndex==3) {//3购物车回退到购物车页面
        NSMutableArray *viewsControl=(NSMutableArray *)self.navigationController.viewControllers;
        for (UIViewController *contro in viewsControl) {
            
//            if ([contro isKindOfClass:[ShopCarController class]]) {
//                [self.navigationController popToViewController:contro animated:YES];
//            }
        }
    }
    
    if (self.fromIndex==4) {//4代付款回退到代付款页面
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - 点击事件
- (IBAction)clickSeeOrder:(id)sender {
    
    NSLog(@"点击查看订单");
    //11-16号改动
//    XKHealthMallOrderControler *order  = [[XKHealthMallOrderControler alloc] init];
//    order.isPay = YES;
//    [self.navigationController pushViewController:order animated:YES];
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.urlString = XKMyOderURL;
    web.myTitle = @"我的订单";
    [self.navigationController pushViewController:web animated:YES];
}

- (IBAction)returnHome:(id)sender {
    NSLog(@"点击返回首页");
    MallViewController *mall = [[MallViewController alloc]initWithType:pageTypeNormal];
    
    [self.navigationController pushViewController:mall animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
