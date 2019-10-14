//
//  HealthReportCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthReportCell.h"
@interface HealthReportCell ()
@property (weak, nonatomic) IBOutlet UIButton *sportsBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *proessLab;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation HealthReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = kbackGroundGrayColor;
     self.backView.backgroundColor = [UIColor getColor:@"EEFBFE"];
     self.backView.layer.cornerRadius=3;
    self.backView.layer.masksToBounds=YES;
    
    self.sportsBtn.layer.masksToBounds=YES;
    self.sportsBtn.layer.borderWidth = 0.5;
    self.sportsBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    self.sportsBtn.layer.cornerRadius=self.sportsBtn.frame.size.height/2.0;
    
    self.titleLab.textColor = kMainTitleColor;
    self.proessLab.textColor = [UIColor getColor:@"B3BBC4"];
}
- (IBAction)goPlanAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthReportCellbuttonClick:)]) {
        [self.delegate HealthReportCellbuttonClick:self.ItemListMod];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItemListMod:(ItemListModel *)ItemListMod
{
    _ItemListMod = ItemListMod;
    self.backView.backgroundColor = [UIColor getColor:@"FCF5F5"];
    self.titleLab.text = ItemListMod.PhysicalItemName;
    self.proessLab.text = [NSString stringWithFormat:@"%@%@",ItemListMod.TypeParameter,ItemListMod.PhysicalItemUnits];
    [self.sportsBtn setTitle:ItemListMod.ExceptionContent forState:UIControlStateNormal];
    [self.sportsBtn setTitleColor:[UIColor getColor:@"F67475"] forState:UIControlStateNormal];
    
    
     self.sportsBtn.layer.borderColor = [UIColor clearColor].CGColor;
}
@end