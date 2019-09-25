//
//  MoodTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MoodTableViewCell.h"
#import "MoodCollectionViewCell.h"

@interface MoodTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewLayout *customLayout;
@property (strong, nonatomic) NSArray *dataArr ;
@property (strong, nonatomic) NSArray *titleArr ;
@property (strong, nonatomic) NSArray *titleBackGroundArr ;
@end
@implementation MoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _customLayout = [[UICollectionViewLayout alloc] init]; // 自定义的布局对象
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    self.backgroundColor = [UIColor whiteColor];
//    NSDictionary *dic = [self.dataArray objectAtIndex:i];
//    [mArray addObject:dic[@"TypeName"]];
    _dataArr = @[@"iv_relax",@"iv_nature",@"iv_quite"];
     _titleArr= @[@"放轻松",@"自然乐",@"静一静"];
      _titleBackGroundArr = @[@"70DAFA",@"5EA7EB",@"35CEA1"];
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerNib:[UINib nibWithNibName:@"MoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MoodCollectionViewCell"];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((KScreenWidth-52)/3, 110);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    [_collectionView setCollectionViewLayout:flow];
    
    
    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (130)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    maskTwoLayer.frame = corTwoPath.bounds;
    maskTwoLayer.path=corTwoPath.CGPath;
    self.backView.layer.mask=maskTwoLayer;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoodCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"MoodCollectionViewCell" forIndexPath:indexPath];
    cell.nameLab.text = _titleArr[indexPath.row];
    cell.nameLab.backgroundColor = [UIColor getColor:_titleBackGroundArr[indexPath.row]];
     cell.backImage.image = [UIImage imageNamed:_dataArr[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(moodButtonClick:)]) {
        [self.delegate moodButtonClick:indexPath.row];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
