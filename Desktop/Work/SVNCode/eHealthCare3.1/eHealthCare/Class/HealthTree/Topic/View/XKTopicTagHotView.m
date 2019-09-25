//
//  XKTopicTagHotView.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicTagHotView.h"
#import "XKHotTopicTagDhildCell.h"
#import "XKHotTopicTagDhildHead.h"
#import "XKHotTopicTagDhildFoot.h"

@interface XKTopicTagHotView ()<UICollectionViewDelegate,UICollectionViewDataSource,XKHotTopicTagDhildFootDelaget>

/**
 标签集合视图
 */
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation XKTopicTagHotView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.tagCollectionView.delegate = self;
    self.tagCollectionView.dataSource = self;
    
    self.tagCollectionView.showsVerticalScrollIndicator = NO;
    self.tagCollectionView.showsHorizontalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((KScreenWidth-30-20-20-10)/3, 35);
    flow.minimumLineSpacing = 10;
    flow.minimumInteritemSpacing = 10;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.tagCollectionView setCollectionViewLayout:flow];
    
    [self.tagCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicTagDhildCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [flow setHeaderReferenceSize:CGSizeMake(KScreenWidth-30,68)];
    //设置尾部并给定大小
    [flow setFooterReferenceSize:CGSizeMake(KScreenWidth-30,143)];
    
    [self.tagCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicTagDhildHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    //#pragma mark -- 注册尾部视图
    [self.tagCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicTagDhildFoot" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    
    self.backView.clipsToBounds = YES;
    self.backView.layer.cornerRadius = 3.f;
    
}

-(void)setTypeArray:(NSArray *)typeArray{
    
    _typeArray = typeArray;
    
    [self.tagCollectionView reloadData];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.typeArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XKHotTopicTagDhildCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    XKHealthPlanModel *model = self.typeArray[indexPath.row];
    cell.model = model;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XKHotTopicTagDhildCell *cell = (XKHotTopicTagDhildCell *)[collectionView cellForItemAtIndexPath:indexPath];

    XKHealthPlanModel *model = cell.model;
    
    for (int i=0 ; i<self.typeArray.count; i++) {
        
        XKHealthPlanModel *type = self.typeArray[i];
        if (type == model) {
            
            type.isSelect = YES;
            
        }else{
            
            type.isSelect = NO;
            
        }
        
    }
    
    [collectionView reloadData];
    
    
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        XKHotTopicTagDhildHead *headerV = (XKHotTopicTagDhildHead *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"forIndexPath:indexPath];
        
        reusableView = (UICollectionReusableView *)headerV;
    }
    if (kind ==UICollectionElementKindSectionFooter){
          XKHotTopicTagDhildFoot *footerV = (XKHotTopicTagDhildFoot *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"forIndexPath:indexPath];
        footerV.delegate = self;
        reusableView = (UICollectionReusableView *)footerV;
    }
    return reusableView;
}

-(void)sureSendMsg{
    BOOL isHaveSelect = NO;
    for (XKHealthPlanModel *type in self.typeArray) {
        if (type.isSelect == YES) {
            isHaveSelect = YES;
            break;
        }
    }
    
    if (isHaveSelect == NO) {
        ShowErrorStatus(@"请选择分类" );
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(changeDataSoure:)]) {
        
        [self.delegate changeDataSoure:self.typeArray];
        
    }
    
    [self removeFromSuperview];
    
}

- (IBAction)clickBackAction:(id)sender {
    
    [self removeFromSuperview];
    
}

@end
