//
//  PlanDirectoryView.m
//  eHealthCare
//
//  Created by John shi on 2018/8/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "PlanDirectoryView.h"
#import "PlanDirectoryCell.h"

@interface PlanDirectoryView () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PlanDirectoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(1);
    }];
    
    //最左边的分割线
    UIView *lineView = [[UIView alloc]init];
    
    lineView.backgroundColor = kSeperateLineColor;
    
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
}

#pragma mark Action

- (void)dismissPlanDirectoryView
{
    self.hidden = YES;
}

#pragma mark tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"PlanDirectoryCell";
    PlanDirectoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        
        cell = [[PlanDirectoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    cell.dataDic = self.dataArray[indexPath.row];

    return cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KHeight(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissPlanDirectoryView];
    if (self.choseBlock) {
        self.choseBlock([self.dataArray objectAtIndex:indexPath.row][@"PlanDetailID"]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Setter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [_tableView reloadData];
}

@end
