//
//  XKSportRunHeaderView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/22.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "XKSportRunHeaderView.h"
@interface XKSportRunHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *dataBtn;


@property (weak, nonatomic) IBOutlet UIButton *replaceDestina;

@property (weak, nonatomic) IBOutlet UILabel *destinaLab;

@end
@implementation XKSportRunHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)startAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sportRunHeaderViewbuttonClick)]) {
        [self.delegate sportRunHeaderViewbuttonClick];
    }
    
}
- (IBAction)replaceAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sportReplaceDestinaHeaderViewbuttonClick)]) {
        [self.delegate sportReplaceDestinaHeaderViewbuttonClick];
    }
    
}
-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    self.replaceDestina.layer.borderColor = kMainColor.CGColor;
    self.replaceDestina.layer.borderWidth = 1.f;
    self.replaceDestina.clipsToBounds = YES;
    self.replaceDestina.layer.cornerRadius = self.replaceDestina.size.height/2.0;
    
}
-(void)setDestinaMod:(SportDestinaMod *)destinaMod
{
    _destinaMod = destinaMod;
    [self.dataBtn setTitle:destinaMod.destinaDataStr forState:UIControlStateNormal];
    self.destinaLab.text = [NSString stringWithFormat:@"目标(%@)",destinaMod.title];
}
@end