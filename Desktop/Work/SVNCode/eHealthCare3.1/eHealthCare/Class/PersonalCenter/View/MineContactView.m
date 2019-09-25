//
//  MineContactView.m
//  eHealthCare
//
//  Created by xiekang on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MineContactView.h"
#import "MineContactCell.h"
@interface MineContactView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imgArr;
}
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end
@implementation MineContactView

-(void)awakeFromNib
{
    [super awakeFromNib];
    imgArr = [[NSArray alloc] init];
    
    self.mytable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.backgroundColor = [UIColor clearColor];
    self.backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)setDic:(NSDictionary *)dic
{
    if ([NSString stringWithFormat:@"%@",dic[@"FourPhone"]].length == 0) {
        imgArr = @[@{@"img":@"call",@"title":@"电话咨询",@"text":@""},@{@"img":@"mail",@"title":@"邮件发送",@"text":@""}];//@{@"img":@"lxkf",@"title":@"在线客服",@"text":@""},
    }else{
        imgArr = @[@{@"img":@"call",@"title":@"电话咨询",@"text":dic[@"FourPhone"]},@{@"img":@"mail",@"title":@"邮件发送",@"text":dic[@"Email"]}];//@{@"img":@"lxkf",@"title":@"在线客服",@"text":@""},
    }
   
    [self.mytable reloadData];
}

- (IBAction)closeBtn:(id)sender {
    
    [self HideView];
}

-(void)HideView
{
    [self endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgArr.count-1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellid = @"MineContactCell";
    MineContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineContactCell" owner:self options:nil] lastObject];
    }
    cell.iconImgView.image = [UIImage imageNamed:imgArr[indexPath.row][@"img"]];
    cell.titleLal.text =imgArr[indexPath.row][@"title"];
    cell.textLal.text =imgArr[indexPath.row][@"text"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 1) {
        if (((NSString *)imgArr[indexPath.row][@"text"]).length == 0) {
            return;
        }
        //打电话
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",imgArr[indexPath.row][@"text"]];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
    }else if(indexPath.row == 2) {
        if (((NSString *)imgArr[indexPath.row][@"text"]).length == 0) {
            return;
        }
        //发邮件
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@", imgArr[indexPath.row][@"text"]]];
        [[UIApplication sharedApplication] openURL:url];
    }else{
        
        [self HideView];
        //发送通知--跳转
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center postNotificationName:@"chatToMine" object:nil];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//注销通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
