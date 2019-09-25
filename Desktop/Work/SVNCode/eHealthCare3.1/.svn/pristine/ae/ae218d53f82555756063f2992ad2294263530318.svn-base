//
//  AdvertisingScrolllView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/9.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AdvertisingScrolllView.h"

@interface AdvertisingScrolllView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AdvertisingScrolllView

#define ADWidth self.size.width
#define ADHeight self.size.height

- (instancetype)initWithSize:(CGSize)size iamgeArray:(NSArray *)imageArray
{
    self = [super init];
    self.imageArray = imageArray;
    self.size = size;
    if (self) {
        [self createUI];
    }
    
    return self;
}

#pragma mark UI
- (void)createUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ADWidth * (self.imageArray.count + 2), 0);
    [self addSubview:scrollView];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(0);
        
    }];
    
    for (int i = 0; i < self.imageArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.top.left.bottom.right.mas_equalTo(0);
            
        }];
        
        if ([self.imageArray[i] isKindOfClass:[NSString class]])
        {
            NSString *string = [self.imageArray objectAtIndex:i];
            
            if ([string containsString:@"http"])
            {
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"MusicTrain_placeHolderImage"]];
                
            }else
            {
                imageView.image = [UIImage imageNamed:string];
            }
            
        }else if ([self.imageArray[i] isKindOfClass:[UIImage class]])
        {
            imageView.image = self.imageArray[i];
        }
    }
    
    [self setFirstImageAndLastImage];
    [self addPageControl];
    [self addTimer];
    
}


#pragma mark Private 

- (void)addPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.numberOfPages = self.imageArray.count;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo( - KHeight(16));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ADWidth, KHeight(6)));
        
    }];
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage
{
    NSInteger index = self.pageControl.currentPage;
    
    if (index == self.imageArray.count + 1)
    {
        index = 0;
        
    } else
    {
        index++;
    }
    
    [self.scrollView setContentOffset:CGPointMake((index + 1) * ADWidth, 0)animated:YES];
}

- (void)setFirstImageAndLastImage
{
    UIImageView *firstImage = [[UIImageView alloc] init];
    
    firstImage.frame = CGRectMake(0, 0, ADWidth, ADHeight);
    firstImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.scrollView addSubview:firstImage];
    
    UIImageView *lastImage = [[UIImageView alloc] init];
    
    lastImage.contentMode = UIViewContentModeScaleAspectFit;
    lastImage.frame = CGRectMake((self.imageArray.count + 1) * ADWidth, 0, ADWidth, ADHeight);
    
    [self.scrollView addSubview:lastImage];
    
    self.scrollView.contentOffset = CGPointMake(ADWidth, 0);
    
    if ([[self.imageArray firstObject] isKindOfClass:[NSString class]])
    {
        NSString *string = [self.imageArray firstObject];
        
        if ([string containsString:@"http"])
        {
            [lastImage sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"MusicTrain_placeHolderImage"]];
            
        }else
        {
            lastImage.image = [UIImage imageNamed:string];
        }
        
    }else if ([[self.imageArray firstObject] isKindOfClass:[UIImage class]])
    {
        lastImage.image = [self.imageArray firstObject];
    }
    
    if ([[self.imageArray lastObject] isKindOfClass:[NSString class]])
    {
        NSString *string = [self.imageArray lastObject];
        
        if ([string containsString:@"http"])
        {
            [firstImage sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"MusicTrain_placeHolderImage"]];
            
        }else
        {
            firstImage.image = [UIImage imageNamed:string];
        }
        
    }else if ([[self.imageArray lastObject] isKindOfClass:[UIImage class]])
    {
        firstImage.image = [self.imageArray lastObject];
    }
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (self.scrollView.contentOffset.x + ADWidth * 0.5) / ADWidth;
    
    if (index == self.imageArray.count + 2)
    {
        index = 1;
        
    } else if(index == 0)
    {
        index = self.imageArray.count;
    }
    self.pageControl.currentPage = index - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = (self.scrollView.contentOffset.x + ADWidth * 0.5) / ADWidth;
    
    if (index == self.imageArray.count + 1)
    {
        [self.scrollView setContentOffset:CGPointMake(ADWidth, 0) animated:NO];
        
    } else if (index == 0)
    {
        [self.scrollView setContentOffset:CGPointMake(self.imageArray.count * ADWidth, 0) animated:NO];
    }
}
@end
