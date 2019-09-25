//
//  XKSearchToolView.m
//  eHealthCare
//
//  Created by xiekang on 2017/11/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSearchToolView.h"

@implementation XKSearchToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    self.bindBtn.layer.cornerRadius = self.bindBtn.frame.size.height/2.0;
    
    
    self.bindBtn.clipsToBounds = YES;

    
    self.backView.layer.cornerRadius = 10/2.0;
    
    
    self.backView.clipsToBounds = YES;
    
    self.style = 5;
    
    [self updateCondition];
    

    
}
-(void)setStyle:(NSInteger)style
{
    
    _style = style;
    
    [self updateCondition];
    
}
-(void)updateCondition{
   
    if (self.style  == 1){
        self.displayImageView.hidden = YES;
       // [displayImageView removeFromSuperview];
        self.bindResultImage.hidden = NO;
        self.bindResultImage.image = [UIImage imageNamed:@"no_device"];
        self.nameLab.hidden = NO;
        self.bindBtn.hidden = NO;
        
        self.equiptScanLab.hidden = NO;
        
        self.nameLab.text = @"";
        self.equiptScanLab.text = @"未检测到设备";
        [self.bindBtn setBackgroundColor:kMainColor];
        [self.bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [self.bindBtn setTitle:@"重新检测" forState:UIControlStateNormal];
       
    }
    else if (self.style == 2)
    {
    
       // [displayImageView removeFromSuperview];
        self.nameLab.hidden = YES;
        self.equiptScanLab.text = @"设备搜索中";
        self.displayImageView.hidden = NO;
        self.nameLab.textColor = kMainColor;
        self.bindBtn.hidden = YES;
        self.equiptScanLab.hidden = NO;
        self.bindResultImage.hidden = YES;
        [self loadCADisplayLineImageView:@"searchEquipt.gif"];
    }
    
    else if (self.style  == 3){
         self.displayImageView.hidden = YES;
      //  [displayImageView removeFromSuperview];
        self.nameLab.hidden = NO;
        self.bindResultImage.hidden = NO;
        self.bindResultImage.image = [UIImage imageNamed:@"bound_fail"];
        self.equiptScanLab.hidden = NO;
        self.nameLab.text = @"连接失败";
        self.equiptScanLab.text = @"连接失败";
        self.equiptScanLab.textColor = [UIColor lightGrayColor];
        self.bindBtn.hidden = YES;
        
    }
    else if (self.style  == 4){
        
         self.displayImageView.hidden = YES;
      //  [displayImageView removeFromSuperview];
        self.bindResultImage.image = [UIImage imageNamed:@"bound_complete"];
        self.nameLab.hidden = NO;
        self.bindResultImage.hidden = NO;
        self.equiptScanLab.text = @"连接成功";
        self.nameLab.textColor =[UIColor lightGrayColor];;
        self.bindBtn.hidden = YES;
        self.equiptScanLab.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
        
    }
    else if (self.style  == 5){
         self.displayImageView.hidden = NO;
        self.bindResultImage.hidden = YES;
        [self loadCADisplayLineImageView:@"bindEquiptAnimation.gif"];
        self.nameLab.hidden = NO;
        self.equiptScanLab.text = @"正在连接中";
        self.nameLab.textColor = kMainColor;
        self.bindBtn.hidden = YES;
        self.nameLab.text = @"";
        self.equiptScanLab.hidden = NO;
        
    }
    
   
  
}
- (IBAction)reAgainBeginDect:(id)sender {
    
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(beginAgainToSearchDectTool)]) {
        [self.delegate beginAgainToSearchDectTool];
    }
    
}
- (IBAction)cancelAction:(id)sender {
    
    [self removeFromSuperview];
    
}

-(void)loadCADisplayLineImageView:(NSString *)imageName
{
//    displayImageView = [[CADisplayLineImageView alloc] initWithFrame:CGRectMake((self.loadGifView.frame.size.width-156)/2.0, (self.loadGifView.frame.size.height-156)/2.0, 156,156)];
  //  [displayImageView setCenter:CGPointMake(self.loadGifView.center.x, self.loadGifView.center.y-58)];
    
    [self.displayImageView setImage:[CADisplayLineImage imageNamed:imageName]];
//    [self.loadGifView addSubview:displayImageView];
    
}
@end
