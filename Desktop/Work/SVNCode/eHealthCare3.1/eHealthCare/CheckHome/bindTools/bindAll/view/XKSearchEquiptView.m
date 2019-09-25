//
//  XKSearchEquiptView.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKSearchEquiptView.h"
#import "XKEquiptBindTableViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface XKSearchEquiptView ()
{

    NSString *nameEquipt;//绑定的名字
}
@property (weak, nonatomic) IBOutlet UIView *loadGifView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (weak, nonatomic) IBOutlet UIView *backView;


/**
 设备扫描中
 */
@property (weak, nonatomic) IBOutlet UILabel *equiptScanLab;

@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;


/**
 绑定设备成功失败
 */
@property (weak, nonatomic) IBOutlet UIImageView *bindResultImage;

@end//

@implementation XKSearchEquiptView
#pragma mark  初始化数据
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    nameEquipt = [[NSString alloc]init];
    
    self.bindBtn.layer.cornerRadius = self.bindBtn.frame.size.height/2.0;
    
    
    self.bindBtn.clipsToBounds = YES;
    
    self.backView.layer.cornerRadius = 10/2.0;
    
    
    self.backView.clipsToBounds = YES;

    self.equiptTabView.dataSource = self;
    
    self.equiptTabView.delegate = self;
    
    
    [self.equiptTabView registerNib:[UINib nibWithNibName:@"XKEquiptBindTableViewCell" bundle:nil] forCellReuseIdentifier:@"XKEquiptBindTableViewCell"];
    if (IS_IPHONE4S) {
        self.backViewHeight.constant = 305;
    }else     if (IS_IPHONE5) {
        self.backViewHeight.constant = 305;
    }
    else
         self.backViewHeight.constant = 325;
    
   
     self.equiptTabView.hidden = YES;
    
    
    
    
    [self updateCondition];


}
-(void)setStyle:(XKLoadViewStyle)style
{

    _style = style;
    
    [self updateCondition];

}
#pragma mark 绑定状态变化
-(void)updateCondition{
     [displayImageView removeFromSuperview];
     [self.bindBtn setBackgroundColor:[UIColor whiteColor]];
    if (self.style  == XKLoadCalcelStyle){
        [displayImageView removeFromSuperview];
        self.nameLab.hidden = NO;
        self.bindResultImage.hidden = NO;
        self.bindResultImage.image = [UIImage imageNamed:@"bound_fail"];
         self.equiptScanLab.hidden = YES;
        self.nameLab.text = @"绑定失败";
        self.equiptScanLab.textColor = [UIColor lightGrayColor];
        self.bindBtn.hidden = YES;
         
    }
    else if (self.style  == XKLoadSuccessStyle){
        
        
         [displayImageView removeFromSuperview];
        self.bindResultImage.image = [UIImage imageNamed:@"bound_complete"];
        self.nameLab.hidden = NO;
        self.nameLab.text = [NSString stringWithFormat:@"设备：%@",nameEquipt];
         self.bindResultImage.hidden = NO;
        self.equiptScanLab.text = @"绑定成功";
        self.nameLab.textColor =[UIColor lightGrayColor];;
        self.bindBtn.hidden = YES;
         self.equiptScanLab.hidden = NO;
        
    }
    else if (self.style  == XKLoadLoadingStyle){
        
         self.bindResultImage.hidden = YES;
        [self loadCADisplayLineImageView:@"bindEquiptAnimation.gif"];
        self.nameLab.hidden = NO;
        self.equiptScanLab.text = @"设备绑定中";
        self.nameLab.textColor = kMainColor;
        self.bindBtn.hidden = YES;
         self.nameLab.text = @"";
        self.equiptScanLab.hidden = NO;
      
    }
    
    else if (self.style  == XKLoadunLoadingStyle){
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
          [displayImageView removeFromSuperview];
    }
    
    else if (self.style  == XKLoadSearchingStyle){
        self.nameLab.hidden = YES;
        self.equiptScanLab.text = @"设备搜索中";
         self.nameLab.text = @"";
        self.nameLab.textColor = kMainColor;
        self.bindBtn.hidden = YES;
        self.equiptScanLab.hidden = NO;
       self.bindResultImage.hidden = YES;
        [self loadCADisplayLineImageView:@"searchEquipt.gif"];
    }
    
    else if (self.style  == XKLoadDetectiStyle){
         self.bindResultImage.hidden = YES;
          [displayImageView removeFromSuperview];
          self.equiptScanLab.hidden = YES;
          self.bindBtn.hidden = YES;
          self.nameLab.hidden = NO;
          self.equiptScanLab.textColor = [UIColor lightGrayColor];
          self.nameLab.text = @"检测到设备，请选择绑定";
          self.equiptTabView.hidden = NO;
        
    }
    [self.equiptTabView reloadData];
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     if (self.style  == XKLoadDetectiStyle)
         return 1;

    else
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    return 48;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.style  == XKLoadDetectiStyle)
        return self.dataBigArray.count;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        XKEquiptBindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKEquiptBindTableViewCell" forIndexPath:indexPath];
    
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
        CBPeripheral *model = self.dataBigArray[indexPath.row];
        if ([self.dataBigArray[indexPath.row] isKindOfClass:[CBPeripheral class]]) {
            cell.equiptNameLab.text =model.name;
        }
        else  if ([self.dataBigArray[indexPath.row] isKindOfClass:[NSString class]])
            cell.equiptNameLab.text = self.dataBigArray[indexPath.row];
    
        return cell;
        

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    if ([self.delegate respondsToSelector:@selector(selectIndex:)]) {
        
        
        CBPeripheral *model=self.dataBigArray[indexPath.row];
        if ([self.dataBigArray[indexPath.row] isKindOfClass:[CBPeripheral class]]) {
            nameEquipt = model.name;
        }
        else  if ([self.dataBigArray[indexPath.row] isKindOfClass:[NSString class]])
        nameEquipt = self.dataBigArray[indexPath.row];
        [self.delegate selectIndex:self];
        
    }
    


}
- (IBAction)reAgainBeginDect:(id)sender {
    
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(beginAgainToDectTool)]) {
        [self.delegate beginAgainToDectTool];
    }
    
}

- (IBAction)cancelAction:(id)sender {
    
    [self removeFromSuperview];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark   加载GIF图
-(void)loadCADisplayLineImageView:(NSString *)imageName
{
    displayImageView = [[CADisplayLineImageView alloc] initWithFrame:CGRectMake(0, 0, 156,156)];
    [displayImageView setCenter:CGPointMake(self.loadGifView.center.x, self.loadGifView.center.y-78)];
    [self.loadGifView addSubview:displayImageView];
    [displayImageView setImage:[CADisplayLineImage imageNamed:imageName]];
    
}
@end
