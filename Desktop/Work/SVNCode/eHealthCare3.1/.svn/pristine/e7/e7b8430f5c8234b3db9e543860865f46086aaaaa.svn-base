//
//  TabbarController.m
//  eHealthCare
//
//  Created by John shi on 2018/7/2.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "TabbarController.h"
#import "HomeViewController.h"
#import "Health+ViewController.h"//这不是类别，只是健康+而已😂
#import "MallViewController.h"
#import "PersonalCenterViewController.h"
#import "BaseNavigationViewController.h"
#import "MallMiddleViewController.h"
#import "HealthTreeViewController.h"
#import "UITabBar+XKTabBar.h"
#import "UITabBarItem+XKTabBarItem.h"
#import "UIBarItem+XKBarItem.h"
#import "UIViewController+Entension.h"
#import "UIImage+GIF.h"
#import "VDGifPlayerTool.h"

@interface TabbarController ()
{
//    NSInteger preSelected;//选中之前的按钮
    VDGifPlayerTool *addGifView;//加载gif名
}
@end

@implementation TabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addAllChildVcs];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
//     [self setupUnreadMessageCount];//更新未读消息数
    

   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
//    self.tabBar.height = kTabbarHeight;
    self.delegate = self;
    UIImage *i = [UIImage imageNamed:@"line_white"];
    
    [self.tabBar setBackgroundImage:i];
    
    [self.tabBar setShadowImage:i];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [self dropShadowWithOffset:CGSizeMake(0, -0.5)
                        radius:1
                         color:[UIColor grayColor]
                       opacity:0.3];
    [self updateDayAcount];
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}

-(void)updateDayAcount{
    
    if (! [UserInfoTool getLoginInfo].Token) {
        return;
    }
    if ([SingleTon shareInstance].stepCount>0) {
        NSDictionary *dic = @{@"Token": [UserInfoTool getLoginInfo].Token,
                              @"MemberID":@( [UserInfoTool getLoginInfo].MemberID),
                              @"StepCount":[NSString stringWithFormat:@"%li",(long)([SingleTon shareInstance].stepCount>0?[SingleTon shareInstance].stepCount:0)],
                              @"KilometerCount":[NSString stringWithFormat:@"%.2lf",([SingleTon shareInstance].disT/1000)>0?([SingleTon shareInstance].disT/1000):0],
                              @"KilocalorieCount":[NSString stringWithFormat:@"%.2lf",([SingleTon shareInstance].disT/1000*65)>0?([SingleTon shareInstance].disT/1000*65):0]};
        
        
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"331" parameters:dic success:^(id json) {
            
            NSLog(@"%@-331--%@",json,@{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"StepCount":[NSString stringWithFormat:@"%i",[SingleTon shareInstance].stepCount],@"KilometerCount":[NSString stringWithFormat:@"%.1lf",[SingleTon shareInstance].disT/1000],@"KilocailorieCount":[NSString stringWithFormat:@"%.1lf",[SingleTon shareInstance].disT/1000*65]});
            
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                NSLog(@"xxxx上传步数成功");
                
                
            }else{
                NSLog(@"xxxx上传步数失败");
            }
            
        } failure:^(id error) {
//            [[XKLoadingView shareLoadingView]errorloadingText:@"网络不给力"];

        }];
    }
  
}
#pragma mark - private
- (void)addAllChildVcs
{
    HomeViewController *home = [[HomeViewController alloc]initWithType:pageTypeNoNavigation];
//    BaseNavigationViewController *homenav = [[BaseNavigationViewController alloc] initWithRootViewController:home];
//    homenav.navigationBarHidden = YES;
    [self addTabbarChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_sel"  Middlecolor:NO];

    Health_ViewController *health = [[Health_ViewController alloc]initWithType:pageTypeOnlyTitle];
//    BaseNavigationViewController *healthnav = [[BaseNavigationViewController alloc] initWithRootViewController:health];
//    healthnav.navigationBarHidden = YES;
    health.isHealthPluse = YES;
    [self addTabbarChlildVc:health title:@"e加" imageName:@"tabbar_ejia_nor" selectedImageName:@"tabbar_ejia_sel"  Middlecolor:NO];
    
    HealthTreeViewController *tree = [[HealthTreeViewController alloc]initWithType:pageTypeNoNavigation];
//    BaseNavigationViewController *treenav = [[BaseNavigationViewController alloc] initWithRootViewController:tree];
//    treenav.navigationBarHidden = YES;
    [self addTabbarChlildVc:tree title:@"健康树" imageName:@"tabbar_tree_nor" selectedImageName:@"tabbar_tree_sel" Middlecolor:YES];
    MallMiddleViewController *mall = [[MallMiddleViewController alloc]init];
//    BaseNavigationViewController *mallnav = [[BaseNavigationViewController alloc] initWithRootViewController:mall];
//    mallnav.navigationBarHidden = YES;
    [self addTabbarChlildVc:mall title:@"商城" imageName:@"tabbar_mall_nor" selectedImageName:@"tabbar_mall_sel"  Middlecolor:NO];
    
  
    
    PersonalCenterViewController *personal = [[PersonalCenterViewController alloc]initWithType:pageTypeNoNavigation];
//    BaseNavigationViewController *personalnav = [[BaseNavigationViewController alloc] initWithRootViewController:personal];
//    personalnav.navigationBarHidden = YES;
    [self addTabbarChlildVc:personal title:@"我的" imageName:@"tabbar_mine_nor" selectedImageName:@"tabbar_mine_sel" Middlecolor:NO];
    
//    XKTabBar *tabBar = [[XKTabBar alloc] initWithFrame:self.tabBar.bounds];
//
//    tabBar.tabBarItemAttributes = @[@{kTabBarItemAttributeTitle : @"首页", kTabBarItemAttributeNormalImageName : @"icon_tabbar_index_normal", kTabBarItemAttributeSelectedImageName : @"icon_tabbar_index_selected", kTabBarItemAttributeType : @(XKTabBarItemNormal)},
//
//                                     @{kTabBarItemAttributeTitle : @"e加", kTabBarItemAttributeNormalImageName : @"icon_tabbar_ejia_normal", kTabBarItemAttributeSelectedImageName : @"icon_tabbar_ejia_selected", kTabBarItemAttributeType : @(XKTabBarItemNormal)},
//
//                                    @{kTabBarItemAttributeTitle : @"健康树", kTabBarItemAttributeNormalImageName : @"icon_tabbar_tree_normal", kTabBarItemAttributeSelectedImageName : @"icon_tabbar_tree_selected", kTabBarItemAttributeType : @(XKTabBarItemNormal)},
//                                    @{kTabBarItemAttributeTitle : @"商城", kTabBarItemAttributeNormalImageName : @"icon_tabbar_shop_normal", kTabBarItemAttributeSelectedImageName : @"icon_tabbar_shop_selected", kTabBarItemAttributeType : @(XKTabBarItemNormal)},
//
//                                    @{kTabBarItemAttributeTitle : @"我的", kTabBarItemAttributeNormalImageName : @"icon_tabbar_my_normal", kTabBarItemAttributeSelectedImageName : @"icon_tabbar_my_selected", kTabBarItemAttributeType : @(XKTabBarItemNormal)}];
//
//
//    self.viewControllers = @[homenav,healthnav ,treenav, mallnav, personalnav];
//    [self.tabBar addSubview:tabBar];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    viewController.tabBarItem.gs_imageView.transform = CGAffineTransformMakeScale(0.1,0.1);
//    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
//    [UIView animateWithDuration: 0.7 delay:0.1 usingSpringWithDamping:0.25 initialSpringVelocity:0.3 options:0 animations:^{
//        // 放大
//        viewController.tabBarItem.gs_imageView.transform = CGAffineTransformMakeScale(1,1);
//    } completion:nil];
//    NSString *str = [[NSBundle mainBundle]pathForResource:@"home" ofType:@"gif"];
//
//    NSData *data = [NSData dataWithContentsOfFile:str];
//
//    viewController.tabBarItem.gs_imageView.image =  [UIImage sd_animatedGIFWithData:data];//[UIImage sd_animatedGIFWithData:data];
    NSString *gifName = @"";
    if (self.selectedIndex == 0) {
        gifName = @"home";
    }
    else if (self.selectedIndex == 1) {
        gifName = @"epluse";
    }
    else if (self.selectedIndex == 4) {
        gifName = @"Mine";
    }
    if (gifName.length>0) {
        VDGifPlayerTool *addGif =  [[VDGifPlayerTool alloc]init];
        if (addGifView) {
            [addGifView remove];
        }
        [addGif startAnimateGifMethod:gifName toView:viewController.tabBarItem.gs_imageView];
        addGifView = addGif;
    }
//    preSelected = self.selectedIndex;
}
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    if (preSelected!=self.selectedIndex) {
//        NSLog(@"被选中的控制器将要显示的按钮");
//        BaseNavigationViewController *nav = tabBarController.viewControllers[preSelected];
//        [nav.tabBarItem.gs_imageView stopAnimating];
//    }
////
////    [viewController.tabBarItem.gs_imageView stopAnimating];
//    return YES;
//
//}
- (void)addTabbarChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName Middlecolor:(BOOL)Middle;
{
    childVc.title = title;
    

    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kTabbarTextColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    

    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = (Middle ==YES)?([UIColor getColor:@"73AD10"]):kMainColor;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];

    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
   
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
  
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:childVc];
     nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
    
}
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UITabBarItem *item = self.tabBar.items[2];
    if (item.imageInsets.left == -32) {
        
    }else
    item.imageInsets = UIEdgeInsetsMake(-(32), -(32/4.0), 0, -(32/4.0));// UIEdgeInsets insets = {top, left, bottom, right};
    
    item.imageInsets = UIEdgeInsetsMake(-16, -4, 8, -4);
    UIImageView *itemImageView = [item gs_imageView];

    if (itemImageView && !itemImageView.userInteractionEnabled) {
        itemImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemMiddleTap)];
        [itemImageView addGestureRecognizer:tap];
    }
    
}



-(void)itemMiddleTap{
    if (addGifView) {
        [addGifView remove];
        addGifView = false;
    }
    self.selectedIndex = 2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
