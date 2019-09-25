//
//  XKBloodFatChooseView.m
//  eHealthCare
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 mac. All rights reserved.
//携康APP3.0版本血脂四项选择视图  创建者：张波

#import "XKBloodFatChooseView.h"
#import "XKBloodFatChooseCell.h"

@interface XKBloodFatChooseView()<UITableViewDelegate,UITableViewDataSource>
/**数据表格*/
@property (weak, nonatomic) IBOutlet UITableView *booldTable;

@end

@implementation XKBloodFatChooseView

/**重写数据源set方法*/
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.booldTable reloadData];
}

/**加载视图xib*/
-(void)awakeFromNib{
    [super awakeFromNib];
    self.booldTable.delegate = self;
    self.booldTable.dataSource = self;
    self.booldTable.showsVerticalScrollIndicator = NO;
    self.booldTable.showsHorizontalScrollIndicator = NO;
    [self.booldTable registerNib:[UINib nibWithNibName:@"XKBloodFatChooseCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

/**表格返回多少个组*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**表格返回多少行*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

/**返回表格cell视图*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XKBloodFatChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

/**表格选中某一行*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didSelectOnce:self.dataArray[indexPath.row]];
}

/**返回表格某一行高度*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

/**打开*/
-(void)openAllView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    }];
}

/**关闭*/
-(void)closeAllView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    }];
}

@end
