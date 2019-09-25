//
//  SurePayController.m
//  eHealthCare
//
//  Created by xiekang on 17/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SurePayController.h"
#import "SubmitFootView.h"
#import "SubmitDataModel.h"
#import "XKPayModel.h"
#import "WXApi.h"
#import "ShopThingsModel.h"
#import "PayReusltController.h"
#import "PayFailController.h"

@interface SurePayController ()
@property (nonatomic, strong) SubmitFootView *selectView;
@property (nonatomic,strong) SubmitDataModel *dataModel;

@property (nonatomic,copy)NSString *tradeCode;

@property (nonatomic,strong)XKPayModel *payModel;

@property (nonatomic,strong)NSDictionary *payDict;

@end

@implementation SurePayController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(SubmitFootView *)selectView
{
    if (!_selectView) {
        _selectView = [[[NSBundle mainBundle] loadNibNamed:@"SubmitFootView" owner:self options:nil] lastObject];
        _selectView.frame = CGRectMake(0, 0, KScreenWidth, 150);
    }
    return _selectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTitle = @"确认支付";
    [self.view addSubview:self.selectView];
    
    //监听支付宝支付成功的回调
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipaySuccess) name:@"alipaySuccess" object:nil];
    
    //监听支付宝支付失败的回调
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayfailure) name:@"alipayfailure" object:nil];
    
    //如果是present进入页面时设置导航栏返回按钮,去付款按钮点击进入的情况
    if (self.ispresentToVC) {
        self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.isLoadData) {//需要加载数据  重新支付进入
        //从代付款中进入支付页面
        [self loadOrderData];
    }
        
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipaySuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipayfailure" object:nil];
    
}

-(void)aliPay:(NSString *)orderCode widthPrice:(CGFloat)price{

//    [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:orderCode productName:@"携康健康服务订单" productDescription:@"携康健康服务订单" amount:[NSString stringWithFormat:@"%.2lf",price] notifyURL:self.payModel.CallUrl itBPay:@"30m"];
    //    kNotifyURL
}

-(void)jumpToBizPay {

    if (![WXApi isWXAppInstalled]) {
        
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:nil message:@"您尚未安装微信" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            return ;
            
        }];
        
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            return ;
            
        }];
        
        [alertCon addAction:action1];
        [alertCon addAction:action2];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }
    //调起微信支付
    PayReq* req  = [[PayReq alloc] init];
    req.openID= self.payDict[@"appid"];
    req.partnerId =self.payDict[@"partnerid"];
    //    self.payModel.partnerId;
    req.prepayId =self.payDict[@"prepayid"];
    //    self.payModel.prepayId;
    req.nonceStr  = self.payDict[@"noncestr"];
    //    self.payModel.nonceStr;
    req.timeStamp  = [self.payDict[@"timestamp"] integerValue];
    //    self.payModel.timeStamp;
    req.package =self.payDict[@"package"];
    req.sign=self.payDict[@"sign"];
    NSLog(@"%@--%@--%@--%@--%li--%@",self.payDict[@"appid"],self.payDict[@"partnerid"],self.payDict[@"prepayid"],self.payDict[@"noncestr"],[self.payDict[@"timestamp"] integerValue],self.payDict[@"package"]);
    [WXApi sendReq:req];
  
}

-(void)clickBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 获取原订单数据（从未付款进入）
-(void)loadOrderData
{
    NSDictionary *dict=@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderID":@(self.OrderID)};
    
    [[XKLoadingView  shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"623" parameters:dict success:^(id json) {
        NSLog(@"获取确认支付信息623：%@",json);
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            [[XKLoadingView  shareLoadingView] hideLoding];
            //设置之前的支付方式
            self.dataModel = [SubmitDataModel objectWithKeyValues:dic[@"Result"]];
            self.selectView.model = self.dataModel;//还原支付方式
            
            self.tradeCode=self.dataModel.OrderCode;
 
        }else{
            [[XKLoadingView  shareLoadingView] errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView  shareLoadingView] errorloadingText:nil];
    }];
}

/**
 支付宝支付成功的监听方法
 */
-(void)alipaySuccess{
    
    PayReusltController *payresult=[[PayReusltController alloc]init];
    
    payresult.fromIndex=self.fromIndex;
    
    payresult.method=self.method;
    
    payresult.tradeCode=self.tradeCode;
    
    [self.navigationController pushViewController:payresult animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipaySuccess" object:nil];
    
}

/**
 支付宝支付失败的监听方法
 */
-(void)alipayfailure{
    
    PayFailController *failVC = [[PayFailController alloc] init];
    
    failVC.fromIndex=self.fromIndex;
    
    failVC.method=self.method;
    
    failVC.OrderID=self.OrderID;
    
    [self.navigationController pushViewController:failVC animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alipayfailure" object:nil];
    
    
}

- (IBAction)clickSurePay:(id)sender {
    NSLog(@"点击确认支付按钮,%li",self.selectView.paySelect);
    if (self.selectView.paySelect == 0) {
        [IanAlert alertError:@"请选择支付方式" length:1.0];
        return;
    }
    
    if (self.isLoadData) {
        //更新订单信息接口请求
        if (self.selectView.paySelect == self.dataModel.PayMethod) {
            //如果没有更改支付方式，从代付款进入时,不需更新订单，直接校验
            NSLog(@"直接校验，然后去支付");
            [[XKLoadingView  shareLoadingView] showLoadingText:nil];
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"613" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderID":@(self.dataModel.OrderID),@"Amount":@(self.dataModel.TotalAmount)} success:^(id json) {//生成订单验证 self.totalPrice
                
                NSLog(@"%@",json);
                
                self.payModel=[XKPayModel objectWithKeyValues:json[@"Result"]];
                self.payDict=json[@"Result"];
                
                if ([[NSString stringWithFormat:@"%@",json[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
                    
                    [[XKLoadingView  shareLoadingView] hideLoding];
                    
                    if (self.selectView.paySelect == 1) {
                        //调起支付宝支付
                        [self aliPay:self.dataModel.OrderCode widthPrice:self.dataModel.TotalAmount];//支付宝支付1,微信是2
                    }else{
                        //调起微信支付
                        [self jumpToBizPay];
                    }
                    
                    
                }else{
                    [[XKLoadingView  shareLoadingView] errorloadingText:nil];
                }
                
            } failure:^(id error) {
                
                NSLog(@"%@",error);
                [[XKLoadingView  shareLoadingView] errorloadingText:nil];
            }];
            
        }else{
            NSLog(@"更新订单信息接口请求");
            [self updateOrderPayMethod];
        }
        
    }else{
        //生成订单接口请求
        NSLog(@"生成订单接口请求");
        [self upOrderData];
    }
    
}

//更新订单信息接口请求
-(void)updateOrderPayMethod{
    NSDictionary *dict=@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderID":@(self.OrderID),@"PayMethod":@(self.selectView.paySelect)};
    
    [[XKLoadingView  shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"621" parameters:dict success:^(id json) {
        NSLog(@"更新付款方式621：%@",json);
//        [[XKLoadingView  shareLoadingView] hideLoding];
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            
            //校正订单   //支付
            
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"613" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderID":@(self.dataModel.OrderID),@"Amount":@(self.dataModel.TotalAmount)} success:^(id json) {//生成订单验证 self.totalPrice
                
                NSLog(@"%@",json);
                
                self.payModel=[XKPayModel objectWithKeyValues:json[@"Result"]];
                self.payDict=json[@"Result"];
                
                if ([[NSString stringWithFormat:@"%@",json[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
                    
                    [[XKLoadingView  shareLoadingView] hideLoding];
                    
                    if (self.selectView.paySelect == 1) {
                        //调起支付宝支付
                        [self aliPay:self.dataModel.OrderCode widthPrice:self.dataModel.TotalAmount];//支付宝支付1,微信是2
                    }else{
                        //调起微信支付
                        [self jumpToBizPay];
                    }
                    
                    
                }else{
                    [[XKLoadingView  shareLoadingView] errorloadingText:nil];
                }
                
            } failure:^(id error) {
                
                NSLog(@"%@",error);
                [[XKLoadingView  shareLoadingView] errorloadingText:nil];
            }];
            
            
        }else{
            [[XKLoadingView  shareLoadingView] errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView  shareLoadingView] errorloadingText:nil];
    }];
}

#pragma mark - 请求生成订单接口 生成订单接口交互
-(void)upOrderData
{
    NSMutableDictionary *OrderMemberDic = [[NSMutableDictionary alloc]init];
    if (self.fromIndex == 3) {
        OrderMemberDic[@"PuyType"] = @1;//购物车购买
    }else if(self.fromIndex == 1 ||self.fromIndex == 2){
        OrderMemberDic[@"PuyType"] = @2;//直接购买
    }
    
    OrderMemberDic[@"PayMethod"] = @(self.selectView.paySelect);
    OrderMemberDic[@"MemberID"] = [NSNumber numberWithInteger: [UserInfoTool getLoginInfo].MemberID];
    OrderMemberDic[@"FullName"] = self.appointDataModel.FullName;
    OrderMemberDic[@"Phone"] = self.appointDataModel.Phone;
    OrderMemberDic[@"IDCard"] = self.appointDataModel.IDCard;
    OrderMemberDic[@"Sex"] = @(self.appointDataModel.Sex);
    OrderMemberDic[@"ReserveTime"] = self.appointDataModel.ReserveTime;
    
    NSMutableArray *ShoppingCartsArr = [[NSMutableArray alloc] init];
    for (NSArray *arr in self.goodsArr) {
        for (ShopThingsModel *model in arr) {
            NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
            dic[@"ID"] = @(model.ID);
            dic[@"Type"] =@(model.Type);
            dic[@"SuitID"] = model.SuitID;
            dic[@"Count"] = @(model.Count);
            dic[@"SuitImgUrl"] = model.SuitImgUrl;
            dic[@"AgencyID"] = @(model.AgencyID);
            dic[@"Price"] = @(model.Price);
            dic[@"Discount"]=@(model.Discount);
            [ShoppingCartsArr addObject:dic];
        }
    }
    NSDictionary *dict=@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderMember":OrderMemberDic,@"ShoppingCarts":ShoppingCartsArr};
    
    [[XKLoadingView  shareLoadingView] showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"611" parameters:dict success:^(id json) {
        //刷新购物车数据
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadShopCarList" object:nil];
        NSLog(@"生成订单接口请求611：%@",json);
        NSDictionary *dic=(NSDictionary *)json;
        CGFloat pric=[[[dic objectForKey:@"Result"] objectForKey:@"TotalAmount"] floatValue];
        NSInteger number=[[[dic objectForKey:@"Result"] objectForKey:@"OrderID"] integerValue];
        
        self.OrderID=number;//给订单号赋值
        
        self.tradeCode=[[dic objectForKey:@"Result"] objectForKey:@"OrderCode"];
        
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
           
            //校正订单            //支付
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"613" parameters:@{@"Token": [UserInfoTool getLoginInfo].Token,@"OrderID":@(number),@"Amount":@(pric)} success:^(id json) {//生成订单验证 self.totalPrice
                
                NSLog(@"%@",json);
                
                self.payModel=[XKPayModel objectWithKeyValues:json[@"Result"]];
                self.payDict=json[@"Result"];
                
                if ([[NSString stringWithFormat:@"%@",json[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
                    
                    [[XKLoadingView  shareLoadingView] hideLoding];
                    
                    if (self.selectView.paySelect == 1) {
                        //调起支付宝支付
                        [self aliPay:self.tradeCode widthPrice:pric];//支付宝支付1,微信是2
                    }else{
                        //调起微信支付
                        [self jumpToBizPay];
                    }
                    
                    
                }else{
                    [[XKLoadingView  shareLoadingView] errorloadingText:nil];
                }
                
            } failure:^(id error) {
                
                NSLog(@"%@",error);
                [[XKLoadingView  shareLoadingView] errorloadingText:nil];
            }];
            
        }else{
            [[XKLoadingView  shareLoadingView] errorloadingText:nil];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView  shareLoadingView] errorloadingText:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
