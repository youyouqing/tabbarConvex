//
//  RemindCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/15.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "RemindCell.h"
#import "RelexCollectionViewCell.h"
@interface RemindCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (strong, nonatomic) UICollectionViewLayout *customLayout;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *secondTitleArray;
@end

@implementation RemindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _customLayout = [[UICollectionViewLayout alloc] init]; // 自定义的布局对象
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    self.backgroundColor = [UIColor whiteColor];
//(KScreenWidth - 30-10)/3.0*346/214.0+30;
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerNib:[UINib nibWithNibName:@"RelexCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RelexCollectionViewCell"];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((KScreenWidth-15-(18))/3, (KScreenWidth - 30-10)/3.0*346/214.0);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    [_collectionView setCollectionViewLayout:flow];
    
    _imageArray = @[@"iv_drinkwater",@"iv_settoolong",@"iv_havedrug"];
    
    
    _titleArray = @[@"饮水提醒",@"久坐提醒",@"用药提醒"];
    _secondTitleArray = @[@"权威中医体质检测，检测你属于哪种体质",@"现在的身体是否处于亚健康状态",@"你的日常行为会对健康造成影响",@"你的健商有多高，一起来测测吧"];
    
//    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
//    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (190)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
//    maskTwoLayer.frame = corTwoPath.bounds;
//    maskTwoLayer.path=corTwoPath.CGPath;
//    self.backView.layer.mask=maskTwoLayer;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

//81E3FF 83EEC7 B6D1FE
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RelexCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"RelexCollectionViewCell" forIndexPath:indexPath];
    cell.bgImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.titleLab.text = _titleArray[indexPath.row];
    NSInteger remindTag = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"RemindCell%li",indexPath.row]];
    if (indexPath.row == 0) {
//        cell.bottomView.backgroundColor = (remindTag-1000== indexPath.row)?([UIColor getColor:@"03C7FF"]):[UIColor getColor:@"81E3FF"];
        cell.bottomBackView.backgroundColor = [UIColor getColor:@"44C4FF"];
//        if (self.healthData.DrinkWaterCount) {
//              [cell.dataLab setAttributedText:[NSMutableAttributedString changeLabelWithText:[NSString stringWithFormat:@"%ziml",self.healthData.DrinkWaterCount] withBigFont:25 withNeedchangeText:@"ml" withSmallFont:12]];
//        }else
//           cell.dataLab.text = @"";
        cell.bgImage.hidden = NO;//self.healthData.DrinkWaterCount?YES:NO;
    }
    else if (indexPath.row == 1) {
//        cell.bottomView.backgroundColor = (remindTag-1000== indexPath.row)?([UIColor getColor:@"07DD8F"]):[UIColor getColor:@"83EEC7"];
        cell.bottomBackView.backgroundColor = [UIColor getColor:@"FC9A4B"];
        cell.dataLab.text = @"";
        cell.bgImage.hidden = NO;
    }
    else {
        cell.bottomBackView.backgroundColor = [UIColor getColor:@"07C8B8"];//6DA4FD
//        cell.bottomView.backgroundColor = (remindTag-1000== indexPath.row)?([UIColor getColor:@"6DA4FD"]):[UIColor getColor:@"B6D1FE"];
        cell.dataLab.text = self.healthData.MedicineRemind?([NSString stringWithFormat:@"%zi",self.healthData.MedicineRemind]):@"";
        cell.bgImage.hidden = self.healthData.MedicineRemind?YES:NO;
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cell.alpha = 0.8;
//    });
    return cell;
}
-(void)setHealthData:(HealthData *)healthData
{
    _healthData = healthData;
    [self.collectionView reloadData];
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(RemindDataClick:)]) {
       
        [self.delegate RemindDataClick:indexPath.row];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
