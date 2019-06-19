//
//  TabbarController.m
//  TabBarConvex
//
//  Created by zhangmin on 2019/6/11.
//

#import "TabbarController.h"
#import "UIBarItem+XKBarItem.h"
#import "UITabBar+XKTabBar.h"
#import "UITabBarItem+XKTabBarItem.h"

@interface TabbarController ()
{
    VDGifPlayerTool *addGifView;//加载gif名
}
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation TabbarController
- (NSMutableArray *)items{
    
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
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
   
}
-(void)viewDidLoad
{
    [super viewDidLoad];
     [self addChildViewControllers];
}
- (void)addOneChildViewController:(UIViewController *)childVc image:(NSString *)imageName selectedImage:(NSString *)selectedImageName barTitle:(NSString *)barTitle navTitle:(NSString *)navTitle{
    
    
    
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = ([UIColor yellowColor]);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
}
- (void)addChildViewControllers{
    
    UIViewController *xnewHome = [[UIViewController alloc]init];
    
    [self addOneChildViewController:xnewHome image:@"icon_tab_home_normal" selectedImage:@"icon_tab_home_selected" barTitle:@"首页" navTitle:@"首页"];
    
    xnewHome.navigationController.navigationBar.translucent = NO;
    
    
    UIViewController *manager = [[UIViewController alloc]init];
    
    [self addOneChildViewController:manager image:@"icon_tab_plus_normal" selectedImage:@"icon_tab_plus_selected" barTitle:@"健康+" navTitle:@"健康+"];
    
    manager.navigationController.navigationBar.translucent = NO;
    
    
    
    UIViewController *chatListVC = [[UIViewController alloc] init];
//    chatListVC.title = @"商城";
    [self addOneChildViewController:chatListVC image:@"icon_tab_store_normal" selectedImage:@"icon_tab_store_selected" barTitle:@"商城" navTitle:@"商城"];
    
    chatListVC.navigationController.navigationBar.translucent = NO;
    
    
    
    UIViewController *profile = [[UIViewController alloc]init];
    
    profile.navigationController.navigationBar.translucent = NO;
    
    [self addOneChildViewController:profile image:@"icon_tab_my_normal" selectedImage:@"icon_tab_my_selected" barTitle:@"我的" navTitle:@""];
    
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
//    textAttrs[NSForegroundColorAttributeName] = kTabbarTextColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
//    selectedTextAttrs[NSForegroundColorAttributeName] = (Middle ==YES)?([UIColor getColor:@"73AD10"]):kMainColor;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
    
}
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    UITabBarItem *item = self.tabBar.items[2];
//    if (item.imageInsets.left == -32) {
//        
//    }else
//        item.imageInsets = UIEdgeInsetsMake(-(32), -(32/4.0), 0, -(32/4.0));// UIEdgeInsets insets = {top, left, bottom, right};
//    
//    item.imageInsets = UIEdgeInsetsMake(-16, -4, 8, -4);
//    UIImageView *itemImageView = [item gs_imageView];
//    
//    if (itemImageView && !itemImageView.userInteractionEnabled) {
//        itemImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemMiddleTap)];
//        [itemImageView addGestureRecognizer:tap];
//    }
    
}



-(void)itemMiddleTap{
    if (addGifView) {
        [addGifView remove];
        addGifView = false;
    }
    self.selectedIndex = 2;
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
