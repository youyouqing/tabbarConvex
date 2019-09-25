//
//  XKLoadingView.m
//  eHealthCare
//
//  Created by xiekang on 16/9/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XKLoadingView.h"

@interface XKLoadingView()<UIAlertViewDelegate>
{
    BOOL isError;
}
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *loadBackView;
@property (nonatomic, strong) UIImageView *animationImgView;
@property (nonatomic, strong) UILabel *textLal;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (strong, nonatomic) NSDate *lastShowLoginError;
@end

@implementation XKLoadingView
static XKLoadingView *mLoadingView = nil;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        //底部View
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _backView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        [_backView addGestureRecognizer:tap];
        [self addSubview:_backView];
        
        //加载背景试图
        _loadBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
        _loadBackView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
//        _loadBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        _loadBackView.backgroundColor= [UIColor whiteColor];
        _loadBackView.layer.cornerRadius = 10;
        _loadBackView.clipsToBounds = YES;
        [_backView addSubview:_loadBackView];
        
        //加载图片imagview
        _animationImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 95)];
        [_loadBackView addSubview:_animationImgView];
        
        //提示label
        _textLal = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_animationImgView.frame), _loadBackView.frame.size.width, _loadBackView.height - CGRectGetMaxY(_animationImgView.frame))];
        _textLal.textAlignment = NSTextAlignmentCenter;
        _textLal.backgroundColor = [UIColor clearColor];
        _textLal.textColor = [UIColor whiteColor];
        _textLal.adjustsFontSizeToFitWidth = YES;
        _textLal.numberOfLines = 0;
        [_loadBackView addSubview:_textLal];
        
        //加载中图片数组
        _imageArr = [NSMutableArray array];
        for (NSInteger i = 0; i <= 34; i++) {
            NSString *imgName = [NSString stringWithFormat:@"loading_new_%li.png",i];
            UIImage *image = [UIImage imageNamed:imgName];
            [_imageArr addObject:image];
        }

//        for (NSInteger i = 1; i <= 10; i++) {
//            NSString *imgName = [NSString stringWithFormat:@"loading%li.png",(long)i];
//            UIImage *image = [UIImage imageNamed:imgName];
//            [_imageArr addObject:image];
//        }
        
    }
    return self;
}

/**加载中*/
-(void)showLoadingText:(NSString *)text
{
    if (text.length == 0) {
        text = @"";
    }
    
    isError = NO;
    self.backView.alpha = 1.0;
    _loadBackView.backgroundColor = [UIColor clearColor];
    self.animationImgView.image = [UIImage imageNamed:@""];//清空之前报错时img图片
    self.animationImgView.frame = CGRectMake(0, 0, 95, 95);
    self.animationImgView.center = CGPointMake(_loadBackView.width/2, 55);
    self.animationImgView.animationImages = self.imageArr;
    self.animationImgView.animationDuration = 0.1 * 10;
    self.animationImgView.animationRepeatCount = 0;
    [self.animationImgView startAnimating];
    
    self.textLal.text = @"";
    self.textLal.frame = CGRectMake(0, CGRectGetMaxY(_animationImgView.frame), _loadBackView.frame.size.width, _loadBackView.height - CGRectGetMaxY(_animationImgView.frame));
    self.textLal.font = [UIFont boldSystemFontOfSize:12];
    self.textLal.adjustsFontSizeToFitWidth = YES;
    
    //解决加载
    dispatch_after(DISPATCH_TIME_NOW * 1.0, dispatch_get_main_queue(), ^{
        
        if ([UIApplication sharedApplication].keyWindow.rootViewController.navigationController) {
            [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController.view addSubview:self];
        }else{
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        
    });
    
}

/**加载中*/
-(void)errorloadingText:(NSString *)text
{
    if (text.length == 0) {
        text = @"亲，网速不给力哇~";
    }
    isError = YES;
    self.backView.alpha = 1.0;
    
    [self.animationImgView stopAnimating];
    _loadBackView.backgroundColor = [[UIColor colorWithHexString:@"0a1825"] colorWithAlphaComponent:0.55];
//    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]; 11-21之前的背景色
    self.animationImgView.frame = CGRectMake(0, 0, 80, 80);
    self.animationImgView.center = CGPointMake(_loadBackView.width/2, 45);
    self.animationImgView.image = [UIImage imageNamed:@"newloading-fail"];
    
    self.textLal.text = text;
    self.textLal.frame = CGRectMake(8, CGRectGetMaxY(_animationImgView.frame), _loadBackView.frame.size.width - 16, _loadBackView.height - CGRectGetMaxY(_animationImgView.frame));
    self.textLal.font = [UIFont boldSystemFontOfSize:17];
    if (self.textLal.text.length >= 6) {
        self.textLal.font = [UIFont boldSystemFontOfSize:12];
    }else{
        self.textLal.font = [UIFont boldSystemFontOfSize:15];
    }
    
    //解决加载
    dispatch_after(DISPATCH_TIME_NOW * 1.5, dispatch_get_main_queue(), ^{
        
        if ([UIApplication sharedApplication].keyWindow.rootViewController.navigationController) {
            [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController.view addSubview:self];
        }else{
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideLoding];
        });//加载失败完后消失
        
    });
    
}

-(void)close
{
    if (isError) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backView.alpha = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

-(void)hideLoding
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+(XKLoadingView *)shareLoadingView{
    @synchronized(self){
        if (mLoadingView==nil) {
            mLoadingView = [[self alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        }
    }
    return mLoadingView;
}

#pragma mark - 登录异常，返回登录的提示框
-(void)loginError:(NSString *)str
{
    if (str.length == 0) {
        str = @"您的登录状态异常，请重新登录";
    }
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastShowLoginError];
    [self.animationImgView stopAnimating];
    if (timeInterval < 5.0) {
        //如果提示时间过短
        NSLog(@"102异常登录提示时间过短，不提示 %@, %@", [NSDate date], self.lastShowLoginError);
        return;
    }
    //保存最后一次提示登录异常时间
    self.lastShowLoginError = [NSDate date];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"lignout" object:nil];
}

@end
