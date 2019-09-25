
//
//  ArchiveHeaderView.m
//  eHealthCare
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ArchiveHeaderView.h"
#import "SXWaveView.h"
#import "SXHalfWaveView.h"
#import "XKArchiveTransetionDelegateModel.h"
#import "AdviserListController.h"
#import "CheckController.h"
#import "Deploy.h"
#import "HomeSpreadController.h"
#import "CheckListModel.h"
#import "ArchiveViewController.h"
#import "WTImageScroll.h"
#import "ProserveController.h"
#import "SubhealthyController.h"
#import "AdvertiseModel.h"
#import "HomeCheckModel.h"
#import "NewHomeModel.h"
//#import "AdvisterImageView.h"
#import "AdvertisementController.h"
#import "XRCarouselView.h"

@interface ArchiveHeaderView ()<XRCarouselViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *topScl;

@property (weak, nonatomic) IBOutlet UIImageView *topBackImg;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidthCons;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic,weak)UILabel *lasttimeLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;

@property (nonatomic,strong)NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *actionOne;
@property (weak, nonatomic) IBOutlet UIButton *actionTwo;
@property (weak, nonatomic) IBOutlet UIButton *actionThree;
@property (weak, nonatomic) IBOutlet UIButton *actionFour;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightCons;

@property (weak, nonatomic) IBOutlet UIView *horizontalLineView;

@property (weak, nonatomic) IBOutlet UIView *vertailLineView;

@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@property (nonatomic,strong)XKArchiveTransetionDelegateModel *archiveCoverDelegate;

@property (nonatomic,assign)CGFloat timeY;

@property (nonatomic,strong)NSMutableArray *labelArray;

@property (nonatomic,strong)SXWaveView *currentAnimationView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pCircalViewXCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pCircalViewYCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pCircalViewHeightCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pCircalViewWidthCons;

@property (nonatomic,strong)UIImageView *img;

@property (nonatomic,strong)NSTimer *phoptoTimer;

@property (nonatomic,assign)BOOL isNext;

@property (nonatomic,strong)Deploy *deploy;

@property (nonatomic,assign)CGRect recordImgFrame;

/**定义属性存放加载的数据**/
@property (nonatomic,strong)NewHomeModel *checkmodel;

/**定义属性数组表示用户的异常项目**/
@property (nonatomic,strong)NSArray *abnormalProdct;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (nonatomic,assign)NSInteger showcountBrand;

@end

@implementation ArchiveHeaderView

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

-(void)setImgArray:(NSArray *)imgArray{
    
    [self.topScl layoutIfNeeded];
    
    [self layoutIfNeeded];
    
    _imgArray=imgArray;
    
    NSMutableArray *arrya=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (AdvertiseModel *res in _imgArray) {
        
        [arrya addObject:res.AdvertiseImg];
        
    }
    
    for (UIView *v in self.topScl.subviews) {
        
        if ([v isKindOfClass:[XRCarouselView class]]) {
            
            [v removeFromSuperview];
            
        }
        
    }
    
    XRCarouselView *xr=[[XRCarouselView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.topScl.frame), CGRectGetMinY(self.topScl.frame), KScreenWidth, CGRectGetHeight(self.topScl.frame)) imageArray:arrya];
//      [xr setPageImage:[UIImage imageNamed:@"xrcarious_Cpage"] andCurrentImage:[UIImage imageNamed:@"xrcarious_page"]];
    xr.delegate=self;
    
    [self.topScl addSubview:xr];
    
}

- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index{
    
    AdvertisementController *sement=[[AdvertisementController alloc]init];
    
    sement.title=((AdvertiseModel *)self.imgArray[index]).AdvertiseTitle;
    
    sement.webUrlStr=((AdvertiseModel *)self.imgArray[index]).AdvertiseUrl;
    
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:sement];
    
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [[self currentViewController] presentViewController:nav animated:YES completion:nil];
    
    
}

-(XKArchiveTransetionDelegateModel *)archiveCoverDelegate{
    
    if (!_archiveCoverDelegate) {
        _archiveCoverDelegate=[[XKArchiveTransetionDelegateModel alloc]init];
    }
    
    return _archiveCoverDelegate;
}

-(Deploy *)deploy{
    
    if (!_deploy) {
        
        _deploy=[[Deploy alloc]init];
        
    }
    
    return _deploy;
    
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.showcountBrand=0;
    
    self.isAnimaiton=NO;
        
    CGFloat lableHeight=20;
    
    CGFloat lableY=110;
    if (IS_IPHONE5) {
        lableY=110;
    }
    
    if (IS_IPHONE6) {
        lableY=130;
    }
    
    if (IS_IPHONE6_PLUS) {
        lableY=140;
    }
    
    self.timeY=lableY;
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, lableY, KScreenWidth, lableHeight)];
    lable.font=[UIFont systemFontOfSize:14];
    lable.textColor=COLOR(232, 248, 249, 1);
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=@"";
    lable.font=[UIFont systemFontOfSize:12];
    [self.topView addSubview:lable];
    self.lasttimeLable=lable;
    
    UILabel *countLabel=[[UILabel alloc]init];
    countLabel.frame=CGRectMake(0, 0, 0, 0);
    countLabel.textColor=COLOR(255, 240, 0, 1);
    countLabel.text=@"0项异常";
    countLabel.textAlignment=NSTextAlignmentCenter;
    if (IS_IPHONE5) {
        
        countLabel.font=[UIFont systemFontOfSize:24];
        
    }else{
        
        countLabel.font=[UIFont systemFontOfSize:25];
        
    }
    
    [self.topView addSubview:countLabel];
    self.countLabel=countLabel;
    self.countLabel.hidden=YES;
    
    self.lineWidthCons.constant=0.5;
    self.lineHeightCons.constant=0.5;

    self.horizontalLineView.backgroundColor=[UIColor getColor:@"d8d8d8"];
    self.vertailLineView.backgroundColor=[[UIColor getColor:@"434343"] colorWithAlphaComponent:0.6];
    
    NSString *str=@"你的健康状态好过全国0%的人";
    
    NSMutableAttributedString *attri=[NSMutableAttributedString createColorString:str withExcision:@"0%" dainmaicColor:COLOR(51, 51, 51, 1) excisionColor:ORANGECOLOR];
    
    [self.remarkLabel setAttributedText:attri];
    
    [self clipsButtonImg:self.actionOne];
    [self clipsButtonImg:self.actionTwo];
    [self clipsButtonImg:self.actionThree];
    [self clipsButtonImg:self.actionFour];
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(animateToArrow) userInfo:nil repeats:YES];
    
    
    self.arrowOne.hidden=YES;
    self.arrowTwo.hidden=YES;
    self.arrowButton.hidden=YES;
    NSRunLoop *loop=[NSRunLoop currentRunLoop];
    [loop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.pCircalViewXCons.constant=KScreenWidth/2-130/2;
    
    self.pCircalViewYCons.constant=self.timeY+40-CGRectGetMaxY(self.topScl.frame);
    
    self.pCircalView.layer.cornerRadius=130/2;
    
    self.pCircalView.layer.masksToBounds=YES;
    
    self.pCircalView.layer.borderColor=[[UIColor colorWithRed:34/255.0 green:176/255.0  blue:196/255.0  alpha:1]CGColor];
    
    self.pCircalView.layer.borderWidth=10;
    
    /**接收到将要离开这个页面的通知**/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endCircalAnimation) name:@"endAnimation" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homeFresh) name:@"homeFresh1" object:nil];
    
}


-(void)commonFreshScore{
    
    XKLOG(@"立即检测");
    
    self.isAnimaiton=YES;
    
    if (self.showcountBrand!=1) {
        
        [[XKLoadingView shareLoadingView]showLoadingText:@"加载中..."];
        
    }
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"305" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[UserInfoTool getLoginInfo].MemberID} success:^(id json) {
        
        XKLOG(@"%@",json);
        
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            if (self.showcountBrand!=1) {
                [[XKLoadingView shareLoadingView]hideLoding];
            }
            self.checkmodel=[NewHomeModel objectWithKeyValues:[json objectForKey:@"Result"]];
            
            NSString *nullStr=self.checkmodel.Ranking?self.checkmodel.Ranking:@"0%";
            
            NSString *str=[NSString stringWithFormat:@"你的健康状态好过%@的人",nullStr];
            
            NSMutableAttributedString *attri=[NSMutableAttributedString createColorString:str withExcision:nullStr dainmaicColor:COLOR(51, 51, 51, 1) excisionColor:ORANGECOLOR];
            
            [self.remarkLabel setAttributedText:attri];
            
            if (self.checkmodel.TestTime.length==0) {
                
                self.lasttimeLable.text=@"您还没有体检过!";
                
            }else{
                
                self.lasttimeLable.text=[NSString stringWithFormat:@"上次体检于 %@",self.checkmodel.TestTime];
                
            }
            
            self.pCircalView.hidden=YES;
            
            [self changeTabBarControlReloadMessage];
            
        }else{
            
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作失败"]) {
                if (self.showcountBrand!=1) {
                    [[XKLoadingView shareLoadingView]errorloadingText:@"您还没有进行检测"];
                }
            }
            
            XKLOG(@"操作失败");
            if (self.showcountBrand!=1) {
                [[XKLoadingView shareLoadingView]errorloadingText:[[json objectForKey:@"Basis"] objectForKey:@"Msg"]];
            }
            
            self.isAnimaiton=NO;
            
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        if (self.showcountBrand!=1) {
            [[XKLoadingView shareLoadingView]errorloadingText:error];
        }
        self.isAnimaiton=NO;
        
    }];
    
}

-(void)homeFresh{
    
    if (self.isAnimaiton) {
        [self commonFreshScore];
    }else{
        return;
    }
    
}

/**通知监听方法  接收到通知的时候  结束小球动画**/
-(void)endCircalAnimation{
    
    self.currentAnimationView.x=25;
        
    self.img.x=25;
    
    [self circalConmmonMothed];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"endAnimation" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"homeFresh1" object:nil];
    
}

- (IBAction)clickCheckout:(id)sender {
    
    [self commonFreshScore];
    
}

-(void)clipsButtonImg:(UIButton *)btn{
    
    btn.layer.cornerRadius=8;
    
    btn.layer.masksToBounds=YES;
    
    btn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    btn.imageView.clipsToBounds=YES;
    
}

-(void)animateToArrow{
    
    [UIView animateWithDuration:2.0 animations:^{
        
        self.arrowTwo.transform=CGAffineTransformTranslate(self.arrowTwo.transform, 0, -5);
        self.arrowOne.transform=CGAffineTransformTranslate(self.arrowOne.transform, 0, -3);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 animations:^{
            
            self.arrowTwo.alpha=0;
            
            self.arrowOne.alpha=0;
            
        } completion:^(BOOL finished) {
            
            self.arrowTwo.transform=CGAffineTransformIdentity;
            
            self.arrowTwo.alpha=1;
            
            self.arrowOne.transform=CGAffineTransformIdentity;
            
            self.arrowOne.alpha=1;
            
        }];
        
    }];
    
}

-(void)hideCir{
    
    for (UIView *v in self.topView.subviews) {
        
        if (v!=self.arrowButton) {
            
            if ([v isKindOfClass:[SXWaveView class]]||[v isKindOfClass:[UIButton class]]) {
                
                [v removeFromSuperview];
                
            }
        }
        
    }
    
    for (int i=0;i<self.labelArray.count;i++) {
        
        UILabel *lab=self.labelArray[i];
        
        [self.labelArray removeObject:lab];
        
    }
    
    for (UIView *v in self.topView.subviews) {
        
        if ([v isKindOfClass:[UILabel class]]) {
            
            UILabel *txt=(UILabel *)v;
            
            if (txt!=self.countLabel&&txt!=self.lasttimeLable) {
                
                [txt removeFromSuperview];
                
            }
            
        }
        
    }
    
    self.labelArray=nil;
    self.labelArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    self.arrowButton.hidden=YES;
    self.arrowOne.hidden=YES;
    self.arrowTwo.hidden=YES;
    self.countLabel.hidden=YES;
    
    self.img.frame=self.recordImgFrame;
    
}

-(void)changeTabBarControlReloadMessage{
        
    [self hideCir];
    
    CGFloat width=120;
    CGFloat height=120;
    
    if (IS_IPHONE6) {
        
        width=125;
        
        height=125;
        
    }
    
    if (IS_IPHONE6_PLUS) {
        
        width=150;
        
        height=150;
        
    }
    
    SXWaveView *animateView2 = [[SXWaveView alloc]initWithFrame:CGRectMake(KScreenWidth/2-width/2,self.timeY+40,width, height)];
    
    if (!self.img) {
        
        self.img=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-width/2,self.timeY+40,width, height)];
        
        [self addSubview:self.img];
        
        self.recordImgFrame=self.img.frame;
        
    }else{
        
        self.img.frame=CGRectMake(KScreenWidth/2-width/2,self.timeY+40,width, height);
        
    }
    
    self.img.contentMode=UIViewContentModeScaleAspectFill;
    
    self.img.clipsToBounds=YES;
    
    self.img.image=[UIImage imageNamed:@"toumingquan"];

    self.currentAnimationView=animateView2;
    
    self.delegate=(id)animateView2;
    
    for (int i=0;i<self.checkmodel.ExceptionItemList.count;i++) {//创建异常项的label
        
        if (i<3) {
            
            UILabel *label=[[UILabel alloc]init];
            label.textColor=COLOR(234, 249, 251, 1);
            label.text=((ExceptionItemModel *)self.checkmodel.ExceptionItemList[i]).ExceptionItemName;
            label.textAlignment=NSTextAlignmentCenter;
            
            label.adjustsFontSizeToFitWidth=YES;
            
            if (IS_IPHONE5) {
                
                label.font=[UIFont systemFontOfSize:13];
                
            }else{
                
                label.font=[UIFont systemFontOfSize:14];
                
            }
            
            label.hidden=YES;
            
            [self.labelArray addObject:label];
            
            [self.topView addSubview:label];
            
        }
        
    }
    
    if (self.checkmodel.ExceptionItemList.count<self.checkmodel.ExceptionCount) {//判断一场项是否显示完全
        
        UILabel *label=[[UILabel alloc]init];
        label.textColor=COLOR(234, 249, 251, 1);
        label.text=@". . .";
        label.textAlignment=NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth=YES;
        
        if (IS_IPHONE5) {
            
            label.font=[UIFont systemFontOfSize:13];
            
        }else{
            
            label.font=[UIFont systemFontOfSize:14];
            
        }
        
        label.hidden=YES;
        
        [self.labelArray addObject:label];
        
        [self.topView addSubview:label];
        
    }
    
    if (self.checkmodel.TestTime.length==0) {//判断异常项目是否为空
        
        UILabel *label=[[UILabel alloc]init];
        label.textColor=COLOR(234, 249, 251, 1);
        label.text=@"请先检测";
        label.textAlignment=NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth=YES;
        
        if (IS_IPHONE5) {
            
            label.font=[UIFont systemFontOfSize:22];
            
        }else{
            
            label.font=[UIFont systemFontOfSize:23];
            
        }
        
        label.hidden=YES;
        
        [self.labelArray addObject:label];
        
        [self.topView addSubview:label];
        
    }
    
    if (self.checkmodel.ExceptionCount==0&&self.checkmodel.TestTime.length!=0) {
        //            请继续保持!
        UILabel *label=[[UILabel alloc]init];
        label.textColor=COLOR(234, 249, 251, 1);
        label.text=@"状态良好,";
        label.textAlignment=NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth=YES;
        
        if (IS_IPHONE5) {
            
            label.font=[UIFont systemFontOfSize:24];
            
        }else{
            
            label.font=[UIFont systemFontOfSize:25];
            
        }
        
        label.hidden=YES;
        
        UILabel *label1=[[UILabel alloc]init];
        label1.textColor=COLOR(234, 249, 251, 1);
        label1.text=@"请继续保持!";
        label1.textAlignment=NSTextAlignmentCenter;
        
        label1.adjustsFontSizeToFitWidth=YES;
        
        if (IS_IPHONE5) {
            
            label1.font=[UIFont systemFontOfSize:24];
            
        }else{
            
            label1.font=[UIFont systemFontOfSize:25];
            
        }
        
        label1.hidden=YES;
        
        [self.labelArray addObject:label];
        
        [self.topView addSubview:label];
        
        [self.labelArray addObject:label1];
        
        [self.topView addSubview:label1];
        
    }
    
    self.countLabel.text=[NSString stringWithFormat:@"%li项异常",self.checkmodel.ExceptionCount>0?self.checkmodel.ExceptionCount:0];
    
//    for (UserScore *score in self.checkmodel.ScoreRecordList) {
//        
//        if ([score.Type isEqualToString:@"ZF"]) {
//            
//            XKLOG(@"%li",(NSInteger)score.Score);
    
    NSInteger scoro=0;
    
    scoro=self.checkmodel.TotalScore>0?self.checkmodel.TotalScore:0;
    
    [animateView2 setPrecent:scoro description:@"分"];
    
//            break;
    
//        }
    
//    }
    
    //79 40
    [animateView2 setAlpha:0.8 clips:YES endless:YES];
    [animateView2 setTextColor:[UIColor whiteColor] bgColor:COLOR(60, 202, 220, 1) waterColor:COLOR(90, 222, 236, 1)];
    [animateView2 setUpdating:YES];
    [self.topView addSubview:animateView2];
    
    [animateView2 addAnimateWithType:0];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (NSInteger)(4 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            animateView2.x=25;
            
            if (animateView2==self.currentAnimationView) {
                
                self.img.x=25;
                
            }
            
        }];
        
        dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, (NSInteger)(0.5 * NSEC_PER_SEC));
        dispatch_after(time1, dispatch_get_main_queue(), ^{
            
            if (animateView2==self.currentAnimationView) {

                [self circalConmmonMothed];
                
            }
            
        });
        
    });
    
    [self.topView bringSubviewToFront:self.arrowOne];
    
    [self.topView bringSubviewToFront:self.arrowTwo];
    
    [self.topView sendSubviewToBack:self.pCircalView];
    
    [self.topView bringSubviewToFront:self.arrowButton];
    
}

/**提取小球动画相关的公共方法**/
-(void)circalConmmonMothed{
    
    self.countLabel.hidden=NO;
    self.arrowTwo.hidden=NO;
    self.arrowOne.hidden=NO;
    
    self.arrowButton.hidden=NO;
    
    CGFloat labelX=CGRectGetMaxX(self.currentAnimationView.frame)+10;
    CGFloat lableWidth=KScreenWidth-CGRectGetMaxX(self.currentAnimationView.frame)+10;
    
    self.countLabel.frame=CGRectMake(labelX, CGRectGetMinY(self.currentAnimationView.frame),lableWidth, 30);
    
//    if (self.labelArray.count==0&&self.checkmodel.TestTime.length!=0) {
//        
//        self.countLabel.text=@"健康状态良好，请继续保持！";
//        
//        self.countLabel.numberOfLines=0;
//        
//        self.countLabel.textColor=[UIColor whiteColor];
//        
//    }
    
    for (int i=0; i<self.labelArray.count; i++) {
        
        UILabel *lab=self.labelArray[i];
        
        lab.hidden=NO;
        
        if (i==0) {
            
            if (IS_IPHONE6_PLUS) {
                
                lab.frame=CGRectMake(labelX,CGRectGetMaxY(self.countLabel.frame)+7, lableWidth, 25);
                
            }else{
                
                 lab.frame=CGRectMake(labelX,CGRectGetMaxY(self.countLabel.frame)+2, lableWidth, 25);
                
            }
            
        }else{
            
            UILabel *lastLable=self.labelArray[i-1];
            
            CGFloat LY=CGRectGetMaxY(lastLable.frame);
            
            if (IS_IPHONE6_PLUS) {
                
                LY+=7;
                
            }
            
            if (i==3) {
                
                lab.frame=CGRectMake(labelX,LY, lableWidth, 10);
                
            }else{
                
                 lab.frame=CGRectMake(labelX,LY, lableWidth, 25);
                
            }
            
        }
        
    }
    
    if (self.labelArray.count==2) {
        
        UILabel *lab=self.labelArray[0];
        
        if ([lab.text isEqualToString:@"状态良好,"]) {
            
            self.countLabel.hidden=YES;
            
        }
        
        lab.hidden=NO;
        
//        lab.frame=CGRectMake(labelX,CGRectGetMaxY(self.currentAnimationView.frame)-CGRectGetHeight(self.currentAnimationView.frame)/2-25, lableWidth, 25);
        
    }
    
    if (self.labelArray.count==1) {
        
//        self.countLabel.hidden=YES;
        
        UILabel *lab=self.labelArray[0];
        
        if ([lab.text isEqualToString:@"请先检测"]) {
            
            self.countLabel.hidden=YES;
            
        }
        
        lab.hidden=NO;
        
        lab.frame=CGRectMake(labelX,CGRectGetMaxY(self.currentAnimationView.frame)-CGRectGetHeight(self.currentAnimationView.frame)/2-25, lableWidth, 25);
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopWave" object:nil];
    
    [self.delegate stopWave];
    
    UIButton *clickBtn = [[UIButton alloc]initWithFrame:self.currentAnimationView.frame];
    
    clickBtn.backgroundColor=[UIColor clearColor];
    
    [clickBtn addTarget:self action:@selector(ToCheckOut) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:clickBtn];
    
    CGFloat ZC=self.checkmodel.SelfTestScore;
    
    CGFloat ZF=100.0;
    
    CGFloat XW=self.checkmodel.ActionFactorScore;
    
    CGFloat JC=self.checkmodel.DetectionScore;
    
    /**计算各项分值的比例**/
    CGFloat actionScore=XW/ZF;
    
    CGFloat selfCheckScore=ZC/ZF;
    
    CGFloat detectionScore=JC/ZF;
    
    UIBezierPath *path1=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.currentAnimationView.width, self.currentAnimationView.height)];
    
    CAShapeLayer *layer1=[CAShapeLayer layer];
    
    layer1.frame=CGRectMake(0, 0, self.currentAnimationView.width,self.currentAnimationView.height);
    
    layer1.fillColor=[[UIColor clearColor]CGColor];
    
    layer1.strokeColor=[COLOR(221, 213, 27, 1)CGColor];
    
    layer1.lineWidth=12;
    
    layer1.strokeStart=0.0;
    
    layer1.strokeEnd=actionScore;

    layer1.path=path1.CGPath;
    
    [self.currentAnimationView.layer addSublayer:layer1];
    
    UIBezierPath *path2=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.currentAnimationView.width, self.currentAnimationView.height)];
    
    CAShapeLayer *layer2=[CAShapeLayer layer];
    
    layer2.frame=CGRectMake(0, 0, self.currentAnimationView.width,self.currentAnimationView.height);
    
    layer2.fillColor=[[UIColor clearColor]CGColor];
    
    layer2.strokeColor=[COLOR(128, 232, 23, 1)CGColor];
    
    layer2.lineWidth=12;
    
    layer2.strokeStart=actionScore;
    
    layer2.strokeEnd=actionScore+selfCheckScore;
    
    layer2.path=path2.CGPath;
    
    [self.currentAnimationView.layer addSublayer:layer2];
    
    UIBezierPath *path3=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.currentAnimationView.width, self.currentAnimationView.height)];
    
    CAShapeLayer *layer3=[CAShapeLayer layer];
    
    layer3.frame=CGRectMake(0, 0, self.currentAnimationView.width, self.currentAnimationView.height);
    
    layer3.fillColor=[[UIColor clearColor]CGColor];
    
    layer3.strokeColor=[COLOR(42, 249, 238, 1)CGColor];
    
    layer3.lineWidth=12;
    
    layer3.strokeStart=actionScore+selfCheckScore;
    
    layer3.strokeEnd=actionScore+selfCheckScore+detectionScore;
    
    layer3.path=path3.CGPath;
    
    [self.currentAnimationView.layer addSublayer:layer3];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    
    [ud setObject:@(self.currentAnimationView.centerY) forKey:@"centerY"];
    
}

-(void)ToCheckOut{
    
    XKLOG(@"去检测页面");
//    CheckController *check=[[CheckController alloc]init];
//    
//    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:check];
//    
//    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
//    
//    nav.modalPresentationStyle=UIModalPresentationCustom;
//    
//    [[self parentController] presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)clickManager:(id)sender {
    
    XKLOG(@"点击了健康档案");
    ArchiveViewController *archiveVC = [[ArchiveViewController alloc]init];
   
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:archiveVC];
   
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
   
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [[self parentController] presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)clickCheck:(id)sender {
    
    XKLOG(@"点击了健康自测");
    
    CheckController *check=[[CheckController alloc]init];
    
    check.jumpType=0;
    
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:check];
    
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [[self currentViewController] presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)clickAdviser:(id)sender {
    
    XKLOG(@"点击了在线咨询");
     
    AdviserListController *adviser=[[AdviserListController alloc]init];
    adviser.title = @"顾问列表";
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:adviser];
    nav.transitioningDelegate=(id)self.archiveCoverDelegate;
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [[self currentViewController] presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)clickBody:(id)sender {
    
    XKLOG(@"点击了健康养生");
    
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"431" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[UserInfoTool getLoginInfo].MemberID} success:^(id json) {
        
        XKLOG(@"%@",json);
        
      [[XKLoadingView shareLoadingView] hideLoding];
        
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] hasPrefix:@"没有"]) {
            
            ProserveController *proserve=[[ProserveController alloc]init];
            
            CheckListModel *model=[CheckListModel objectWithKeyValues:json[@"Result"]];
            
            proserve.model=model;
            
            proserve.title=@"调理养生";
            
            XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:proserve];
            
            nav.transitioningDelegate=(id)self.archiveCoverDelegate;
            
            nav.modalPresentationStyle=UIModalPresentationCustom;
            
            [[self currentViewController] presentViewController:nav animated:YES completion:nil];
            
        }else{
            
            XKLOG(@"有检测报告结果直接跳到问题分析界面");
            
            SubhealthyController *subhealth=[[SubhealthyController alloc]initWithStyle:UITableViewStyleGrouped];
            
            subhealth.jumpMethod=1;
            
            XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:subhealth];
            
            nav.transitioningDelegate=(id)self.archiveCoverDelegate;
            
            nav.modalPresentationStyle=UIModalPresentationCustom;
            
            [[self currentViewController] presentViewController:nav animated:YES completion:nil];
                        
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        
        [[XKLoadingView shareLoadingView] errorloadingText:error];
        
    }];
    
}

- (IBAction)clickArrow:(id)sender {
    
    XKLOG(@"点击了箭头");
    
    HomeSpreadController *spread=[[HomeSpreadController alloc]initWithStyle:UITableViewStyleGrouped];
    
    spread.checkmodel=self.checkmodel;
    
    XKLOG(@"%@",self.checkmodel.TestTime);
    
    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:spread];
    
    nav.transitioningDelegate=(id)self.deploy;
    
    nav.modalPresentationStyle=UIModalPresentationCustom;
    
    [[self currentViewController] presentViewController:nav animated:YES completion:nil];
    
}

-(void)setIsBackToZore:(BOOL)isBackToZore{
    
    _isBackToZore=isBackToZore;
    
    if (_isBackToZore) {
        
        [self.topScl setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
}

@end
