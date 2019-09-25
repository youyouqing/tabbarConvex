//
//  XKMedicalLookBigPhotoController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKMedicalLookBigPhotoController.h"
#import "XKMedicalLookBigPhotoCell.h"

@interface XKMedicalLookBigPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *phCollectionView;

@end

@implementation XKMedicalLookBigPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phCollectionView.delegate = self;
    self.phCollectionView.dataSource = self;
    self.view.backgroundColor = [UIColor clearColor];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(KScreenWidth, KScreenHeight);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.phCollectionView setCollectionViewLayout:flow];
    
    [self.phCollectionView registerNib:[UINib nibWithNibName:@"XKMedicalLookBigPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
     self.phCollectionView.pagingEnabled = YES;
    self.phCollectionView.showsVerticalScrollIndicator = NO;
    self.phCollectionView.showsHorizontalScrollIndicator = NO;
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.phCollectionView setContentOffset:CGPointMake(KScreenWidth*self.currentPage, 0)];
    });

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor blackColor];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor whiteColor];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.photoArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    XKMedicalLookBigPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.xkpage = indexPath.row+1;
    cell.counPage = self.photoArray.count;
    
    id photoObject = self.photoArray[indexPath.row];
    
    if ([photoObject isKindOfClass:[UIImage class]]) {
        
        cell.countLab.text = [NSString stringWithFormat:@"%li/%li",indexPath.row+1,self.photoArray.count];
        cell.iconImg.image = photoObject;
        
    }else{
        cell.model = self.photoArray[indexPath.row];
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
