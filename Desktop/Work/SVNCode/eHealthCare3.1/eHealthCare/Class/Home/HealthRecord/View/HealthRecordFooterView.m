//
//  HealthRecordFooterView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordFooterView.h"
#import "HealthReportCell.h"
#import "HealthPlanReportCell.h"
@interface HealthRecordFooterView ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation HealthRecordFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
  
    self.tableView.estimatedRowHeight = 110;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"HealthReportCell" bundle:nil] forCellReuseIdentifier:@"HealthReportCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"HealthPlanReportCell" bundle:nil] forCellReuseIdentifier:@"HealthPlanReportCell"];
}
#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.basicArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.planOrArchive == YES) {
        NSString *cellid = @"HealthPlanReportCell";
        HealthPlanReportCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userMemberID = self.userMemberID;
        cell.PlanListMod = self.basicArr[indexPath.row];
         cell.delegate = self;
        return cell;
    }else{
        
        NSString *cellid = @"HealthReportCell";
        HealthReportCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ItemListMod = self.basicArr[indexPath.row];
        cell.delegate = self;
        return cell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (45);
}
- (void)HealthReportCellbuttonClick:(ItemListModel *)ItemListMod;
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthRecordFooterViewButtonClick:remind:)]) {
        [self.delegate HealthRecordFooterViewButtonClick:nil remind:NO];
    }
    
}

- (void)HealthPlanReportCellbuttonClick:(TopRecordModel *)tMod remind:(BOOL)remind;
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthRecordFooterViewButtonClick:remind:)]) {
        [self.delegate HealthRecordFooterViewButtonClick:tMod remind:remind];
    }
    
}
@end
