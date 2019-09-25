//
//  FriendTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/11/14.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "FriendTableViewCell.h"
@interface FriendTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *disagreebtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation FriendTableViewCell

- (void)awakeFromNib {
     self.disagreebtn.layer.cornerRadius= self.agreeBtn.layer.cornerRadius=self.agreeBtn.frame.size.height/2;
     self.disagreebtn.layer.masksToBounds = self.agreeBtn.layer.masksToBounds=YES;
     self.disagreebtn.layer.borderColor = kMainColor.CGColor;
     self.disagreebtn.layer.borderWidth = 1.f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFobject:(FamilyMemberObject *)Fobject
{
    _Fobject = Fobject;
    self.titleLab.text = [NSString stringWithFormat:@"您的家人%@申请添加您的健康档案是否同意",Fobject.FamilyName];
    //是否通过 0、添加待回复 1、通过添加 2、未通过添加
    if (Fobject.PassStatus == 0) {
        self.bottomView.hidden = NO;
    }else if (Fobject.PassStatus == 1) {
         self.bottomView.hidden = YES;
        [self.recordBtn setTitle:@"您已同意" forState:UIControlStateNormal];
    }
    else if (Fobject.PassStatus == 2)
    {
         self.bottomView.hidden = YES;
         [self.recordBtn setTitle:@"您未同意" forState:UIControlStateNormal];
    }
    
}
- (IBAction)agreeAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(agreeAddFamilybuttonClick:pass:)]) {
        [self.delegate agreeAddFamilybuttonClick:self.Fobject pass:(btn.tag==11)?1:2];
    }
    
}
@end
