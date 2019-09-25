//
//  MusicTrainChoseTopicView.m
//  eHealthCare
//
//  Created by John shi on 2018/7/23.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MusicTrainChoseTopicView.h"

#import "MusicTrainListCell.h"

#import "MusicTrainModel.h"

@interface MusicTrainChoseTopicView () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation MusicTrainChoseTopicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

#pragma mark UI
- (void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.mas_equalTo(0);
        
    }];
}

#pragma mark tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"musicTrainListCell";
    MusicTrainListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (!cell) {
        
        cell = [[MusicTrainListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    cell.dataDic = self.listArray[indexPath.row];
    
    return cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KHeight(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseTopic:)]) {
        
        [self.delegate choseTopic:indexPath.row];
    }
}

#pragma mark Setter
- (void)setListArray:(NSArray *)listArray
{
    _listArray = listArray;
}

@end
