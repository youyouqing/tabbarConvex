//
//  XKHealthIntegralTaskSuccessView.m
//  eHealthCare
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本任务完成页面弹窗

#import "XKHealthIntegralTaskSuccessView.h"
#import "MallViewController.h"
#import "BaseNavigationViewController.h"
#import "TabbarController.h"
@interface XKHealthIntegralTaskSuccessView ()
@property (weak, nonatomic) IBOutlet UIView *shadowBackView;

/**
 容器视图
 */
@property (weak, nonatomic) IBOutlet UIView *bigContainerView;

@property (weak, nonatomic) IBOutlet UIView *ThreeBtnView;


/**透明背景图*/
@property (weak, nonatomic) IBOutlet UIImageView *transparentBackImg;

@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *testHeaderTopViewCons;

@end

@implementation XKHealthIntegralTaskSuccessView

/**重写数据源set方法*/
-(void)setCompleteModel:(XKCompleteTaskModel *)completeModel{
    _completeModel = completeModel;
    //UI显示数据
//    self.kangCountLab.text = [NSString stringWithFormat:@"x%li",_completeModel.KCurrency];
//    self.tatolKValueLab.text = [NSString stringWithFormat:@"%li",_completeModel.SKValue];
    
  
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.transparentBackImg.layer.shadowColor = [UIColor redColor].CGColor;
    self.transparentBackImg.layer.shadowOffset = CGSizeMake(2, 4);
    self.transparentBackImg.layer.shadowOpacity = 1;
    self.transparentBackImg.layer.shadowRadius = 7;
//    self.transparentBackImg.layer.cornerRadius = 3;
//    self.transparentBackImg.layer.masksToBounds = YES;
    //容器视图圆角设置
    self.transparentBackImg.layer.cornerRadius = 3;
    self.transparentBackImg.layer.masksToBounds = YES;
    
    if (IS_IPHONE5) {
        self.testHeaderTopViewCons.constant = 65;
    }else if (IS_IPHONE6)
    {
         self.testHeaderTopViewCons.constant = 90;
        
    }else if (IS_IPHONE6_PLUS)
    {
         self.testHeaderTopViewCons.constant = 90;
        
    }else
         self.testHeaderTopViewCons.constant = 100;
    
//    278:405  = ksc  KScreenWidth-98-20
    self.threeBtn.layer.cornerRadius = (405*(KScreenWidth-98)/278.0 - 32 - (302*(KScreenWidth-98-20)/258.0)-30)/2.0;
    self.threeBtn.layer.masksToBounds = YES;
}
/**
 继续任务按钮的点击
 */
- (IBAction)clickContinueTask:(id)sender {
    NSLog(@"继续任务");
     [self removeFromSuperview];
    UIViewController *vc = [self currentViewController];
//    BaseNavigationViewController *nav =  [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[3];
//    [[self parentController].navigationController pushViewController:mall animated:NO];
    TabbarController *tab = (TabbarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    BaseNavigationViewController *nav =  tab.viewControllers[tab.selectedIndex];
    NoralWebViewController *web = [[NoralWebViewController alloc]initWithType:pageTypeNormal];
    web.isNewHeight = YES;
    web.urlString = kHealthTreeUrl;
    if (vc.navigationController) {
        [vc.navigationController pushViewController:web animated:YES];

    }else
        [nav pushViewController:web animated:YES];
}

/**
 关闭窗口
 */
- (IBAction)clickTaskClose:(id)sender {
    NSLog(@"关闭窗口的点击事件");
    [self removeFromSuperview];
}

@end