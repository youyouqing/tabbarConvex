//
//  XKTopicHotDetialCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicHotDetialCell.h"
#import "XKTopicDetialReplyController.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import "TZGifPhotoPreviewController.h"
#import "TZVideoPlayerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "XKHotTopicTableCollectionViewCell.h"
@interface XKTopicHotDetialCell ()
{

    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
      NSMutableArray *selectedPhotosSize;
    CGFloat _itemWH;
    CGFloat _margin;
    
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PCollectionTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PCollectionHeightCons;
//图片视图控制器对象
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
//是否是地方的标示
@property (strong, nonatomic) CLLocation *location;

/**
 是否能访问gif图片的设置
 */
@property (nonatomic,assign) BOOL allowPickingGifSwitch;

/**
 设置最多可以选择多少张图片
 */
@property (nonatomic,assign) NSInteger maxPage;

/**
 是否允许内部拍照
 */
@property (nonatomic,assign) BOOL showTakePhotoBtnSwitch;

/**
 是否允许图片裁剪
 */
@property (nonatomic,assign) BOOL allowCropSwitch;


@property (weak, nonatomic) IBOutlet UICollectionView *phCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labContainerBottomCons;

/**
 头像视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

/**
 更多回复视图
 */
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

/**
 评论视图1
 */
@property (weak, nonatomic) IBOutlet UILabel *replyOneLab;

/**
 评论视图2
 */
@property (weak, nonatomic) IBOutlet UILabel *replyTwoLab;

/**
 评论视图3
 */
@property (weak, nonatomic) IBOutlet UILabel *replyThreeLab;

/**
 评论视图4
 */
@property (weak, nonatomic) IBOutlet UILabel *replyFourLab;

/**
 覆盖更多回复视图
 */
@property (weak, nonatomic) IBOutlet UIButton *replcemoreBtn;

/**
 姓名视图
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

/**
 时间视图
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

/**
 评论按钮视图
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/**
 点赞按钮视图
 */
@property (weak, nonatomic) IBOutlet UIButton *priseBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyOneTopCons;

/**
 高度约束视图
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConsOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConsTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConsThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConsFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConsFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConsSix;

/**
 评论标签的容器
 */
@property (weak, nonatomic) IBOutlet UIView *labContainerView;

@property (nonatomic,weak) UIButton *oneBtn;

@property (nonatomic,weak) UIButton *twoBtn;

@property (nonatomic,weak) UIButton *threeBtn;

@end

@implementation XKTopicHotDetialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImg.layer.cornerRadius = 12.5;
    self.iconImg.layer.masksToBounds = YES;
    
    [self.moreBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    self.labContainerView.layer.cornerRadius = 5;
    self.labContainerView.layer.masksToBounds = YES;
    
    UIButton *btn1 = [[UIButton alloc]init];
    [self addSubview:btn1];
    [btn1 addTarget:self action:@selector(aciontOne) forControlEvents:UIControlEventTouchUpInside];
    btn1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *consOne1 = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.replyTwoLab attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *consOne2 = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.replyTwoLab attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *consOne3 = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.replyTwoLab attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *consOne4 = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.replyTwoLab attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    consOne1.active = YES;
    consOne2.active = YES;
    consOne3.active = YES;
    consOne4.active = YES;
    self.oneBtn = btn1;
    
    UIButton *btn2 = [[UIButton alloc]init];
    [self addSubview:btn2];
    btn2.translatesAutoresizingMaskIntoConstraints = NO;
    [btn2 addTarget:self action:@selector(aciontTwo) forControlEvents:UIControlEventTouchUpInside];
    NSLayoutConstraint *consTwo1 = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.replyThreeLab attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *consTwo2 = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.replyThreeLab attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *consTwo3 = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.replyThreeLab attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *consTwo4 = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.replyThreeLab attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    consTwo1.active = YES;
    consTwo2.active = YES;
    consTwo3.active = YES;
    consTwo4.active = YES;
    self.twoBtn = btn2;
    
    UIButton *btn3 = [[UIButton alloc]init];
    [self addSubview:btn3];
    btn3.translatesAutoresizingMaskIntoConstraints = NO;
    [btn3 addTarget:self action:@selector(aciontThree) forControlEvents:UIControlEventTouchUpInside];
    NSLayoutConstraint *consThree1 = [NSLayoutConstraint constraintWithItem:btn3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.replyFourLab attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *consThree2 = [NSLayoutConstraint constraintWithItem:btn3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.replyFourLab attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *consThree3 = [NSLayoutConstraint constraintWithItem:btn3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.replyFourLab attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *consThree4 = [NSLayoutConstraint constraintWithItem:btn3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.replyFourLab attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    consThree1.active = YES;
    consThree2.active = YES;
    consThree3.active = YES;
    consThree4.active = YES;
    self.threeBtn = btn3;
    
    
    _PCollectionTopCons.constant = 15.f;
    //初始化数组
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    selectedPhotosSize = [NSMutableArray array];
    //初始化最大可选择招聘
    self.maxPage = 3;
    //允许内部拍照
    self.showTakePhotoBtnSwitch = YES;
    self.phCollectionView.delegate = self;
    self.phCollectionView.dataSource = self;
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((KScreenWidth-60-20)/3, 78);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.phCollectionView setCollectionViewLayout:flow];
    self.phCollectionView.showsVerticalScrollIndicator = NO;
    self.phCollectionView.showsHorizontalScrollIndicator = NO;
    [_phCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicTableCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XKHotTopicTableCollectionViewCell"];
//    [self.phCollectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setTopicModel:(XKTopicModel *)topicModel{
    
    _topicModel = topicModel;
    
}

/**
 重写属性set方法
 */
-(void)setModel:(XKFirstCommtentModel *)model{
    
    _model = model;
    
    self.oneBtn.frame = CGRectZero;
    self.twoBtn.frame = CGRectZero;
    self.threeBtn.frame = CGRectZero;
    
    [self.moreBtn setTitle:@"更多回复>>" forState:UIControlStateNormal];
    self.moreBtn.hidden = NO;
    
    if (_model.IsPraise == 1) { //已经点赞
        [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];
    }else{//未点赞
        [self.priseBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    
    [self.priseBtn setTitle:[NSString stringWithFormat:@" %li",_model.PraiseScount] forState:UIControlStateNormal];
    
    if (_model.HeadImg.length > 0) {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }else{
        self.iconImg.image = [UIImage imageNamed:@"defaultHead"];
    }
    
    self.nameLab.text = _model.NickName;
    
    [self.commentBtn setTitle:[NSString stringWithFormat:@" %li",_model.ReplyScount] forState:UIControlStateNormal];
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%li",_model.ReplyTime] doubleValue] / 1000.0;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    self.timeLab.text = [Dateformat timeIntervalFromLastTime:time ToCurrentTime:[NSDate date]];
    
    self.replyOneLab.text = _model.ReplyContent;
    self.moreBtn.hidden = NO;
    self.heightConsOne.constant = 15;
    self.heightConsTwo.constant = 30;
    self.heightConsThree.constant = 15;
    self.heightConsFour.constant = 15;
    self.heightConsFive.constant = 15;
    self.heightConsSix.constant = -15;
    self.labContainerBottomCons.constant = 20;
    _PCollectionTopCons.constant = 15.f;

    if (_model.SecondCommentList.count == 0) {
        _PCollectionTopCons.constant = 0.01f;

        self.moreBtn.hidden = YES;
        self.replcemoreBtn.hidden = YES;
        self.replyTwoLab.text = @"";
        self.replyThreeLab.text = @"";
        self.replyFourLab.text = @"";
         self.labContainerBottomCons.constant = -10;
        self.heightConsOne.constant = 30;
        self.heightConsTwo.constant = 0;
        self.heightConsThree.constant = 0;
        self.heightConsFour.constant = 0;
        self.heightConsFive.constant = 0;
        self.heightConsSix.constant = 30;
        [self.moreBtn setTitle:@"" forState:UIControlStateNormal];
        
        self.moreBtn.hidden = YES;
        
    }else if(_model.SecondCommentList.count == 1){
        XKSecondeCommtentModel * oneModel = _model.SecondCommentList[0];
//        self.replyTwoLab.text =  oneModel.ReplyContent;
        //处理第一条数据
        NSTimeInterval _interval1=[[NSString stringWithFormat:@"%li",oneModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time1 = [NSDate dateWithTimeIntervalSince1970:_interval1];

        NSString *oneStr ;
        if ([oneModel.RNickName isEqualToString:oneModel.CNickName]) {
//            oneStr = [NSString stringWithFormat:@"%@：%@     %@",oneModel.CNickName,oneModel.ReplyContent,[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]]];
            oneStr = [NSString stringWithFormat:@"%@：%@     %@",oneModel.CNickName,oneModel.ReplyContent,@""];
            self.replyTwoLab.attributedText = [NSMutableAttributedString changeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
            
        }else{
            oneStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",oneModel.RNickName,oneModel.CNickName,oneModel.ReplyContent,@""];
            
            self.replyTwoLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
            
        }
        //隐藏后边两个标签
        self.replyThreeLab.text = @"";
        self.replyFourLab.text = @"";
        
        //变化行高
        self.heightConsThree.constant = 0;
        self.heightConsFour.constant = 0;
        self.heightConsFive.constant = 0;
        self.heightConsSix.constant = 15;
        
        //影藏更多回复按钮
        [self.moreBtn setTitle:@"" forState:UIControlStateNormal];
        self.moreBtn.hidden = YES;
    }else if(_model.SecondCommentList.count == 2){
        
        XKSecondeCommtentModel * oneModel = _model.SecondCommentList[0];
        NSTimeInterval _interval1=[[NSString stringWithFormat:@"%li",oneModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time1 = [NSDate dateWithTimeIntervalSince1970:_interval1];
        NSString *oneStr ;
        if ([oneModel.RNickName isEqualToString:oneModel.CNickName]) {
            oneStr = [NSString stringWithFormat:@"%@：%@     %@",oneModel.CNickName,oneModel.ReplyContent,@""];
//            [Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]]
            self.replyTwoLab.attributedText = [NSMutableAttributedString changeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            oneStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",oneModel.RNickName,oneModel.CNickName,oneModel.ReplyContent,@""];
            
            self.replyTwoLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
        
        XKSecondeCommtentModel * TwoModel = _model.SecondCommentList[1];
        NSTimeInterval _interval2=[[NSString stringWithFormat:@"%li",TwoModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
        NSString *twoStr;
        if ([TwoModel.RNickName isEqualToString:TwoModel.CNickName]) {
            twoStr = [NSString stringWithFormat:@"%@：%@     %@",TwoModel.CNickName,TwoModel.ReplyContent,@""];
            
            self.replyThreeLab.attributedText = [NSMutableAttributedString changeLabelWithText:twoStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time2 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            twoStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",TwoModel.RNickName,TwoModel.CNickName,TwoModel.ReplyContent,@""];
            
            self.replyThreeLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:twoStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time2 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
        
        //隐藏后边一个标签
        self.replyFourLab.text = @"";
        //变化行高
        self.heightConsFour.constant = 0;
        self.heightConsFive.constant = 0;
        self.heightConsSix.constant = 15;
        //影藏更多回复按钮
        [self.moreBtn setTitle:@"" forState:UIControlStateNormal];
        self.moreBtn.hidden = YES;
        
    }else if(_model.SecondCommentList.count == 3){
        XKSecondeCommtentModel * oneModel = _model.SecondCommentList[0];
        NSTimeInterval _interval1=[[NSString stringWithFormat:@"%li",oneModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time1 = [NSDate dateWithTimeIntervalSince1970:_interval1];
        NSString *oneStr ;
        if ([oneModel.RNickName isEqualToString:oneModel.CNickName]) {
            oneStr = [NSString stringWithFormat:@"%@：%@     %@",oneModel.CNickName,oneModel.ReplyContent,@""];
            
            self.replyTwoLab.attributedText = [NSMutableAttributedString changeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            oneStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",oneModel.RNickName,oneModel.CNickName,oneModel.ReplyContent,@""];
            
            self.replyTwoLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
        
        XKSecondeCommtentModel * TwoModel = _model.SecondCommentList[1];
        NSTimeInterval _interval2=[[NSString stringWithFormat:@"%li",TwoModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
        NSString *twoStr;
        if ([TwoModel.RNickName isEqualToString:TwoModel.CNickName]) {
            twoStr = [NSString stringWithFormat:@"%@：%@     %@",TwoModel.CNickName,TwoModel.ReplyContent,@""];
            
            self.replyThreeLab.attributedText = [NSMutableAttributedString changeLabelWithText:twoStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time2 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            twoStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",TwoModel.RNickName,TwoModel.CNickName,TwoModel.ReplyContent,@""];
            
            self.replyThreeLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:twoStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time2 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
        
        XKSecondeCommtentModel * threeModel = _model.SecondCommentList[2];
        NSTimeInterval _interval3=[[NSString stringWithFormat:@"%li",threeModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time3 = [NSDate dateWithTimeIntervalSince1970:_interval3];
        NSString *threeStr;
        if ([threeModel.RNickName isEqualToString:threeModel.CNickName]) {
            threeStr = [NSString stringWithFormat:@"%@：%@     %@",threeModel.CNickName,threeModel.ReplyContent,@""];
            
            self.replyFourLab.attributedText = [NSMutableAttributedString changeLabelWithText:threeStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time3 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            threeStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",threeModel.RNickName,threeModel.CNickName,threeModel.ReplyContent,@""];
            
            self.replyFourLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:threeStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time3 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }

        //影藏更多回复按钮
        [self.moreBtn setTitle:@"" forState:UIControlStateNormal];
        self.moreBtn.hidden = YES;
        //变化行高
        self.heightConsFive.constant = 0;
        self.heightConsSix.constant = 15;
        
    }else if(_model.SecondCommentList.count >= 4){
        XKSecondeCommtentModel * oneModel = _model.SecondCommentList[0];
        NSTimeInterval _interval1=[[NSString stringWithFormat:@"%li",oneModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time1 = [NSDate dateWithTimeIntervalSince1970:_interval1];
        NSString *oneStr ;
        if ([oneModel.RNickName isEqualToString:oneModel.CNickName]) {
            oneStr = [NSString stringWithFormat:@"%@：%@     %@",oneModel.CNickName,oneModel.ReplyContent,@""];
            
            self.replyTwoLab.attributedText = [NSMutableAttributedString changeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            oneStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",oneModel.RNickName,oneModel.CNickName,oneModel.ReplyContent,@""];
            
            self.replyTwoLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:oneStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time1 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
        
        XKSecondeCommtentModel * TwoModel = _model.SecondCommentList[1];
        NSTimeInterval _interval2=[[NSString stringWithFormat:@"%li",TwoModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
        NSString *twoStr;
        if ([TwoModel.RNickName isEqualToString:TwoModel.CNickName]) {
            twoStr = [NSString stringWithFormat:@"%@：%@     %@",TwoModel.CNickName,TwoModel.ReplyContent,@""];
            
            self.replyThreeLab.attributedText = [NSMutableAttributedString changeLabelWithText:twoStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time2 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            twoStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",TwoModel.RNickName,TwoModel.CNickName,TwoModel.ReplyContent,@""];
            
            self.replyThreeLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:twoStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time2 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
        
        XKSecondeCommtentModel * threeModel = _model.SecondCommentList[2];
        NSTimeInterval _interval3=[[NSString stringWithFormat:@"%li",threeModel.ReplyTime] doubleValue] / 1000.0;
        NSDate *time3 = [NSDate dateWithTimeIntervalSince1970:_interval3];
        NSString *threeStr;
        if ([threeModel.RNickName isEqualToString:threeModel.CNickName]) {
            threeStr = [NSString stringWithFormat:@"%@：%@     %@",threeModel.CNickName,threeModel.ReplyContent,@""];
            
            self.replyFourLab.attributedText = [NSMutableAttributedString changeLabelWithText:threeStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time3 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"]];
        }else{
            threeStr = [NSString stringWithFormat:@"%@ 回复 %@：%@     %@",threeModel.RNickName,threeModel.CNickName,threeModel.ReplyContent,@""];
            
            self.replyFourLab.attributedText = [NSMutableAttributedString threeChangeLabelWithText:threeStr withBigFont:14 withNeedchangeText:[Dateformat timeIntervalFromLastTime:time3 ToCurrentTime:[NSDate date]] withSmallFont:12 dainmaicColor:[UIColor getColor:@"333333"] excisionColor:[UIColor getColor:@"bdbebe"] repayColor:kMainColor rPayStr:@"回复"];
        }
    }
   
    [_selectedPhotos removeAllObjects];
    [selectedPhotosSize removeAllObjects];

    _PCollectionTopCons.constant =  self.PCollectionHeightCons.constant = 0;
//    if ([_model.ReplyImgUrl containsString:@"|"]) {
    if (_model.ReplyImgUrl.length>0) {
        NSArray *imageArr =  [_model.ReplyImgUrl componentsSeparatedByString:@"|"];
        NSMutableArray *tempImageArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *tempImageSizeArr = [NSMutableArray arrayWithCapacity:0];
        for (NSString *imageStrTemp in imageArr) {
            if ([imageStrTemp containsString:@";"]) {
                NSArray *imageA = [imageStrTemp componentsSeparatedByString:@";"];
                [tempImageArr addObject:imageA[0]];
                [tempImageSizeArr addObject:imageA[1]];
            }else
            {
                [tempImageArr addObject:imageStrTemp];
                [tempImageSizeArr addObject:@"640,1336"];
            }
            
        }
        NSLog(@"-%@---%@",tempImageArr,tempImageSizeArr);
        _selectedPhotos = [NSMutableArray arrayWithArray:tempImageArr];
        selectedPhotosSize = [NSMutableArray arrayWithArray:tempImageSizeArr];
        
      
//        _selectedPhotos = [NSMutableArray arrayWithArray:imageArr];
        if (_selectedPhotos.count>0) {
            self.PCollectionHeightCons.constant = 78.0;
            _PCollectionTopCons.constant = 15.f;

        }else
            self.PCollectionHeightCons.constant = 0;
    }
//    else
//    {
//        if (_model.ReplyImgUrl.length>0) {
//
//
//
//            [selectedPhotosSize addObject:@"640,1336"];
//            [_selectedPhotos addObject:_model.ReplyImgUrl];
//            if (_selectedPhotos.count>0) {
//                _PCollectionTopCons.constant = 15.f;
//                self.PCollectionHeightCons.constant = 78.0;//_itemWH*73/109.0;
//            }else
//                self.PCollectionHeightCons.constant = 0;
//        }
//
//
//    }
    if (self.replyOneLab.text.length>0) {
         self.replyOneTopCons.constant = 15.f;
        
    }else
    {
         self.replyOneTopCons.constant = 0.f;

    }

     [self layoutIfNeeded];
     [self.phCollectionView reloadData];
   

    
}

-(void)setNoShow:(BOOL)noShow{
    
    if (noShow) {
        
        self.moreBtn.hidden = YES;
        self.replcemoreBtn.hidden = YES;
        self.replyTwoLab.text = @"";
        self.replyThreeLab.text = @"";
        self.replyFourLab.text = @"";
        
        self.heightConsOne.constant = 0;
        self.heightConsTwo.constant = 0;
        self.heightConsThree.constant = 0;
        self.heightConsFour.constant = 0;
        self.heightConsFive.constant = 0;
        self.heightConsSix.constant = 30;
        [self.moreBtn setTitle:@"" forState:UIControlStateNormal];
        
        self.commentBtn.hidden = YES;
        
        [self.priseBtn setImage:[UIImage imageNamed:@"commentTopic"] forState:UIControlStateNormal];
        [self.priseBtn setTitle:@"" forState:UIControlStateNormal];
        
    }
    
}

/**
 更多评论点击
 */
- (IBAction)moreAction:(id)sender {
    NSLog(@"更多评论");
    XKTopicDetialReplyController *reply = [[XKTopicDetialReplyController alloc] init];
    
    reply.firstModel = self.model;
    
    reply.currentModel = self.topicModel;
    
    [[self parentController].navigationController pushViewController:reply animated:YES];
    
}

/**
 点赞按钮的点击
 */
- (IBAction)priseAction:(id)sender {
    
    if (_model.IsPraise == 1) {//已经点赞  返回
        return;
    }else{//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        //获取首页健康计划、热门话题数据
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"904" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"ReplyID":@(self.model.ReplyID),@"TypeID":@(2)} success:^(id json) {
            
            NSLog(@"%@",json);
            [[XKLoadingView shareLoadingView] hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
             
                //点赞成功 更换点赞按钮图片
                [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];
                
                //1.点赞数量加一
                self.model.PraiseScount++;
                [self.priseBtn setTitle:[NSString stringWithFormat:@"%li",self.model.PraiseScount] forState:UIControlStateNormal];
                
                //2.更换是否点赞的参数
                self.model.IsPraise = 1;
                
                if ([self.delegate respondsToSelector:@selector(detailChangeTopicDataSoure:)]) {
                    [self.delegate detailChangeTopicDataSoure:self.model];
                }
                
            }else{
               
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);
            
        }];
        
    }

    
}

/**
 即将产生二级回复
 */
- (IBAction)commentAction:(id)sender {
    
    NSLog(@"即将产生二级评论");
    if (self.model.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(commtentFistReply:)]) {
        [self.delegate commtentFistReply:self.model];
    }
    
}

/**
 对评论进行回复
 */
- (void)aciontThree {
    NSLog(@"回复评论动作三");
    XKSecondeCommtentModel* secondeCommentMod = (XKSecondeCommtentModel*)(self.model.SecondCommentList[2]);
    if (secondeCommentMod.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(replySecondeCommtent:withSeconde:)]) {
        [self.delegate replySecondeCommtent:self.model withSeconde:self.model.SecondCommentList[2]];
    }
    
}

- (void)aciontTwo {
    NSLog(@"回复评论动作二");
    XKSecondeCommtentModel* secondeCommentMod = (XKSecondeCommtentModel*)self.model.SecondCommentList[1];
    if (secondeCommentMod.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(replySecondeCommtent:withSeconde:)]) {
        [self.delegate replySecondeCommtent:self.model withSeconde:self.model.SecondCommentList[1]];
    }
    
}

- (void)aciontOne {
    NSLog(@"回复评论动作一");
    XKSecondeCommtentModel* secondeCommentMod = (XKSecondeCommtentModel*)self.model.SecondCommentList[0];
    if (secondeCommentMod.ReplyerMemberID == [UserInfoTool getLoginInfo].MemberID) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(replySecondeCommtent:withSeconde:)]) {
        [self.delegate replySecondeCommtent:self.model withSeconde:self.model.SecondCommentList[0]];
    }
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _selectedPhotos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XKHotTopicTableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKHotTopicTableCollectionViewCell" forIndexPath:indexPath];
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString: _selectedPhotos[indexPath.item]] placeholderImage:[UIImage imageNamed:@"iv_huati_suolvetu"]];
    return cell;

}
//点击选中集合视图的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(jumpTopXKHotTopicDetailBigPhoto:sizeArr:withPage:publishFlag:)]) {
        [self.delegate jumpTopXKHotTopicDetailBigPhoto:_selectedPhotos sizeArr:selectedPhotosSize withPage:indexPath.row publishFlag:_topicModel.PublishFlag];
    }
    
    
}


///**
// 重新刷新集合视图
// */
//- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
//    [_selectedAssets addObject:asset];
//    [_selectedPhotos addObject:image];
//    [self.phCollectionView reloadData];
//
//    if ([asset isKindOfClass:[PHAsset class]]) {
//        PHAsset *phAsset = asset;
//        NSLog(@"location:%@",phAsset.location);
//    }
//}
@end
