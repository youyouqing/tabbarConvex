//
//  HealthTestTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "HealthTestTableViewCell.h"
#import "HealthTestCollectionViewCell.h"
@interface HealthTestTableViewCell()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewLayout *customLayout;
//@property (strong, nonatomic) NSArray *imageArray;
//@property (strong, nonatomic) NSArray *titleArray;
@property (weak, nonatomic) IBOutlet UIView *backView;
//@property (strong, nonatomic) NSArray *secondTitleArray;
@end

@implementation HealthTestTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _customLayout = [[UICollectionViewLayout alloc] init]; // 自定义的布局对象
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    self.backgroundColor = [UIColor whiteColor];
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerNib:[UINib nibWithNibName:@"HealthTestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HealthTestCollectionViewCell"];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //dzc todo 11.18
//    flow.itemSize = CGSizeMake((KScreenWidth-5-18*2)/2, 246+5);
    flow.itemSize = CGSizeMake((KScreenWidth-5-18*2)/2, ((KScreenWidth-5-18*2)/2*190/158.0)+5);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 5;
    
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    [_collectionView setCollectionViewLayout:flow];
    
    
//    _imageArray = @[@"iv_zice_suolvetu",@"iv_zice_suolvetu",@"iv_zice_suolvetu",@"iv_zice_suolvetu"];
//
//
//    _titleArray = @[@"中医体质检测",@"亚健康测试",@"日常行为测试",@"健商"];
//    _secondTitleArray = @[@"100",@"100",@"你的日常行为",@"你的健商"];
    
   
}
-(void)setListModArr:(NSArray *)listModArr
{
    _listModArr = listModArr;
    NSInteger count =  (listModArr.count+1)/2;
    
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (KScreenWidth-5-18*2)/2*190/158.0*count+10+30.f) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.backView.layer.mask=maskTwoLayer;
    [self.collectionView reloadData];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listModArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HealthTestCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"HealthTestCollectionViewCell" forIndexPath:indexPath];
   
    cell.listMod =  self.listModArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
        CheckListModel *listMod =  self.listModArr[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(HealthTestTableViewCellJoinAction:)]) {
    
            [self.delegate HealthTestTableViewCellJoinAction:[NSString stringWithFormat:@"%li",listMod.SetCategoryId]];
        }
    
    
}
-(void)HealthTestCollectionViewCellJoinAction:(HealthTestCollectionViewCell *)cell;
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(HealthTestTableViewCellJoinAction:)]) {
        
        [self.delegate HealthTestTableViewCellJoinAction:cell.nameLab.text ];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end