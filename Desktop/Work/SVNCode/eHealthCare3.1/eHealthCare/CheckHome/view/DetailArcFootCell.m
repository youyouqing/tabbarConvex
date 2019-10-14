//
//  DetailArcFootCell.m
//  eHealthCare
//
//  Created by xiekang on 16/12/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailArcFootCell.h"
#import "XKHealthyCheck.h"
#import "XKPhysicaltherapy.h"

@implementation DetailArcFootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)clickCheck:(UIButton *)sender {
    XKHealthyCheck *check=[[XKHealthyCheck alloc]init];
    
    [[self parentController].navigationController pushViewController:check animated:YES];
}
- (IBAction)clickPhys:(UIButton *)sender {
    XKPhysicaltherapy *physical=[[XKPhysicaltherapy alloc]init];
    
    [[self parentController].navigationController pushViewController:physical animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end