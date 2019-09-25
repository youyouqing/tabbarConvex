//
//  XKMusicListView.m
//  eHealthCare
//
//  Created by xiekang on 2018/3/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XKMusicListView.h"
#import "XKMusicListTableViewCell.h"
#import "MusicTrainModel.h"
@interface XKMusicListView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bottom_bg_View;


/**
 列表
 */

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UITableView *tabV;

@end
@implementation XKMusicListView
-(void)awakeFromNib{
    
    [super awakeFromNib];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.listView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight| UIRectEdgeLeft |UIRectEdgeRight  cornerRadii:CGSizeMake(3, 3)];
    NSLog(@"self.listView.bounds%@",NSStringFromCGRect(self.listView.bounds));//{{0, 0}, {457, 335}}
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
   
    maskLayer.frame = self.listView.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.listView.layer.mask = maskLayer;
    self.listView.clipsToBounds = YES;
    self.listView.layer.cornerRadius = 3.f;
    self.listView.y = KScreenHeight;
    self.tabV.estimatedRowHeight = 90;
    
    self.tabV.rowHeight = UITableViewAutomaticDimension;
    
    [self.tabV registerNib:[UINib nibWithNibName:@"XKMusicListTableViewCell" bundle:nil] forCellReuseIdentifier:@"XKMusicListTableViewCell"];
    
    self.tabV.dataSource = self;
    
    self.tabV.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomAndTouchRemove)];
    [self.bottom_bg_View  addGestureRecognizer:tap];
    [self layoutIfNeeded];

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//     self.listViewHeight.constant = (44*(KScreenWidth-12)/181.0+6.0)*self.imageNameArr.count;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        XKMusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XKMusicListTableViewCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"XKMusicListTableViewCell" owner:nil options:nil].firstObject;

        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        MusicTrainModel *model = self.imageNameArr[indexPath.row];
        [cell.firstBtn setBackgroundImage:[UIImage imageNamed:model.TitleImgUrl] forState:UIControlStateNormal];
        [cell.firstBtn setBackgroundImage:[UIImage imageNamed:model.TitleImgUrl] forState:UIControlStateSelected];
//      [cell.firstBtn sd_setImageWithURL:[NSURL URLWithString:model.TitleImgUrl] placeholderImage:[UIImage imageNamed:@"iv_plus_list_mxsk"]];- (void)sd_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;
        [cell.firstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.TitleImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"iv_plus_list_defaut"]];
        cell.plus_list_choose_img.hidden = [self.selectedBoolArr[indexPath.row] boolValue];
        [cell layoutIfNeeded];
        return cell;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return (44*(KScreenWidth-12)/181.0+6.0);

}

-(void)listPrepare:(XKMusicListTableViewCell *)cell;//准备好了方法
{
    [self removeAnimate];
    NSIndexPath *indexPath = [self.tabV indexPathForCell:cell];
    for (int i = 0; i<self.selectedBoolArr.count; i++) {
          [self.selectedBoolArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(prepare:)]) {
        [self.delegate prepare:indexPath.row];
    }
    [self.selectedBoolArr replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    [self.tabV reloadData];
}

-(void)bottomAndTouchRemove
{
    
    if ([self.delegate respondsToSelector:@selector(bottomTouchRemove)]) {
        [self.delegate bottomTouchRemove];
    }
    [self removeAnimate];
}


-(void)removeAnimate
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.listView.y = KScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
