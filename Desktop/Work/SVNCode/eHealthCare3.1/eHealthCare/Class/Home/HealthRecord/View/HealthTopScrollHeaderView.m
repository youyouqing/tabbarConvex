//
//  HealthTopScrollHeaderView.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthTopScrollHeaderView.h"
#import "FamilyObject.h"
@interface HealthTopScrollHeaderView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;
@property (nonatomic, strong)NSMutableArray *addBtnArr;
@end

@implementation HealthTopScrollHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
//    _scrollView.pagingEnabled = YES;
    self.widthCons.constant = self.heightCons.constant = KWidth(60);
}

-(void)setFamilyArr:(NSArray *)familyArr
{
    _familyArr = familyArr;
    _scrollView.contentSize = CGSizeMake((KWidth(60)+KWidth(22.5) )* familyArr.count+KWidth(22.5), KHeight(180)-(PublicY));//KWidth(105)
    _addBtnArr  = [NSMutableArray arrayWithCapacity:0];
    [_scrollView removeAllSubviews];//刷新时先清除数据再创建
    for (int i = 0; i < familyArr.count; i++)
    {
        FamilyObject *family = familyArr[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor getColor:@"8FE5FF"]];
        button.titleLabel.font = Kfont(20);
        NSString *famTemp = family.FamilyName;
        if (family.HeadImg.length>0) {
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:family.HeadImg] forState:UIControlStateNormal];
        }else
             [button setTitle:[famTemp firstChar] forState:UIControlStateNormal];
        
//        [button sd_setImageWithURL:[NSURL URLWithString:family.HeadImg] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor]   forState:UIControlStateNormal];
         [button setTitleColor:[UIColor whiteColor]  forState:UIControlStateSelected];//[UIColor getColor:@"8FE5FF"]
        
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(replaceOtherRelation:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = KWidth(60)/2.0;
        button.frame = CGRectMake((KWidth(60)+KWidth(22.5)) * i+KWidth(22.5), ( KHeight(180)-(PublicY)-KWidth(60))/2.0, KWidth(60), KWidth(60));
        [_scrollView addSubview:button];
        button.tag = family.FamilyMemberID;
        
        if (family.FamilyMemberID == self.userMemberID) {
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 2.f;
        }
        
        UILabel *contentLab = [[UILabel alloc]init];
        contentLab.text = family.FamilyName;
        contentLab.textColor = [UIColor whiteColor];
        contentLab.font = Kfont(14);
        contentLab.textAlignment = NSTextAlignmentCenter;
        contentLab.frame = CGRectMake((KWidth(60)+KWidth(22.5)) * i+KWidth(22.5), ( KHeight(180)-(PublicY)-KWidth(60))/2.0+CGRectGetHeight(button.frame)  ,CGRectGetWidth(button.frame),   KHeight(180)-(PublicY)-((( KHeight(180)-(PublicY)-KWidth(60))/2.0)+CGRectGetHeight(button.frame)));
        [_scrollView addSubview:contentLab];
        if (family.FamilyMemberID == [UserInfoTool getLoginInfo].MemberID) {
            contentLab.text = @"我";
            if (family.HeadImg.length>0) {
                [button sd_setBackgroundImageWithURL:[NSURL URLWithString:family.HeadImg] forState:UIControlStateNormal];
            }else
               [button setTitle:[[UserInfoTool getLoginInfo].Name firstChar] forState:UIControlStateNormal];
//            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[UserInfoTool getLoginInfo].HeadImg] forState:UIControlStateNormal];
        }
        [_addBtnArr addObject:button];
    }
    
}
- (IBAction)addFamilyAction:(id)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addFamilyTools)]) {
        [self.delegate addFamilyTools];
    }
}
-(void)replaceOtherRelation:(UIButton *)sender{
    for (int i = 0; i<_addBtnArr.count; i++) {
        UIButton *btn = _addBtnArr[i];
        btn.layer.borderWidth = 0.f;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor getColor:@"8FE5FF"]];
    }
    UIButton *btnOne = (UIButton *)sender;
    btnOne.selected = !btnOne.selected;
    btnOne.layer.borderWidth = 2.f;
    btnOne.layer.borderColor = [UIColor whiteColor].CGColor;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(replaceRelationData:)]) {
        [self.delegate replaceRelationData:btnOne.tag];
    }
//    NSLog(@"offsetX---%@",[btnOne superview].center);
//    CGFloat offsetX=btnOne.center.x-(KScreenWidth-90)/2;
//    if (offsetX<0) {
//       offsetX=0;
//       }
//     //2.计算出右边的item距离屏幕最远的距离  以免设置scrollview的偏移量时  便宜的太远
//     CGFloat maxRight=_scrollView.contentSize.width-(KScreenWidth-90);
//    if (offsetX>maxRight) {
//        offsetX=maxRight;
//    }
//    NSLog(@"-offsetX---%f",offsetX);
//     [_scrollView setContentOffset:CGPointMake(offsetX, 0)];

//    if (_addBtnArr.count>1&&btnOne.frame.origin.x>(KScreenWidth-90-KWidth(25))) {
//        UIButton *addBtn =  _addBtnArr[_addBtnArr.count-1];
//        if ([addBtn isEqual:sender]) {
//            [_scrollView setContentOffset:CGPointMake(btnOne.width, 0)];
//        }
//    }
//    float offset = btnOne.frame.origin.x+KWidth(22.5);
//    offset = (offset)/(KWidth(60)+KWidth(22.5));//(KWidth(60)+KWidth(22.5)) * index+KWidth(22.5)
//    [self changeScrollOfSet:(offset)];
    
 
}



@end
