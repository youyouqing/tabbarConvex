//
//  XKHotTopicChildCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKHotTopicChildCell.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import "TZAssetCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "XKHotTopicTableCollectionViewCell.h"
#import "XKTopicHotDetialController.h"
@interface XKHotTopicChildCell ()
{
    NSMutableArray *_selectedPhotos;
     NSMutableArray *selectedPhotosSize;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PCollectionBottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PCollectionHeightCons;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
/**
 头像视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

/**
 用户姓名标签
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

/**
 点赞按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *priseBtn;

/**
 话题内容标签
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

/**
 话题时间标签
 */
@property (weak, nonatomic) IBOutlet UILabel *timaLab;

/**
话题评论人数标签
 */
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UIButton *ReplyBtn;

/**
 头像视图距离上部的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTopCons;

@end

@implementation XKHotTopicChildCell

/**
 重写属性set方法
 */
-(void)setModel:(XKTopicModel *)model{
    
    _model = model;
    
    if (_model.HeadImg.length > 0) {
       [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.HeadImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    }else{
        self.iconImg.image = [UIImage imageNamed:@"defaultHead"];
    }
   
    NSString *at = [NSString stringWithFormat:@"%@",_model.TopicContent];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:at];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [at length])];
    [self.contentLab setAttributedText:attri];

    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",model.CreateTime]] withFormat:@"yyyy-MM-dd"];
    NSLog(@"---timeStr:%@",timeStr);
    self.timaLab.text = timeStr;
    
    self.commentLab.text = [NSString stringWithFormat:@"%li人已回答",_model.ReplyScount];
    
    [self.priseBtn setTitle:[NSString stringWithFormat:@" %li",_model.PraiseScount] forState:UIControlStateNormal];
      [self.ReplyBtn setTitle:[NSString stringWithFormat:@" %li",_model.ReplyScount] forState:UIControlStateNormal];
    self.nameLab.text = [NSString stringWithFormat:@"#%@#",model.TopicTypeName];
    [self.priseBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    if (_model.IsPraise == 1) { //已经点赞
        [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];
    }else{//未点赞
       [self.priseBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal]; 
    }
    
    
    
    
    [_selectedPhotos removeAllObjects];
     [selectedPhotosSize removeAllObjects];
    if (_model.PublishFlag == 2) {
        [_selectedPhotos addObject:_model.TopicVideoUrl];
        self.PCollectionHeightCons.constant = _itemWH*73/109.0;
        self.PCollectionBottomCons.constant = 10.f;

        
        
    }else if (_model.PublishFlag == 1)
    {
        NSArray *imageArr =  [_model.TopicImgUrl componentsSeparatedByString:@"|"];
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
            self.PCollectionHeightCons.constant = _itemWH*73/109.0;
            self.PCollectionBottomCons.constant = 10.f;

        }else
        {
            self.PCollectionBottomCons.constant = 0.f;

            self.PCollectionHeightCons.constant = 0;

        }
        
       
    }else
    {
        self.PCollectionBottomCons.constant = 0.f;

        self.PCollectionHeightCons.constant = 0;
    }
    [self layoutIfNeeded];
     [self.photoCollectionView reloadData];
  
   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];;

    self.iconImg.layer.cornerRadius = 12.5;
    self.iconImg.layer.masksToBounds = YES;
    self.nameLab.textColor = kMainColor;
    self.nameLab.font = [UIFont systemFontOfSize:(12)];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self configCollectionView];
}
- (IBAction)pushPageAction:(id)sender {
    
    XKTopicHotDetialController *topic = [[XKTopicHotDetialController alloc]init];
    
    topic.modelID = _model.TopicID;
    topic.hidesBottomBarWhenPushed = YES;
    [[self parentController].navigationController pushViewController:topic animated:YES];
    
}

/**
 点赞按钮的点击事件
 */
- (IBAction)priseAction:(id)sender {
    
    if (_model.IsPraise == 1) {//已经点赞  返回
        return;
    }else{//未点赞
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        //获取首页健康计划、热门话题数据
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"904" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"ReplyID":@(self.model.TopicID),@"TypeID":@(1)} success:^(id json) {

            NSLog(@"%@",json);
            [[XKLoadingView shareLoadingView] hideLoding];
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                 ShowSuccessStatus(@"点赞成功");
                //点赞成功 更换点赞按钮图片
                [self.priseBtn setImage:[UIImage imageNamed:@"icon_huati_THUMBSUP"] forState:UIControlStateNormal];

                //1.点赞数量加一
                self.model.PraiseScount++;
                [self.priseBtn setTitle:[NSString stringWithFormat:@"%li",self.model.PraiseScount] forState:UIControlStateNormal];

                //2.更换是否点赞的参数
                self.model.IsPraise = 1;

                if ([self.delegate respondsToSelector:@selector(changeTopicDataSoure:)]) {
                    [self.delegate changeTopicDataSoure:self.model];
                }

            }else{
                ShowErrorStatus(nil );
            }


        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
            NSLog(@"%@",error);

        }];

    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 25;
    _itemWH = (KScreenWidth - (2 * _margin)-4) / 3;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH*73/109.0);//CGSizeMake(_itemWH, _itemWH*213/334.0);
    _layout.minimumInteritemSpacing = 2;
    _layout.minimumLineSpacing = 2;
   
    _photoCollectionView.alwaysBounceVertical = YES;
//    _photoCollectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _photoCollectionView.dataSource = self;
    _photoCollectionView.delegate = self;
    
     _photoCollectionView.collectionViewLayout = _layout;
  
    _photoCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
      [_photoCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicTableCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XKHotTopicTableCollectionViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XKHotTopicTableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKHotTopicTableCollectionViewCell" forIndexPath:indexPath];
    if (_model.PublishFlag == 2) {
        
    }else if (_model.PublishFlag == 1)
    {
        [cell.backImageView sd_setImageWithURL:[NSURL URLWithString: _selectedPhotos[indexPath.item]] placeholderImage:[UIImage imageNamed:@"iv_huati_suolvetu"]];
        
    }else
    {
        
        
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(jumpTopXKHotTopicChildCellBigPhoto:sizeArr:withPage:publishFlag:)]) {
        [self.delegate jumpTopXKHotTopicChildCellBigPhoto:_selectedPhotos sizeArr:selectedPhotosSize withPage:indexPath.row publishFlag:_model.PublishFlag];
    }
    
}


@end