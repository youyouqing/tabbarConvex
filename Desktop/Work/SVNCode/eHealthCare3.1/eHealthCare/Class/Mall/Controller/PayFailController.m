//
//  PayFailController.m
//  eHealthCare
//
//  Created by xiekang on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PayFailController.h"
#import "SurePayController.h"
#import "MallViewController.h"
@interface PayFailController ()

@property (weak, nonatomic) IBOutlet UIButton *againPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *seeOrderBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHighCons;

@end

@implementation PayFailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitle = @"支付失败";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.againPayBtn.clipsToBounds = YES;
    self.againPayBtn.layer.cornerRadius = 45/2.0;
    self.againPayBtn.layer.borderColor = kMainColor.CGColor;
    self.againPayBtn.layer.borderWidth = 1.0;
    //11-16号改动
    self.againPayBtn.hidden = YES;
    
    self.seeOrderBtn.clipsToBounds = YES;
    self.seeOrderBtn.layer.cornerRadius = 45/2.0;
    self.seeOrderBtn.layer.borderColor = kMainColor.CGColor;
    self.seeOrderBtn.layer.borderWidth = 1.0;
    
    if (IS_IPHONE5) {
        self.headViewHighCons.constant = KScreenHeight/2.0 -64;
    }
    [self.leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)clickBack{
    if (self.fromIndex==0) {//回退到上一个控制器

        //11-16改动
        MallViewController *mall = [[MallViewController alloc]initWithType:pageTypeNormal];
      
        [self.navigationController pushViewController:mall animated:NO];

    }
    
    if (self.fromIndex==1) {//回退到体检产品详情页面 或者 调理养生详情页面
        NSMutableArray *viewsControl=(NSMutableArray *)self.navigationController.viewControllers;
        
        if (self.method==1) {//回退到体检产品详情页面   套餐详情
            
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKMedicalDetail class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
            
        }
        
        if (self.method==2) {//回退到理疗产品详情页面   套餐详情
            for (UIViewController *contro in viewsControl) {
//
//                if ([contro isKindOfClass:[XKPhysicaltherapyDetial class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
        }
        
    }
    
    if (self.fromIndex==2) {//2体检理疗中心 或者理疗中心
        NSMutableArray *viewsControl=(NSMutableArray *)self.navigationController.viewControllers;
        if (self.method==1) {//回退到体检产品详情页面  体检预约
            
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKMedicalCenter class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
            
        }
        
        if (self.method==2) {//回退到理疗产品详情页面  理疗预约
            for (UIViewController *contro in viewsControl) {
                
//                if ([contro isKindOfClass:[XKXKPhysicaltherapyCenter class]]) {
//                    [self.navigationController popToViewController:contro animated:YES];
//                }
                
            }
        }
        
    }
    
    if (self.fromIndex==3) {//3购物车回退到购物车页面   购物车
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

- (IBAction)clickAgainBtm:(id)sender {
    NSLog(@"点击重新支付");
    
    SurePayController *surePay=[[SurePayController alloc]init];
    
    surePay.OrderID = self.OrderID;
    surePay.fromIndex=self.fromIndex;
    surePay.isLoadData=YES;
    surePay.method=self.method;
    
    [self.navigationController pushViewController:surePay animated:YES];
    
}

- (IBAction)clickSeeOrderBtn:(id)sender {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
