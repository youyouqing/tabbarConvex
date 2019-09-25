//
//  XKNewHomeHeadView.m
//  eHealthCare
//
//  Created by mac on 16/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKNewHomeHeadView.h"
#import "CarouselView.h"
#import "AdvertiseModel.h"
#import "HomeViewModel.h"
@interface XKNewHomeHeadView ()

/*头部滚动视图的view*/
@property (weak, nonatomic) IBOutlet UIView *topTopView;


/*小球容器的视图*/
@property (weak, nonatomic) IBOutlet UIView *topMiddleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTopViewHeight;



/*小球容器视图的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleHeightCons;
@property (weak, nonatomic) IBOutlet UIView *bottonLine;
/**
 底部的视图
 */
@property (weak, nonatomic) IBOutlet UIView *bView;
/**四块小字标签属性*/
@property (weak, nonatomic) IBOutlet UILabel *markLabOne;
/**
首页消息按钮的点击事件
 */
- (IBAction)homeMessageClick:(id)sender;

//携康APP3.0版本修改或新加入
/**
 首页积分按钮的点击事件
 */
- (IBAction)homeIntegralClick:(id)sender;


/**
 健康生活
 */
@property (weak, nonatomic) IBOutlet UIView *HealthtopBackView;



@property (weak, nonatomic) IBOutlet UIView *HealthLiveView;

/**改变标题的计时器*/
@property (nonatomic,strong) NSTimer *changeTaskTimer;

/**及时改变的下边*/
@property (nonatomic,assign) NSInteger changCunt;
@property (weak, nonatomic) IBOutlet UIView *containerOne;
@property (weak, nonatomic) IBOutlet UIView *containerTwo;
@property (weak, nonatomic) IBOutlet UIView *containerThree;
@property (weak, nonatomic) IBOutlet UIView *containerTwofour;


@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *healthLiveHeightCons;

@end

@implementation XKNewHomeHeadView

- (void)createUI
{
    NSArray *imageArray = @[@"icon_quyundong",@"icon_fangqingsong",@"icon_jingyijing",@"icon_ziranle",@"icon_ceshili",@"icon_casejue",@"icon_dalishi",@"icon_rourendu"];
   
    if (IS_IPHONE5) {
        self.healthLiveHeightCons.constant = 258;
    }else if (IS_IPHONE6){
        self.healthLiveHeightCons.constant = 258+20;
    }else{
        self.healthLiveHeightCons.constant = 258+40;
    }
    
    
    NSArray *titleArray = @[@"去运动",@"放轻松",@"静一静",@"自然乐",@"测视力",@"测色觉",@"大力士",@"柔韧度"];
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIView *view = [[UIView alloc]init];
        [self.bottomView  addSubview:view];
        
        CGFloat width = (KScreenWidth-12-46)/4.0;
        CGFloat height = ( self.healthLiveHeightCons.constant-45)/2.0;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo( i / 4 * height);
            make.left.mas_equalTo( i % 4 * width);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        
        
        
        //上面大的四个按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
       
        [view  addSubview:button];
      
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo( view.mas_centerX);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
        
   
        //上面大的按钮标题等
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = kMainTitleColor;
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.text = titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(KHeight(-21));
            make.centerX.mas_equalTo( view.mas_centerX);
          
            make.height.mas_equalTo(KHeight(16));
        }];
        
       
    }
    
    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth, 45) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
//    maskLayer.frame = corPath.bounds;
//    maskLayer.path=corPath.CGPath;
//    self.HealthLiveView.layer.mask=maskLayer;
    
}
#pragma mark Action
- (void)buttonClickAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickAtIndex:)]) {
        [self.delegate buttonClickAtIndex:button.tag - 100];
    }
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    //添加判断机型字体适配
    if (IS_IPHONE5) {
        self.markLabOne.font = [UIFont systemFontOfSize:9];
        self.topTopViewHeight.constant = 230/2.0;
    }
    else//IS_IPHONE6
        self.topTopViewHeight.constant = 270/2.0;
    
    self.containerOne.layer.cornerRadius = 3;
    self.containerOne.clipsToBounds = YES;
    self.containerTwo.layer.cornerRadius = 3;
    self.containerTwo.clipsToBounds = YES;
    self.containerThree.layer.cornerRadius = 3;
    self.containerThree.clipsToBounds = YES;
    self.containerTwofour.layer.cornerRadius = 3;
    self.containerTwofour.clipsToBounds = YES;
    

    
    self.backgroundColor = [UIColor whiteColor];
    self.bView.backgroundColor=kbackGroundGrayColor;
   
    if (IS_IPHONE5) {
        self.healthLiveHeightCons.constant = 258;
    }else if (IS_IPHONE6){
        self.healthLiveHeightCons.constant = 258+320;
    }else{
        self.healthLiveHeightCons.constant = 258+40;
    }

  
    
    
    [self createUI];
    
    
    self.HealthLiveView.layer.cornerRadius = 3;
    self.HealthLiveView.clipsToBounds = YES;
 
}

/**在线咨询的点击事件*/
- (IBAction)actionAdvister:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
        [self.delegate buttonClickController:@"NoralWebViewController" urlString:XKOnlineConsultantUrl title:@"在线问诊"];
    }
    
}

/**调理养生的点击事件*/
- (IBAction)actionKepping:(UIButton *)sender {
    NSLog(@"调理养生");

    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
        [self.delegate buttonClickController:@"NoralWebViewController" urlString:kConditioningRegimenUrl title:@"调理养生"];
    }
    
    
}

/**健康体检的点击事件*/
- (IBAction)actionMedical:(UIButton *)sender {
    NSLog(@"健康体检");
//    XKHomeNewHealthyCheckController *healthyCheck=[[XKHomeNewHealthyCheckController alloc]init];
//    healthyCheck.medical = XKMedicalURL;
//    [[self currentViewController].navigationController pushViewController:healthyCheck animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
        [self.delegate buttonClickController:@"NoralWebViewController" urlString:kHealthCheckUpUrl title:@"健康体检"];
    }
}

/**健康百科的点击事件*/
- (IBAction)actionNavigation:(UIButton *)sender {
    NSLog(@"健康百科");

    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
        [self.delegate buttonClickController:@"XKHomeNewHealthyCheckController" urlString:@"" title:@""];
    }
    
}

/**健康监测的点击事件*/
- (IBAction)actionReport:(id)sender {
    NSLog(@"健康监测");

    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
        [self.delegate buttonClickController:@"HealthExamineController" urlString:@"" title:@"健康监测"];
    }
}

/**预约挂号的点击事件*/
- (IBAction)actionHomCheck:(id)sender {
    NSLog(@"预约挂号");
    
        NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                              @"MemberID":@([UserInfoTool getLoginInfo].MemberID),
                              };
        [[XKLoadingView shareLoadingView]showLoadingText:nil];
        [HomeViewModel gethomeAppointmentResultUrlWithParams:dic FinishedBlock:^(ResponseObject *response) {
            [[XKLoadingView shareLoadingView] hideLoding];
            NSString *appointMentUrl = @"";//kguaHuaUrl;
            if (response.code == CodeTypeSucceed) {

              appointMentUrl =   [appointMentUrl stringByAppendingString:response.Result];

            }else
            {
                ShowErrorStatus(response.msg);
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
                [self.delegate buttonClickController:@"NoralWebViewController" urlString:appointMentUrl title:@"预约挂号"];
            }
        }];
   
   
}

/**健康档案的点击事件*/
- (IBAction)actionArchives:(id)sender {
    NSLog(@"健康档案");
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
        [self.delegate buttonClickController:@"HealthRecordController" urlString:@"" title:@"健康档案"];
    }
}

-(void)ToCheckOut{
//    NSLog(@"健康监测页面");
//    HomeSpreadController *spread=[[HomeSpreadController alloc]initWithStyle:UITableViewStyleGrouped];
//
//    spread.checkmodel=self.checkmodel;
//
//    NSLog(@"%@",self.checkmodel.TestTime);
//
//    [[self currentViewController].navigationController pushViewController:spread animated:YES];
    
}

-(void)setImgArray:(NSArray *)imgArray{
    
    [self.topTopView layoutIfNeeded];

    [self layoutIfNeeded];

    _imgArray=imgArray;

    NSMutableArray *arrya=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (AdvertiseModel *res in _imgArray) {

        [arrya addObject:res.AdvertiseImg];

    }

    for (UIView *v in self.topTopView.subviews) {

        if ([v isKindOfClass:[CarouselView class]]) {

            [v removeFromSuperview];

        }

    }
    CarouselView *scorll = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, CGRectGetHeight(self.topTopView.frame)) imageURLS:arrya];
  
    scorll.imageClickBlock = ^(NSInteger index) {
        AdvertiseModel *model = self.imgArray[index];

            if (model.LinkType == 2) {//商城
              
                if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
                    [self.delegate buttonClickController:@"MallViewController" urlString:[NSString stringWithFormat:@"%@?Token=%@&OSType=2&AppIdentify=80001",model.AdvertiseUrl,[UserInfoTool getLoginInfo].Token] title:@""];//, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]
                }
        
            }else{//直接跳转  广告页面
                if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickController:urlString:title:)]) {
                  NSString *webUrlStr =  ((AdvertiseModel *)self.imgArray[index]).AdvertiseUrl;
                    if ([webUrlStr containsString:@"?"]) {
                        
                        webUrlStr=[NSString stringWithFormat:@"%@&AppIdentify=80001&OSType=2&Token=%@",webUrlStr,[UserInfoTool getLoginInfo].Token];
                        
                    }else{
                        
                        webUrlStr=[NSString stringWithFormat:@"%@?AppIdentify=80001&OSType=2&Token=%@",webUrlStr,[UserInfoTool getLoginInfo].Token];
                        
                    }//1月14号。 修改?&为?
                    
                    [self.delegate buttonClickController:@"HealthWiKiViewController" urlString:webUrlStr title:((AdvertiseModel *)self.imgArray[index]).AdvertiseTitle];
                }
                

            }
    };
    [self.topTopView addSubview:scorll];
//    XRCarouselView *xr=[[XRCarouselView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, CGRectGetHeight(self.topTopView.frame)) imageArray:arrya];
////    [xr setPageImage:[UIImage imageNamed:@"xrcarious_Cpage"] andCurrentImage:[UIImage imageNamed:@"xrcarious_page"]];
//    xr.delegate=self;
//
//    [self.topTopView addSubview:xr];
    
}

//- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index{
//
//    AdvertiseModel *model = self.imgArray[index];
//
//    if (model.LinkType == 2) {//商城
//        XKHealthMallHome *mall = [[XKHealthMallHome alloc] init];
//        mall.homeAdvisterUrlStr = [NSString stringWithFormat:@"%@?Token=%@&OSType=2&Version=%@",model.AdvertiseUrl,[UserInfoTool getLoginInfo].Token, [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
//        mall.isTask = YES;
//        [[self currentViewController].navigationController pushViewController:mall animated:YES];
//
//    }else{//直接跳转
//        AdvertisementController *sement=[[AdvertisementController alloc]init];
//
//        sement.title=((AdvertiseModel *)self.imgArray[index]).AdvertiseTitle;
//
//        sement.webUrlStr=((AdvertiseModel *)self.imgArray[index]).AdvertiseUrl;
//        sement.model = model;
//
//        [[self currentViewController].navigationController pushViewController:sement animated:YES];
//    }
//
//}

/**计时器改变任务的方法*/
//-(void)changTask{
//    if (_treedata.IndexUnfinishedTaskList.count <= 0) {
//        return;
//    }
//    self.changCunt ++;
//    if (self.changCunt < 0) {
//        self.changCunt = 0;
//    }
//    if (self.changCunt >= _treedata.IndexUnfinishedTaskList.count ) {
//        self.changCunt = 0;
//    }
//    XKTodayUnfinishedTaskModel *today = _treedata.IndexUnfinishedTaskList[self.changCunt];
//    [self.taskListMarkLab setTitle:[NSString stringWithFormat:@"任务：%@",today.TaskTitle] forState:UIControlStateNormal];
//
//}





/**
首页信息按钮的点击事件
*/
- (IBAction)homeMessageClick:(id)sender {
//    NSLog(@"点击了首页信息");
//    ConversationListController *chatListVC = [[ConversationListController alloc] init];
////    self.messageCountBadgeLab.hidden = YES;
//    chatListVC.title = @"消息";
//     [[self parentController].navigationController pushViewController:chatListVC animated:YES];
}
/**
首页积分按钮的点击事件
*/
- (IBAction)homeIntegralClick:(id)sender {
//    NSLog(@"点击了首页积分");
//    XKHealthIntegralRewardController *reward = [[XKHealthIntegralRewardController alloc] init];
//    [[self parentController].navigationController pushViewController:reward animated:YES];
}

//健康树的点击事件
- (IBAction)clickIntegralTree:(id)sender {
//    NSLog(@"点击了健康树");
//    //跳转到任务列表
//    XKHealthIntegralTaskController *intergralTask = [[XKHealthIntegralTaskController alloc] initWithStyle:UITableViewStyleGrouped];
//    intergralTask.treeModel = self.treedata;
//
//    [[self parentController].navigationController pushViewController:intergralTask animated:YES];
//
}

/**任务按钮的点击*/
- (IBAction)clickTask:(id)sender {
    //跳转到任务列表
//    XKHealthIntegralTaskController *intergralTask = [[XKHealthIntegralTaskController alloc] initWithStyle:UITableViewStyleGrouped];
//    intergralTask.treeModel = self.treedata;
//
//    [[self parentController].navigationController pushViewController:intergralTask animated:YES];
}

@end
