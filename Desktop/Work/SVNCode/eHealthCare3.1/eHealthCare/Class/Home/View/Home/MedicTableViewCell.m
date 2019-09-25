//
//  MedicTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "MedicTableViewCell.h"
#import "MedicCollectionViewCell.h"
@interface MedicTableViewCell ()<UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
@implementation MedicTableViewCell
static NSString *const cellId = @"cellId";
- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor = [UIColor whiteColor];
    _collectionView.backgroundColor = kbackGroundGrayColor;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"MedicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((KScreenWidth-12)/3, 153);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [_collectionView setCollectionViewLayout:flow];
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, 153) byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, KScreenWidth-12, 153);
    maskLayer.path = maskPath.CGPath;
    _collectionView.layer.mask = maskLayer;
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.WikiEncyTypeList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MedicCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.WikiEncyTypeListModel = self.WikiEncyTypeList[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(XKMedicTableViewCellJoinAction:mod:)]) {
        
        [self.delegate XKMedicTableViewCellJoinAction:indexPath.row mod:self.WikiEncyTypeList[indexPath.row]];
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
