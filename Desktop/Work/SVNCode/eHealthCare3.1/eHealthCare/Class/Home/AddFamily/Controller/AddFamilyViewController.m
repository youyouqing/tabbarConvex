//
//  AddFamilyViewController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/16.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AddFamilyViewController.h"
#import "AddFamilyCollectionReusableView.h"
#import "AddFamilyCollectionViewCell.h"
#import "PersonArchiveTextPutView.h"
#import "AddFamilyDetailController.h"
#import "AddFamilyViewModel.h"
#import "DictionaryMsg.h"
@interface AddFamilyViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property(strong,nonatomic) PersonArchiveTextPutView *popView;
@property (nonatomic, strong)UICollectionViewFlowLayout *customLayout;
@property (nonatomic, strong)NSMutableArray *DictionaryMsgArr;
@end

@implementation AddFamilyViewController
// 注意const的位置
static NSString *const collectionCellId = @"cellId";
static NSString *const collectionfooterId = @"AddFamilyCollectionReusableView";
#pragma mark NetWorking
- (void)addFamilyResultWithNetWorking
{
    NSDictionary *dic = @{@"Token":[UserInfoTool getLoginInfo].Token,
                          @"MemberID":@([UserInfoTool getLoginInfo].MemberID)};
      [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [AddFamilyViewModel addFamilyPersonWithParmas:dic FinishedBlock:^(ResponseObject *response) {
           [[XKLoadingView shareLoadingView] hideLoding];
        if (response.code == CodeTypeSucceed) {
            
            self.DictionaryMsgArr = (NSMutableArray *)[DictionaryMsg mj_objectArrayWithKeyValuesArray:response.Result];
            
            NSLog(@"317%@",self.DictionaryMsgArr);
            [self.collectionView reloadData];
        }else
        {
            ShowErrorStatus(response.msg);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"添加家人";
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.titleLab.textColor = kMainTitleColor;
    self.view.backgroundColor = kbackGroundGrayColor;
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self loadCollectionView];
    self.DictionaryMsgArr = [NSMutableArray arrayWithCapacity:0];
    [self addFamilyResultWithNetWorking];
}
- (void)loadCollectionView
{// UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    _customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
//    _customLayout.itemSize = CGSizeMake(((KScreenWidth-6)-12)/3, 50);
    _customLayout.itemSize = CGSizeMake((KScreenWidth-6)/3, 50);
    _customLayout.minimumLineSpacing = 0;
    _customLayout.minimumInteritemSpacing = 0;
    _customLayout.footerReferenceSize = CGSizeMake((KScreenWidth-12), 50);
  
    _customLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(3, PublicY+3, KScreenWidth-6, CGRectGetHeight(self.view.frame)-(PublicY)) collectionViewLayout:_customLayout];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, PublicY, KScreenWidth, CGRectGetHeight(self.view.frame)-(PublicY)) collectionViewLayout:_customLayout];
    _collectionView.backgroundColor = kbackGroundGrayColor;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerNib:[UINib nibWithNibName:@"AddFamilyCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:collectionCellId];
  
    [_collectionView registerNib:[UINib nibWithNibName:@"AddFamilyCollectionReusableView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionfooterId];
    
  
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.DictionaryMsgArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddFamilyCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    DictionaryMsg *dicObject = self.DictionaryMsgArr[indexPath.row];
    cell.relationLab.text = dicObject.DictionaryName;
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(3, 3, 3, 3);//{top, left, bottom, right};
}
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        return nil;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        AddFamilyCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionfooterId forIndexPath:indexPath];
        footerView.delegate = self;
        return footerView;
    } else {
        return [[UICollectionReusableView alloc]init];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    AddFamilyDetailController *add = [[AddFamilyDetailController alloc]initWithType:pageTypeNormal];
    add.model = self.DictionaryMsgArr[indexPath.row];
    [self.navigationController pushViewController:add animated:YES];
    
}
-(void)creatUI
{
    //5s:300 6:330
    self.popView = [[[NSBundle mainBundle]loadNibNamed:@"PersonArchiveTextPutView" owner:self options:nil]  firstObject];
    self.popView.left = 0;
    self.popView.top=0;
    self.popView.popType = 0;
    self.popView.width=KScreenWidth;
    self.popView.height=KScreenHeight;
    self.popView.delegate = self;
    [UIView animateWithDuration:.2 animations:^{
        self.popView.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                               CGAffineTransformMakeScale(1.0f, 1.0f));
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    //    [self.view addSubview:self.popBottomView];
    
}

#pragma mark   自定义添加数据
-(void)CustomActionTools;
{
    [self creatUI];
    
}
- (void)PersonArchiveTextPutViewCompleteClick:(NSString *)dataStr;
{
    if (dataStr.length>0) {
        DictionaryMsg *mod = [[DictionaryMsg alloc]init];
        mod.DictionaryName = dataStr;
        mod.DictionaryID = 1010;
        [self.DictionaryMsgArr addObject:mod];
        [self.collectionView reloadData];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
