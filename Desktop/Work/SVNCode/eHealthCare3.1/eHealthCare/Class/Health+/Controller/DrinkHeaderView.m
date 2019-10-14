//
//  DrinkHeaderView.m
//  eHealthCare
//
//  Created by jamkin on 16/8/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DrinkHeaderView.h"
#import "PinholeView.h"

#import "HealthPlanView.h"

@interface DrinkHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *topBView;

/*线的属性或约束属性*/
@property (weak, nonatomic) IBOutlet UIView *lineOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOneCons;
@property (weak, nonatomic) IBOutlet UIView *lineTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwoCons;
@property (weak, nonatomic) IBOutlet UIView *lineThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineThreeCons;
@property (weak, nonatomic) IBOutlet UIView *lineFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineFourCons;
@property (weak, nonatomic) IBOutlet UIView *lineFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineFiveCons;
@property (weak, nonatomic) IBOutlet UIView *lineSix;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineSixCons;
@property (weak, nonatomic) IBOutlet UIView *lineSeven;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineSevenCons;

/*按钮的属性或者*/
@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnOneTopCons;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTwoTopCons;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnThreeTopCons;
@property (weak, nonatomic) IBOutlet UIButton *btnFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnFourTopCons;
@property (weak, nonatomic) IBOutlet UIButton *btnFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnFiveTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSixTopCons;
@property (weak, nonatomic) IBOutlet UIButton *btnSix;
@property (weak, nonatomic) IBOutlet UIButton *btnSeven;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnSevenTopCons;
/*用数组存放按钮*/
@property (nonatomic,strong)NSArray *btnArray;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTthoud;

//计量单位气泡
@property (weak, nonatomic) IBOutlet UILabel *acountLab;

/*数组属性存放两次数据源画出的点 按钮*/
@property (nonatomic,strong)NSArray *yellowArray;
@property (nonatomic,strong)NSArray *greenArray;

/**
 1万
 */
@property (weak, nonatomic) IBOutlet UIImageView *tThousand;







/*表示绘制图像的路径*/
@property (nonatomic,strong)UIBezierPath *path;
@property (weak, nonatomic) IBOutlet UILabel *maxCountLab;

/*时间标签*/
@property (weak, nonatomic) IBOutlet UILabel *mothAndDayOne;
@property (weak, nonatomic) IBOutlet UILabel *mothAndDayTwo;
@property (weak, nonatomic) IBOutlet UILabel *mothAndDayThree;
@property (weak, nonatomic) IBOutlet UILabel *mothAndDayFour;
@property (weak, nonatomic) IBOutlet UILabel *mothAndDayFive;
@property (weak, nonatomic) IBOutlet UILabel *mothAndDaySix;
@property (weak, nonatomic) IBOutlet UILabel *mothAndDaySeven;
@property (weak, nonatomic) IBOutlet UILabel *yearOne;
@property (weak, nonatomic) IBOutlet UILabel *yearTwo;
@property (weak, nonatomic) IBOutlet UILabel *yearThree;
@property (weak, nonatomic) IBOutlet UILabel *yearFour;
@property (weak, nonatomic) IBOutlet UILabel *yearFive;
@property (weak, nonatomic) IBOutlet UILabel *yearSix;
@property (weak, nonatomic) IBOutlet UILabel *yearSeven;

/*用数组来存放月份和日期以及年份*/
@property (nonatomic,strong)NSArray *monthAndDayArray;
@property (nonatomic,strong)NSArray *yearArray;
@property (weak, nonatomic) IBOutlet UIImageView *markIng;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLeftCons;

/*数组属性存放两次数据源画出的点 按钮*/

@property (weak, nonatomic) IBOutlet UILabel *y1;
@property (weak, nonatomic) IBOutlet UILabel *y2;
@property (weak, nonatomic) IBOutlet UILabel *y3;
@property (weak, nonatomic) IBOutlet UILabel *y4;
@property (weak, nonatomic) IBOutlet UILabel *y5;
@property (weak, nonatomic) IBOutlet UILabel *y6;
@property (weak, nonatomic) IBOutlet UILabel *y7;

@property (weak, nonatomic) IBOutlet UILabel *g1;
@property (weak, nonatomic) IBOutlet UILabel *g2;
@property (weak, nonatomic) IBOutlet UILabel *g3;
@property (weak, nonatomic) IBOutlet UILabel *g4;
@property (weak, nonatomic) IBOutlet UILabel *g5;
@property (weak, nonatomic) IBOutlet UILabel *g6;
@property (weak, nonatomic) IBOutlet UILabel *g7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTitleCons;
@property (weak, nonatomic) IBOutlet UIView *topTitleView;
@property (nonatomic, strong) HealthPlanView *planView;
/**
描述最大值标签的宽度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *markMaxWidthCons;

/**上次按钮*/
@property (nonatomic,strong) NSArray *preBtnArray;

@end

@implementation DrinkHeaderView
#pragma mark ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView moveToIndex:offset];
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [self.planView endMoveToIndex:offset];
    NSInteger tempIndex = [self.planView changeProgressToInteger:offset];
    NSLog(@"tempIndex------%li",tempIndex);
    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
        [self.delegate clickBtnToIndex:self.titleReloaddataArray[tempIndex]];
    }
}
#pragma mark Private Methoud
- (void)addTitleSubView
{
//    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, (45))];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KScreenWidth * self.titleReloaddataArray.count, (45));
    
    [self.topTitleView addSubview:scrollView];
//    for (int i = 0; i <self.titleReloaddataArray.count; i++)
//    {
//        XKPhySicalItemModel *mod =  self.titleReloaddataArray[i];
//        [mArray addObject:mod.PhysicalItemName];
//    }
//
    //头部分类视图
    HealthPlanHead *headView = [[HealthPlanHead alloc]init];
    headView.itemWidth =  (KScreenWidth) / (self.titleReloaddataArray.count);
    
    HealthPlanView *planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, (45))];
    planView.tapAnimation = YES;
    planView.headView = headView;
    planView.titleArray = self.titleReloaddataArray;
    
    __weak typeof (scrollView)weakScrollView = scrollView;
    [planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
        
        if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
            [self.delegate clickBtnToIndex:self.titleReloaddataArray[index]];
        }
        
        //将两个scrollView联动起来
        [weakScrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(weakScrollView.frame), 0.0, CGRectGetWidth(weakScrollView.frame),CGRectGetHeight(weakScrollView.frame)) animated:animation];
        
    }];
    [self.topTitleView addSubview:planView];
    self.planView = planView;
}
-(void)setIsMulitueDataOrSingle:(BOOL)isMulitueDataOrSingle
{
//   检测项目编号 32、空腹血糖,33、餐后血糖,163、随机血糖,9、体温,1、BMI,189、体重,14、脂肪率,51、静息心率,10、血红蛋白,34、总胆固醇,36、高密度胆固醇,37、低密度胆固醇,35、甘油三脂,18、收缩压,19、舒张压,181、血氧,    
    _isMulitueDataOrSingle = isMulitueDataOrSingle;
    if (self.isMulitueDataOrSingle == YES) {
        [self addTitleSubView];
        self.topTitleCons.constant = 45;
    }else
        self.topTitleCons.constant = 1;
    [self layoutIfNeeded];
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    

    
    self.backgroundColor=kbackGroundGrayColor;
    
    self.lineOne.backgroundColor=[UIColor whiteColor];
    self.lineOneCons.constant=0.5;
    self.lineTwo.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.lineTwoCons.constant=0.5;
    self.lineThree.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.lineThreeCons.constant=0.5;
    self.lineFour.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.lineFourCons.constant=0.5;
    self.lineFive.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.lineFiveCons.constant=0.5;
    self.lineSix.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.lineSixCons.constant=0.5;
    self.lineSeven.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.6];
    self.lineSevenCons.constant=0.5;
    
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
    
    self.btnArray=@[self.btnOne,self.btnTwo,self.btnThree,self.btnFour,self.btnFive,self.btnSix,self.btnSeven];
    
    self.maxCountLab.top=10;
    
    self.monthAndDayArray = @[self.mothAndDayOne,self.mothAndDayTwo,self.mothAndDayThree,self.mothAndDayFour,self.mothAndDayFive,self.mothAndDaySix,self.mothAndDaySeven];
    
    self.yearArray = @[self.yearOne,self.yearTwo,self.yearThree,self.yearFour,self.yearFive,self.yearSix,self.yearSeven];
    
    //清空时间标签
    for (UILabel *lab in self.yearArray) {
        lab.text=@"";
    }
    for (UILabel *lab in self.monthAndDayArray) {
        lab.text=@" ";
    }
    
    self.yellowLabArray=[[NSMutableArray alloc]initWithArray:@[self.y1,self.y2,self.y3,self.y4,self.y5,self.y6,self.y7]];
    self.greenLabArray=[[NSMutableArray alloc]initWithArray:@[self.g1,self.g2,self.g3,self.g4,self.g5,self.g6,self.g7]];
    for (int i=0; i<self.yellowLabArray.count; i++) {
        UILabel *lab=self.yellowLabArray[i];
        lab.textColor=kMainTitleColor;
        lab.font=[UIFont systemFontOfSize:12];
        lab.textAlignment=NSTextAlignmentCenter;
    }
    for (int i=0; i<self.greenLabArray.count; i++) {
        UILabel *lab=self.greenLabArray[i];
        lab.textColor=[UIColor whiteColor];
        lab.font=[UIFont systemFontOfSize:12];
        lab.textAlignment=NSTextAlignmentCenter;
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fresh) name:@"fresh" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fresh) name:@"fresh1" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLast:) name:@"selectLast" object:nil];
    
    
    if (IS_IPHONE5) {
        
        self.acountOneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        
        self.acountTwoBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        
    }
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (84)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.topBView.layer.mask=maskTwoLayer;
    
    
    CAShapeLayer *maskTwoLayer1 = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (45)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer1.frame = corTwoPath1.bounds;
    maskTwoLayer1.path=corTwoPath1.CGPath;
    self.topTitleView.layer.mask=maskTwoLayer1;
}

/*接收通知选中最后一个*/
-(void)clickLast:(NSNotification *)noti{
    NSLog(@"%@",noti);
    NSInteger selectIndex=[noti.object integerValue];
    switch (selectIndex) {
        case 1:
            [self clickSeven:self.btnOne];
            break;
        case 2:
            [self clickSeven:self.btnTwo];
            break;
        case 3:
            [self clickSeven:self.btnThree];
            break;
        case 4:
            [self clickSeven:self.btnFour];
            break;
        case 5:
            [self clickSeven:self.btnFive];
            break;
        case 6:
            [self clickSeven:self.btnSix];
            break;
        case 7:
            [self clickSeven:self.btnSeven];
            break;
            
        default:
            break;
    }
    
}

-(void)adjustFontToLab:(NSInteger)index{
    
    for (int i=0; i<self.monthAndDayArray.count; i++) {
        UILabel *lab=self.monthAndDayArray[i];
        if (i==index) {
            lab.font=[UIFont systemFontOfSize:15];
        }else{
            lab.font=[UIFont systemFontOfSize:12];
//            lab.textColor = [UIColor getColor:@"7C838C"];
        }
    }
    for (int i=0; i<self.yearArray.count; i++) {
        UILabel *lab=self.yearArray[i];
        if (i==index) {
            lab.font=[UIFont systemFontOfSize:15];
        }else{
            lab.font=[UIFont systemFontOfSize:12];
//            lab.textColor = [UIColor getColor:@"7C838C"];
        }
    }
    
}

- (IBAction)clickOne:(id)sender {
    NSLog(@"第一");
    self.btnOneTopCons.constant=0;
    self.btnTwoTopCons.constant=15;
    self.btnThreeTopCons.constant=15;
    self.btnFourTopCons.constant=15;
    self.btnFiveTopCons.constant=15;
    self.btnSixTopCons.constant=15;
    self.btnSevenTopCons.constant=15;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
    
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:0];
//    }
    self.acountLab.centerX=self.btnOne.centerX;
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[0] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    [self adjustFontToLab:0];
    
}
- (IBAction)clickTwo:(id)sender {
    NSLog(@"第二");
    self.btnOneTopCons.constant=15;
    self.btnTwoTopCons.constant=0;
    self.btnThreeTopCons.constant=15;
    self.btnFourTopCons.constant=15;
    self.btnFiveTopCons.constant=15;
    self.btnSixTopCons.constant=15;
    self.btnSevenTopCons.constant=15;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor whiteColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:1];
//    }
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[1] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    self.acountLab.centerX=self.btnTwo.centerX;
    [self adjustFontToLab:1];
}
- (IBAction)clickThree:(id)sender {
    NSLog(@"第三");
    self.btnOneTopCons.constant=15;
    self.btnTwoTopCons.constant=15;
    self.btnThreeTopCons.constant=0;
    self.btnFourTopCons.constant=15;
    self.btnFiveTopCons.constant=15;
    self.btnSixTopCons.constant=15;
    self.btnSevenTopCons.constant=15;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:2];
//    }
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[2] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    self.acountLab.centerX=self.btnThree.centerX;
    [self adjustFontToLab:2];
}
- (IBAction)clickFour:(id)sender {
    NSLog(@"第四");
    self.btnOneTopCons.constant=15;
    self.btnTwoTopCons.constant=15;
    self.btnThreeTopCons.constant=15;
    self.btnFourTopCons.constant=0;
    self.btnFiveTopCons.constant=15;
    self.btnSixTopCons.constant=15;
    self.btnSevenTopCons.constant=15;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor whiteColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:3];
//    }
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[3] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    self.acountLab.centerX=self.btnFour.centerX;
    [self adjustFontToLab:3];
}
- (IBAction)clickFive:(id)sender {
    NSLog(@"第五");
    self.btnOneTopCons.constant=15;
    self.btnTwoTopCons.constant=15;
    self.btnThreeTopCons.constant=15;
    self.btnFourTopCons.constant=15;
    self.btnFiveTopCons.constant=0;
    self.btnSixTopCons.constant=15;
    self.btnSevenTopCons.constant=15;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:4];
//    }
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[4] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    self.acountLab.centerX=self.btnFive.centerX;
    [self adjustFontToLab:4];
}

- (IBAction)clickSix:(id)sender {
    NSLog(@"第六");
    self.btnOneTopCons.constant=15;
    self.btnTwoTopCons.constant=15;
    self.btnThreeTopCons.constant=15;
    self.btnFourTopCons.constant=15;
    self.btnFiveTopCons.constant=15;
    self.btnSixTopCons.constant=0;
    self.btnSevenTopCons.constant=15;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor whiteColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:5];
//    }
    [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[5] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    self.acountLab.centerX=self.btnSix.centerX;
    [self adjustFontToLab:5];
}
- (IBAction)clickSeven:(id)sender {
    NSLog(@"第七");
    self.btnOneTopCons.constant=15;
    self.btnTwoTopCons.constant=15;
    self.btnThreeTopCons.constant=15;
    self.btnFourTopCons.constant=15;
    self.btnFiveTopCons.constant=15;
    self.btnSixTopCons.constant=15;
    self.btnSevenTopCons.constant=0;
    self.btnOne.backgroundColor=[UIColor whiteColor];
    self.btnTwo.backgroundColor=[UIColor clearColor];
    self.btnThree.backgroundColor=[UIColor whiteColor];
    self.btnFour.backgroundColor=[UIColor clearColor];
    self.btnFive.backgroundColor=[UIColor whiteColor];
    self.btnSix.backgroundColor=[UIColor clearColor];
    self.btnSeven.backgroundColor=[UIColor whiteColor];
//    if ([self.delegate respondsToSelector:@selector(clickBtnToIndex:)]) {
//        [self.delegate clickBtnToIndex:6];
//    }
    
    if (IS_IPHONE5) {
        [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[6] integerValue],self.markStr] withBigFont:14 withNeedchangeText:self.markStr withSmallFont:8]];
    }
    if (IS_IPHONE6) {
        [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[6] integerValue],self.markStr] withBigFont:16 withNeedchangeText:self.markStr withSmallFont:10]];
    }else{
        [self.acountLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%li%@",(long)[self.dataArray[6] integerValue],self.markStr] withBigFont:20 withNeedchangeText:self.markStr withSmallFont:12]];
    }
    
    self.acountLab.centerX=self.btnSeven.centerX;
    [self adjustFontToLab:6];
}

/**实现控制器的协议方法**/
-(void)selectWhole:(NSInteger)index{
    
    switch (index) {
        case 0:
            [self clickSeven:self.btnSeven];
            break;
        case 1:
            [self clickSix:self.btnSix];
            break;
        case 2:
            [self clickFive:self.btnFive];
            break;
        case 3:
            [self clickFour:self.btnFour];
            break;
        case 4:
            [self clickThree:self.btnThree];
            break;
        case 5:
            [self clickTwo:self.btnTwo];
            break;
        case 6:
            [self clickOne:self.btnOne];
            break;
            
        default:
            break;
    }
    
}

-(void)setIsShowAir:(BOOL)isShowAir{
    
    _isShowAir=isShowAir;
    
    if (_isShowAir) {
        
        self.acountOneBtn.hidden=YES;
        self.acountTwoBtn.hidden=YES;
        self.acountLab.hidden=NO;
        
    }else{
        
        self.acountOneBtn.hidden=NO;
        self.acountTwoBtn.hidden=NO;
        self.acountLab.hidden=YES;
        
    }
    
}

-(void)setDescriptionStr:(BOOL)descriptionStr{
    
    _descriptionStr=descriptionStr;
    
    if (_descriptionStr) {
        
        self.btnOne.enabled=YES;
        self.btnTwo.enabled=YES;
        self.btnThree.enabled=YES;
        self.btnFour.enabled=YES;
        self.btnFive.enabled=YES;
        self.btnSix.enabled=YES;
        self.btnSeven.enabled=YES;
        
        for (int i=0; i<self.yellowLabArray.count; i++) {
            UILabel *lab1=self.yellowLabArray[i];
            UILabel *lab2=self.greenLabArray[i];
            lab2.hidden=YES;
            lab1.hidden=YES;
        }
        
    }else{
        self.btnOne.enabled=NO;
        self.btnTwo.enabled=NO;
        self.btnThree.enabled=NO;
        self.btnFour.enabled=NO;
        self.btnFive.enabled=NO;
        self.btnSix.enabled=NO;
        self.btnSeven.enabled=NO;
    }
    
}

-(void)setLineStyle:(BOOL)lineStyle{
    _lineStyle=lineStyle;
    if (lineStyle) {
        self.maxCountLab.hidden=YES;//   虚线的线条
        self.markIng.image=[UIImage imageNamed:@"line"];

        self.imgLeftCons.constant=0;
    }else{
        
    }
}

/**调整日月周按钮的样式**/
-(void)oneTimeJust:(UIButton *)btn{
    
    btn.backgroundColor=[UIColor clearColor];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

/**接到通知刷新数据**/
-(void)fresh{

    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"fresh" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"fresh1" object:nil];
    
    
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectLast" object:nil];
    
}

/**调整子视图的位置**/
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}


/**画线条**/

/**
 连接点的线条

 @param array <#array description#>
 @param color <#color description#>
 */
-(void)drawLine:(NSArray *)array withLineColor:(UIColor *)color{
    
//    [self.lineLayer removeFromSuperlayer];
    
    self.lineLayer=[CAShapeLayer layer];
    
    self.lineLayer.frame=CGRectMake(0, 0, CGRectGetWidth(self.chartView.frame), CGRectGetHeight(self.chartView.frame));
    
    self.path=[UIBezierPath bezierPath];
    
    UIButton *rirstBtn=array[0];
    
    CGPoint firstPoint=CGPointMake(0, rirstBtn.centerY);
    
    [self.path moveToPoint:firstPoint];
    
    for (int i=0; i<array.count; i++) {
        
        UIButton *btn=array[i];
        
        CGPoint point=CGPointMake(btn.centerX, btn.centerY);
        btn.layer.cornerRadius = 10/2.0;
        btn.clipsToBounds = YES;
        btn.backgroundColor = kMainColor;

        [self.path addLineToPoint:point];
        
    }
    
    self.lineLayer.strokeColor=color.CGColor;
    
    self.lineLayer.lineWidth=4;
    
    self.lineLayer.fillColor=[UIColor clearColor].CGColor;
    
    self.lineLayer.path=self.path.CGPath;
    
    [self.chartView.layer addSublayer:self.lineLayer];
    
    
    
//#pragma mark    动画从起点到终点的绘图
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 3;
//    pathAnimation.repeatCount = 1;
//    pathAnimation.removedOnCompletion = YES;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
//
//    [self.lineLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
//    //画圆点
//    for (NSInteger i = 0; i < array.count; i++) {
//        UIButton *btn=array[i];
//
//        CGPoint point=CGPointMake(btn.centerX, btn.centerY);
//
//            CGRect frame = CGRectMake(point.x-6, point.y-8, 12, 12);
//
//            UIBezierPath *path1=[UIBezierPath bezierPathWithOvalInRect:frame];
//
//            CAShapeLayer *layer1=[CAShapeLayer layer];
//
//            layer1.frame=self.chartView.frame;
//
//            layer1.fillColor=[kMainColor CGColor];
//
//            layer1.strokeColor=[kMainColor CGColor];
//
//            layer1.lineWidth=3;
//
//            layer1.strokeStart=0.0;
//
//            layer1.strokeEnd=1.0;
//
//            layer1.path=path1.CGPath;
//
//            [self.chartView.layer addSublayer:layer1];
//
//
//
//    }
//
    
    
}

/**重写获取到数据的set方法 绘制黄色的点和黄色的线条**/
-(void)setDataArray:(NSArray *)dataArray{
    self.y1.text= @"";
    self.y2.text= @"";
    self.y3.text= @"";
    self.y4.text= @"";
    self.y5.text= @"";
    self.y6.text= @"";
    self.y7.text= @"";
    //清除之前的线条点
    [self.lineLayer removeFromSuperlayer];
    if (self.preBtnArray) {
        for (UIButton *btn in self.preBtnArray) {
            [btn removeFromSuperview];
        }
    }
    self.path = nil;
    
    _dataArray=dataArray;
    
    if (dataArray.count<= 0) {
        return;
    }
    
    if ([_dataArray[0] isKindOfClass:[NSString class]]) {
        
        NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (NSString *res in _dataArray) {
            
            NSArray *strArray=[res componentsSeparatedByString:@":"];
            
            CGFloat second=[strArray[1] integerValue]/60.0;
            
            CGFloat num=[strArray[0] integerValue]+second;
            
            [array addObject:@(num)];
            
        }
        
        CGFloat maxNum=24;
//        [self takeMaxNum:array];
        
        self.maxCountLab.text=[NSString stringWithFormat:@"%li%@",(long)maxNum,self.markStr];
        
        [self commonDrawBtn:YES withSavaToArray:self.yellowArray withMaxNum:maxNum orgin:array];;
        return;
        
    }
    
    if (self.maxScore!=0) {
        CGFloat maxNum=self.maxScore;
        
        self.maxCountLab.text=[NSString stringWithFormat:@"%li%@",(long)maxNum,self.markStr];
        
        [self commonDrawBtn:YES withSavaToArray:self.yellowArray withMaxNum:maxNum orgin:_dataArray];
    }else{
        CGFloat maxNum=[self takeMaxNum:_dataArray];
        
        self.maxCountLab.text=[NSString stringWithFormat:@"%li%@",(long)maxNum,self.markStr];
        
        [self commonDrawBtn:YES withSavaToArray:self.yellowArray withMaxNum:maxNum orgin:_dataArray];
    }
    
    if (!self.lineStyle) {
        CGSize cSize1 = [self.maxCountLab.text boundingRectWithSize:CGSizeMake((KScreenWidth-103)/2-27, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
        
        self.imgLeftCons.constant=cSize1.width+20;
        self.markMaxWidthCons.constant=cSize1.width+20;
    }
    
}

/**重写获取到数据的set方法 绘制绿色的点和绿色的线条**/
-(void)setOtherDataArray:(NSArray *)otherDataArray{
    self.g1.text= @"";
    self.g2.text= @"";
    self.g3.text= @"";
    self.g4.text= @"";
    self.g5.text= @"";
    self.g6.text= @"";
    self.g7.text= @"";
    _otherDataArray=otherDataArray;
    
    if ([_otherDataArray[0] isKindOfClass:[NSString class]]) {
        
        NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (NSString *res in _otherDataArray) {
            
            NSArray *strArray=[res componentsSeparatedByString:@":"];
            
            CGFloat second=[strArray[1] integerValue]/60.0;
            
            CGFloat num=[strArray[0] integerValue]+second;
            
            [array addObject:@(num)];
            
        }
        
        CGFloat maxNum=24;
        [self takeMaxNum:array];
        
        self.maxCountLab.text=[NSString stringWithFormat:@"%li%@",(long)maxNum,self.markStr];
        
        [self commonDrawBtn:YES withSavaToArray:self.greenArray withMaxNum:maxNum orgin:array];;
        return;
        
    }
    
    if (self.maxScore!=0) {
        CGFloat maxNum=self.maxScore;
//        [self takeMaxNum:_otherDataArray];
        
        self.maxCountLab.text=[NSString stringWithFormat:@"%li%@",(long)maxNum,self.markStr];
        
        [self commonDrawBtn:NO withSavaToArray:self.greenArray withMaxNum:maxNum orgin:_otherDataArray];
    }else{
        CGFloat maxNum=[self takeMaxNum:_otherDataArray];
        //        [self takeMaxNum:_otherDataArray];
        
        self.maxCountLab.text=[NSString stringWithFormat:@"%li%@",(long)maxNum,self.markStr];
        
        [self commonDrawBtn:NO withSavaToArray:self.greenArray withMaxNum:maxNum orgin:_otherDataArray];
    }
    
    if (!self.lineStyle) {
        CGSize cSize1 = [self.maxCountLab.text boundingRectWithSize:CGSizeMake((KScreenWidth-103)/2-27, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
        
        self.imgLeftCons.constant=cSize1.width+20;
        self.markMaxWidthCons.constant=cSize1.width+20;
    }

}

//公共的保存点的方法

/**
 maxHeigt  最高高度值 304   260

 @param isYellow <#isYellow description#>
 @param array <#array description#>
 @param maxNum maxNum = 22801  最大值数量
 @param orgin 每天计步数量值
 */
-(void)commonDrawBtn:(BOOL)isYellow withSavaToArray:(NSArray *)array withMaxNum:(NSInteger)maxNum orgin:(NSArray *)orgin{
   
    NSArray *barray=[self createPoint:isYellow orgin:orgin];//创建按钮
    self.preBtnArray = barray;//赋值
    CGFloat maxHeigt=CGRectGetHeight(self.chartView.frame);
    
    UIColor *color;
    if (isYellow) {
        color=kMainColor;
        
    }else{
        color=[UIColor getColor:@"9dfe3c"];
        
    }
    
    if (maxNum==0) {//最大值为零的时候
        
        for (int i=0; i<barray.count; i++) {
            UIButton *btn=barray[i];
//            UIButton *sBtn=self.btnArray[i];
            btn.left=(KScreenWidth-20)/7*i+((KScreenWidth-20)/7)/2-5;
            btn.y=maxHeigt-10;
            btn.width=10;
            btn.height=10;
            NSLog(@"-----%f",btn.y);
            [self.chartView addSubview:btn];
            
        }
        
        [self drawLine:barray withLineColor:color];
        
    }else{//最大值不为零的时候
        /*用户在1万步之前是240PX   在一万步之后是140PX*/
        CGFloat oneHeightX = 0;
        
        CGFloat oneHeightY = 0;
        if (!self.lineStyle) {
            
            self.maxCountLab.hidden=YES;//   虚线的线条
            self.markIng.hidden = YES;
            
            self.tThousand.hidden = NO;
        }

        if ([_markStr isEqualToString:@"步"]) {
          
           
            
            /*  (maxNum - 10000.0)*oneHeightX * Y(240)/Y(140) + (10000.0*oneHeightX) = (maxHeigt-55-10);*/
            oneHeightY = oneHeightX * KHeight(240)/KHeight(140);
            
            oneHeightX =  (maxHeigt-55-10)/(KHeight(240)/KHeight(140)*(maxNum - 10000.0)-(KHeight(240)/KHeight(140))+10000.0);
            
            //  (maxHeigt-55-10) - (10000.0*Y(240));
           self.bottomTthoud.constant = oneHeightX*10000;
            
            
        }
        else
        {
        
           
            
            oneHeightX = (maxHeigt-55-10)/maxNum;
            
            self.bottomTthoud.constant = (maxHeigt-55-10);
        }
        
        
        
        for (int i=0; i<barray.count; i++) {
            
            UIButton *btn=barray[i];
            btn.left=(KScreenWidth-20)/7*i+((KScreenWidth-20)/7)/2-5;
            NSInteger oneNum=[orgin[i] integerValue];
            CGFloat trueHeight = 0 ;
            if (oneNum <= 10000) {
                
                trueHeight=oneNum*oneHeightX;
                
            }
            else
                trueHeight= (oneNum -10000.0)*oneHeightX *KHeight(240)/KHeight(140)+(10000.0*oneHeightX);
           
            btn.y=maxHeigt-trueHeight-10;
            btn.width=10;
            btn.height=10;
            NSLog(@"btn.y:-最大值不为零----%f",btn.y);
            [self.chartView addSubview:btn];
            
        }
        
//        CGFloat oneHeight=(maxHeigt-55-10)/maxNum;
//        
//        for (int i=0; i<barray.count; i++) {
//            
//            UIButton *btn=barray[i];
//            //            UIButton *sBtn=self.btnArray[i];
//            btn.left=KScreenWidth/7*i+(KScreenWidth/7)/2-5;
//            NSInteger oneNum=[orgin[i] integerValue];
//            CGFloat trueHeight=oneNum*oneHeight;
//            btn.y=maxHeigt-trueHeight-10;
//            btn.width=10;
//            btn.height=10;
//            [self.chartView addSubview:btn];
//            
//        }
        
        [self drawLine:barray withLineColor:color];
        
        
        
        
    }
    
    if (isYellow) {
        for (int i=0; i<barray.count; i++) {
            if (i<=6) {
                UILabel *lab=self.yellowLabArray[i];
                lab.left=(KScreenWidth-20)/7*i;
                lab.width=(KScreenWidth-20)/7;
                lab.height=20;
                UIButton *btn=barray[i];
                lab.top=btn.top-20;
                if (i>=self.dataArray.count) {
                    lab.hidden=YES;
                }else{
//                    CGFloat sc=[self.dataArray[i] floatValue];
                    NSNumber *numer=[NSNumber numberWithFloat:[self.dataArray[i] floatValue]];
                    lab.hidden = NO;
                    lab.text=[NSString stringWithFormat:@"%@",numer];
                }
            }
        }
    }else{
        for (int i=0; i<barray.count; i++) {
            if (i<=6) {
                UILabel *lab=self.greenLabArray[i];
                lab.left=(KScreenWidth-20)/7*i;
                lab.width=(KScreenWidth-20)/7;
                lab.height=20;
                UIButton *btn=barray[i];
                lab.top=btn.top-20;
                if (i>=self.otherDataArray.count) {
                    lab.hidden=YES;
                }else{
//                    CGFloat sc=[self.otherDataArray[i] floatValue];
                    NSNumber *numer=[NSNumber numberWithFloat:[self.otherDataArray[i] floatValue]];
                    lab.hidden = NO;
                    lab.text=[NSString stringWithFormat:@"%@",numer];
                }
            }
        }
    }
    
}

-(NSArray *)createPoint:(BOOL)isYellow orgin:(NSArray *)orgin{
    
    NSMutableArray *bArray=[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<orgin.count; i++) {

        if (i<=6) {
            UIButton *btn=[[UIButton alloc]init];
            if (isYellow) {//是黄色
                [btn setImage:[UIImage imageNamed:@"dot_yellow"] forState:UIControlStateNormal];
            }else{//不是黄色
                [btn setImage:[UIImage imageNamed:@"dot_green"] forState:UIControlStateNormal];
            }
            [bArray addObject:btn];
        }
    }
    
    return (NSArray *)bArray;
    
}

-(CGFloat)takeMaxNum:(NSArray *)array{
    CGFloat maxNum=[array[0] floatValue];
    for (int i=0; i<array.count; i++) {//获取最大值
        CGFloat num=[array[i] floatValue];
        if (num>maxNum) {
            maxNum=num;
        }
    }
    return maxNum;
}

/**重写获取到lable标签的set方法**/
-(void)setLabArray:(NSArray *)labArray{
    
    _labArray=labArray;
    
    NSInteger maxCount=_labArray.count;
    
    for (int i=0; i<self.btnArray.count; i++) {//控制按钮是否可以点击
        UIButton *btn=self.btnArray[i];
        if (i>maxCount) {
            btn.enabled=NO;
        }
    }
    
    for (UILabel *lab in self.monthAndDayArray) {
        lab.text=@" ";
    }
    
    for (int i=0; i<_labArray.count; i++) {
        
        if (i<=6) {
            NSString *str=_labArray[i];
            
            NSArray *strArray=[str componentsSeparatedByString:@"/"];
            
            UILabel *lab=self.monthAndDayArray[i];
            lab.text = [NSString stringWithFormat:@"%@/%@",[strArray firstObject],[strArray lastObject]];
            
//            UILabel *lab1=self.yearArray[i];
//            lab1.text=strArray[1];
        }
        
    }
    
}

- (void)setYearDataArr:(NSArray *)yearDataArr
{
    _yearDataArr = yearDataArr;
    
    NSInteger maxCount=_yearDataArr.count;
    
    for (int i=0; i<self.btnArray.count; i++) {//控制按钮是否可以点击
        UIButton *btn=self.btnArray[i];
        if (i>maxCount) {
            btn.enabled=NO;
        }
    }
    
    for (UILabel *lab in self.yearArray) {
        lab.text=@"";
    }
    
    for (int i=0; i<_yearDataArr.count; i++) {
        
        if (i<=6) {
            NSString *str=_yearDataArr[i];
            
            NSArray *stringArray = @[];
            if ([str containsString:@"-"])
            {
                stringArray = [str componentsSeparatedByString:@"-"];
            }else
            {
                stringArray = [str componentsSeparatedByString:@"/"];
            }
            
            UILabel *lab1 = self.yearArray[i];
            lab1.text = stringArray[0];
        }
        
    }
}

- (IBAction)accountOneAction:(id)sender {

    
    if ([self.delegate respondsToSelector:@selector(clickDateToTakeData:)]) {
        [self.delegate clickDateToTakeData:2000];
    }
    
}

- (IBAction)accountTwoAction:(id)sender {

    
    if ([self.delegate respondsToSelector:@selector(clickDateToTakeData:)]) {
        [self.delegate clickDateToTakeData:3000];
    }
    
}


@end