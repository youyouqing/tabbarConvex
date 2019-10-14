//
//  InformationCell.m
//  eHealthCare
//
//  Created by John shi on 2018/10/12.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "InformationCell.h"
#import "HomeViewController.h"
#import "InformationCollectionViewCell.h"
#import "HomeViewModel.h"
#import "XKWiKIInfoModel.h"
@interface InformationCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *backbottomView;
//@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) UICollectionViewLayout *customLayout;
@end
@implementation InformationCell
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
- (void)awakeFromNib {
    [super awakeFromNib];
    _customLayout = [[UICollectionViewLayout alloc] init]; // 自定义的布局对象
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerNib:[UINib nibWithNibName:@"InformationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //dzc todo 11.18   158   248  15 KHeight(246) (((KScreenWidth-25*2-10)/2.0)*246/158.0)*count+KHeight(45)+29+6.0+10
    flow.itemSize = CGSizeMake((KScreenWidth-25*2-10)/2, ((KScreenWidth-25*2-10)/2.0)*246/158.0+5);
    flow.minimumLineSpacing = 2;
    flow.minimumInteritemSpacing = 0;
    //    flow.sectionInset = UIEdgeInsetsMake(0, 19, 0, 19);
    //    flow.itemSize = CGSizeMake((KScreenWidth-5-18*2)/2, 246+5);
    //    flow.minimumLineSpacing = 0;
    //    flow.minimumInteritemSpacing = 5;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView.showsHorizontalScrollIndicator=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    [_collectionView setCollectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //    CAShapeLayer *maskTwoLayer = [[CAShapeLayer alloc] init];
    //    UIBezierPath *corTwoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-(12), 29) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    //    maskTwoLayer.frame = corTwoPath.bounds;
    //    maskTwoLayer.path=corTwoPath.CGPath;
    //    self.backbottomView.layer.mask=maskTwoLayer;
    [self addSubViewController];
    [self hiddenPlaceHoldImage];
//    [self.contentView bringSubviewToFront:self.backView];
    [self.contentView bringSubviewToFront:_collectionView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, KScreenWidth-12, (((KScreenWidth-25*2-10)/2.0)*246/158.0+5.0)*2+KHeight(45)+KHeight(29)+6.0-9-45) byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(3,3)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, KScreenWidth-12, (((KScreenWidth-25*2-10)/2.0)*246/158.0+5.0)*2+KHeight(45)+KHeight(29)+6.0-9-45);
    maskLayer.path = maskPath.CGPath;
    _backbottomView.layer.mask = maskLayer;
//    if (self.SelectTab) {
//        [self.planView moveToIndex:self.SelectTab];
//          [self.scrollView scrollRectToVisible:CGRectMake(self.SelectTab * CGRectGetWidth(self.scrollView.frame), 0.0, CGRectGetWidth(self.scrollView.frame),CGRectGetHeight(self.scrollView.frame)) animated:YES];
//
//    }
}
//-(UIScrollView *)scrollView
//{
//    if (!_scrollView) {
//        CGFloat width = KScreenWidth -12;
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, (((KScreenWidth-25*2-10)/2.0)*246/158.0+5)*2+ KHeight(45)+KHeight(29))];
//        _scrollView.delegate = self;
//        _scrollView.pagingEnabled = YES;
//        _scrollView.contentSize = CGSizeMake(width * self.WikiTypeList1.count,(((KScreenWidth-25*2-10)/2.0)*246/158.0+5)*2+ KHeight(45));// KScreenHeight - (PublicY) - KHeight(45)
//        self.backView.userInteractionEnabled = YES;
//        _scrollView.userInteractionEnabled = YES;
//        _scrollView.backgroundColor = [ UIColor whiteColor];
//    }
//    return _scrollView;
//}
//-(HealthPlanView *)planView
//{
//    if (!_planView) {
//        CGFloat width = KScreenWidth -12;
//
//        //头部分类视图
//        HealthPlanHead *headView = [[HealthPlanHead alloc]init];
//        headView.itemWidth = (width) / 5;
//
//        _planView = [[HealthPlanView alloc]initWithFrame:CGRectMake(0, 0, width, KHeight(45))];
//        _planView.tapAnimation = YES;
//        _planView.headView = headView;
//        _planView.isPublicFont = YES;
//    }
//    return _planView;
//
//}
#pragma mark Private Methoud
- (void)addSubViewController
{
    
//    [self.backView addSubview:self.scrollView];
//    [self.backView addSubview:self.planView];
//
//    WEAKSELF;
//    __weak typeof (_scrollView)weakScrollView = _scrollView;
//    [self.planView setItemHasBeenClickBlcok:^(NSInteger index,BOOL animation){
//        NSInteger tempIndex = [weakSelf.planView changeProgressToInteger:index];
//        [weakSelf replaceData:weakSelf.WikiTypeList1[tempIndex]];
//        weakSelf.SelectTab = tempIndex;
//
//        NSLog(@"--parentController---%@",[self parentController]);
//        HomeViewController *home = (HomeViewController *)[self parentController];
//        home.informationSelectTab = tempIndex;
//        //将两个scrollView联动起来
//        [weakScrollView scrollRectToVisible:CGRectMake(index * CGRectGetWidth(weakScrollView.frame), 0.0, CGRectGetWidth(weakScrollView.frame),CGRectGetHeight(weakScrollView.frame)) animated:animation];
//
//    }];
}
-(void)setWikiList:(NSArray *)WikiList
{
    _WikiList = WikiList;
//    [self.contentView bringSubviewToFront:self.backView];
    [self.contentView bringSubviewToFront:_collectionView];
//    [_collectionView reloadData];
    
}

#pragma mark NetWorking
-(void)setWikiTypeList1:(NSArray *)WikiTypeList1
{
    
    _WikiTypeList1 = WikiTypeList1;

//    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"WikiTypeList12"] == YES) {
//        return;
//    }
    if (_btnsView) {
        if (_btnsView.titles.count>0) {
            _btnsView.movLine.hidden = NO;
        }else
            _btnsView.movLine.hidden = YES;
    }
    //讲数据存储到沙盒
    if (_WikiTypeList1.count > 0)
    {
//        NSInteger count = (_WikiList.count+1)/2;
//
//        CGFloat width = KScreenWidth -12;
//
//        _scrollView.contentSize = CGSizeMake(width * WikiTypeList1.count,(((KScreenWidth-25*2-10)/2.0)*258/168.0+6)*count+ KHeight(45));
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < _WikiTypeList1.count; i++)
        {
            //将名称剥离出来
            WikiTypeList *mode = [_WikiTypeList1 objectAtIndex:i];
            [mArray addObject:mode.CategoryName];
            
        }
        _btnsView.titles = mArray;
         NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
         NSInteger pos = [ud integerForKey:@"posTitles"];
        // 默认位置
        _btnsView.defaultButtonPos = pos>0?pos:0;
        // 位置改变的事件
        _btnsView.onPosChange = ^(YUHoriElementButton *sender, int pos, NSString *title) {
            NSLog(@"pos: %d ,title :%@",pos,title);
            [[NSUserDefaults standardUserDefaults] setInteger:pos forKey:@"posTitles"];
            [[NSUserDefaults standardUserDefaults]synchronize];
              [self replaceData:WikiTypeList1[pos]];
            
        };
        // 刷新
        [_btnsView refresh];
      
//        [_collectionView reloadData];
        
    }
//    if (WikiTypeList1.count>1) {
//        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"WikiTypeList12"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
}


#pragma mark ScrollView Delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    if ([scrollView isKindOfClass:[UICollectionView class]]) {
//        return;
//    }
//    float offset = scrollView.contentOffset.x;
//    offset = offset/CGRectGetWidth(scrollView.frame);
//    [self.planView moveToIndex:offset];
//
//}
//
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if ([scrollView isKindOfClass:[UICollectionView class]]) {
//        return;
//    }
//    float offset = scrollView.contentOffset.x;
//    offset = offset/CGRectGetWidth(scrollView.frame);
//    [self.planView endMoveToIndex:offset];
//
//}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.WikiList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InformationCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.WikiListModel = self.WikiList[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(InformationCellClick:)]) {
        [self.delegate InformationCellClick:self.WikiList[indexPath.row]];
    }
    
}

-(void)replaceData:(WikiTypeList *)WikiTypeModel{
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    WEAKSELF
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"909" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TopicTypeID":@(WikiTypeModel.CategoryID),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(1),@"PageSize":@(4)} success:^(id json) {
        
        NSLog(@"909--------:%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            
            NSArray *arr =  [XKNewModel mj_objectArrayWithKeyValuesArray:[json objectForKey:@"Result"]];
            
            self.WikiList = [NSMutableArray arrayWithArray:arr];
            if (self.delegate && [self.delegate respondsToSelector:@selector(refreshCell:)]) {
                [self.delegate refreshCell:self.WikiList];
            }
            
            
            [weakSelf.collectionView reloadData];
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
