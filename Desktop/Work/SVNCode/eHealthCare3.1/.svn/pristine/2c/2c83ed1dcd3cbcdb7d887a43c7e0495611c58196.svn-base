//
//  HealthRecordHeaderView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/11.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthRecordHeaderView.h"

@implementation HealthRecordHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kbackGroundGrayColor;
    self.lineLab.backgroundColor = [UIColor getColor:@"EBF0F4"];
    
    
    self.editBtn.layer.masksToBounds=YES;
    self.editBtn.layer.borderWidth = 0.5;
    self.editBtn.layer.borderColor = [UIColor getColor:@"03C7FF"].CGColor;
    self.editBtn.layer.cornerRadius=self.editBtn.frame.size.height/2.0;
    
}
- (IBAction)editAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthRecordHeaderViewButtonClick:)]) {
        [self.delegate HealthRecordHeaderViewButtonClick:self.titleLab.text];
    }
    
}
-(void)setMoodID:(int)MoodID
{
    _MoodID = MoodID;
    
    NSLog(@"取用户心情%i",MoodID);
    if (MoodID == 1) {//心情编号 1、酷 2、良好 3、没特别 4、差劲 5、糟透
        [_editBtn setImage:[UIImage imageNamed:@"mood_cool"] forState:UIControlStateNormal];
        [_editBtn setTitle:@" 酷" forState:UIControlStateNormal];
    }else if (MoodID == 2)
    {
        [_editBtn setImage:[UIImage imageNamed:@"mood_fine"] forState:UIControlStateNormal];
        [_editBtn setTitle:@" 良好" forState:UIControlStateNormal];
    }
    else if (MoodID == 3)
    {
        [_editBtn setImage:[UIImage imageNamed:@"mood_normal"] forState:UIControlStateNormal];
        [_editBtn setTitle:@" 没特别" forState:UIControlStateNormal];
    }
    else if (MoodID == 4)
    {
        [_editBtn setImage:[UIImage imageNamed:@"mood_bad"] forState:UIControlStateNormal];
        [_editBtn setTitle:@" 差劲" forState:UIControlStateNormal];
    }
    else if (MoodID == 5)
    {
        [_editBtn setImage:[UIImage imageNamed:@"mood_terrible"] forState:UIControlStateNormal];
        [_editBtn setTitle:@" 糟透" forState:UIControlStateNormal];
    }else
         [_editBtn setTitle:@" " forState:UIControlStateNormal];
}
@end
