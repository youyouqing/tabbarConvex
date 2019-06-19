//
//  ViewController.m
//  TabBarConvex
//
//  Created by zhangmin on 2019/6/11.
//

#import "ViewController.h"
#import "TabbarController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TabbarController *tab = [[TabbarController alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = tab;
}


@end
