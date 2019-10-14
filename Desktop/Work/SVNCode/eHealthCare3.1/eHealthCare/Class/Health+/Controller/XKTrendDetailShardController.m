//
//  XKTrendDetailShardController.m
//  eHealthCare
//
//  Created by jamkin on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTrendDetailShardController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "DrinkHeaderView.h"
#import "NewTrendDataModel.h"
#import "TrendSuggestModel.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ShareModel.h"
#import "ShareView.h"
#import "TrendshareDetailView.h"
@interface XKTrendDetailShardController ()<DrinkHeaderViewDelegate>{
    
    NSDictionary *maxNumDic;
    NSMutableArray *oneDataArr;
    NSMutableArray *twoDataArr;
    NSMutableArray *timeArr;
    NSMutableArray *afeterTimeArr;
    NewTrendDataModel *titleModel;
    
}

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *markLab;
@property (weak, nonatomic) IBOutlet UIView *TendViewContain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (weak, nonatomic) IBOutlet UIImageView *shotImageView;
@property (nonatomic, strong)TrendshareDetailView *HeaderTView;
@end

@implementation XKTrendDetailShardController

-(TrendshareDetailView *)HeaderTView
{
    
    if (!_HeaderTView) {
        _HeaderTView = [[[NSBundle mainBundle] loadNibNamed:@"TrendshareDetailView" owner:self options:nil] firstObject];
        _HeaderTView.left=0;
        _HeaderTView.top=0;
        _HeaderTView.width=KScreenWidth;
        _HeaderTView.height= DrinkHeight+45+31+14+20+84+(414*KScreenWidth/750.0); //=702;//  比例363:354。DrinkHeight+45+31。705*KScreenWidth/375.0;
    }
    return _HeaderTView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topCons.constant = (PublicY)+6.f;
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.headerView.backgroundColor =  [UIColor whiteColor];
    self.view.backgroundColor  = kbackGroundGrayColor;
     self.titleLab.textColor = kMainTitleColor;
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickShard) forControlEvents:UIControlEventTouchUpInside];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    self.timeLab.text=[formatter stringFromDate:[NSDate date]];
    self.markLab.textColor=kMainColor;
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, PublicY, KScreenWidth, KScreenHeight-(PublicY)) style:UITableViewStyleGrouped];
    tableView.backgroundColor = kbackGroundGrayColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.tableHeaderView = self.HeaderTView;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    self.HeaderTView.shotImage.image = self.shotImage;
}

-(void)clickShard{
#pragma mark Action
    //分享
    NSArray *imageArray = @[[self screenShotView:self.HeaderTView]];
    ShareModel *model = [[ShareModel alloc]init];
    
    model.shareUrl = nil;
    model.shareTitle = @"携康e加";
    model.shareContent =@"" ;
    
    
    model.shareImageArray = imageArray;
    
    [ShareView shareActionOfShareUseFor:shareUseForShareContent shareType:shareUrl WithViewcontroller:self ShareModel:model Block:^(NSInteger tag) {
        
    } shareTree:NO];
}

- (UIImage *)getImage {
    self.rightBtn = nil;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenWidth, [UIApplication sharedApplication].keyWindow.height), NO, 0);  //NO，YES 控制是否透明
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    [self.rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickShard) forControlEvents:UIControlEventTouchUpInside];
    return image;
}
-(UIImage *)screenShotView:(UIView *)view{
    self.rightBtn = nil;
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(clickShard) forControlEvents:UIControlEventTouchUpInside];
    return imageRet;
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