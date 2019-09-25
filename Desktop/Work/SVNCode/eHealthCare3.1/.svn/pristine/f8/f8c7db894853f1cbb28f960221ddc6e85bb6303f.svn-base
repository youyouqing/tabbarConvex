//
//  XKHotTopicTableViewCell.m
//  eHealthCare
//
//  Created by John shi on 2018/11/2.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "XKHotTopicTableViewCell.h"
#import "TZImagePickerController.h"
#import "TZAssetCell.h"
#import "TZTestCell.h"
#import "XKHotTopicTableCollectionViewCell.h"
@interface XKHotTopicTableViewCell ()
{
    NSMutableArray *_selectedPhotos;
     BOOL _isSelectOriginalPhoto;
     NSMutableArray *selectedPhotosSize;
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PCollectionBottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PCollectionHeightCons;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
//是否是地方的标示
@property (strong, nonatomic) CLLocation *location;
/**
 是否能访问gif图片的设置
 */
@property (nonatomic,assign) BOOL allowPickingGifSwitch;
/**
 是否允许内部拍照
 */
@property (nonatomic,assign) BOOL showTakePhotoBtnSwitch;

/**
 是否允许图片裁剪
 */
@property (nonatomic,assign) BOOL allowCropSwitch;



@property (weak, nonatomic) IBOutlet UILabel *typeLab;
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

/**
 头像视图距离上部的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTopCons;

@end

@implementation XKHotTopicTableViewCell


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
    self.typeLab.text = [NSString stringWithFormat:@"#%@#",_model.TopicTypeName];
    NSString *at = [NSString stringWithFormat:@"%@",_model.TopicContent];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:at];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6.0];//调整行间距
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [at length])];
    [self.contentLab setAttributedText:attri];
    
    Dateformat *dateFor = [[Dateformat alloc] init];
    
    NSString *timeStr=[dateFor DateFormatWithDate:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%li",_model.CreateTime]] withFormat:@"yyyy-MM-dd"];
    self.timaLab.text = timeStr;
    
    self.commentLab.text = [NSString stringWithFormat:@"%li人已回答",_model.ReplyScount];
    
    [self.priseBtn setTitle:[NSString stringWithFormat:@" %li",_model.PraiseScount] forState:UIControlStateNormal];
    
    self.nameLab.text = _model.NickName;
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
//
//        _margin = 25;
//        _itemWH = (KScreenWidth - (2 * _margin)-4);
//        _layout.itemSize = CGSizeMake(_itemWH, _itemWH*213/334.0);
//        _photoCollectionView.collectionViewLayout = _layout;
        
    }else if (_model.PublishFlag == 1)
    {
        NSArray *imageArr =  [_model.TopicImgUrl componentsSeparatedByString:@"|"];
//        NSMutableArray *tempImageArr = [NSMutableArray arrayWithCapacity:0];
//        for (NSString *imagStr in imageArr) {
//            UIImage *imageName =  [self getImageFromURL:imagStr];
//            [_selectedPhotos addObject:imageName];
//        }
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
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
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
                
                if ([self.delegate respondsToSelector:@selector(changeHotTopicChildDataSoure:)]) {
                    [self.delegate changeHotTopicChildDataSoure:self.model];
                }
                
            }else{
              
            }
            
            
        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] errorloadingText:@"点赞失败"];
          
            
        }];
        
    }
    
}

-(UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    CGSize size=image.size;
    
    float a = rect.size.width/rect.size.height;
    float X = 0;
    float Y = 0;
    float W = 0;
    float H = 0;
    
    if (size.width>size.height) {
        
        H= size.height;
        W= H*a;
        Y=0;
        X=  (size.width - W)/2;
        
        if ((size.width - size.height*a)/2<0) {
            
            W = size.width;
            H = size.width/a;
            Y= (size.height-H)/2;
            X=0;
        }
        
    }else{
        
        W= size.width;
        H= W/a;
        X=0;
        Y=  (size.height - H)/2;
        
        if ((size.height - size.width/a)/2<0) {
            
            H= size.height;
            W = size.height*a;
            X= (size.width-W)/2;
            Y=0;
        }
        
    }
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    //    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect dianRect = CGRectMake(X, Y, W, H);//CGRectMake(x, y, w, h);

    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];

    CGImageRelease(sourceImageRef);


    return newImage;
}
#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return _selectedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XKHotTopicTableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKHotTopicTableCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    if (_model.PublishFlag == 2) {
        cell.backImageView.image = [self getScreenShotImageFromVideoPath:_selectedPhotos[indexPath.item]];
         return cell;
    }else if (_model.PublishFlag == 1)
    {
//        WEAKSELF
//        [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:_selectedPhotos[indexPath.item]] placeholderImage:[UIImage imageNamed:@"iv_huati_suolvetu"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//            cell.backImageView.image=  [weakSelf ct_imageFromImage:image inRect:cell.backImageView.frame];
//
//        }];
        [cell.backImageView sd_setImageWithURL:_selectedPhotos[indexPath.row] placeholderImage:[UIImage imageNamed:@"iv_huati_suolvetu"] ];
//        cell.backImageView.image = _selectedPhotos[indexPath.row];//[self ct_imageFromImage:_selectedPhotos[indexPath.row] inRect:cell.backImageView.frame];
         return cell;
       
    }
    return cell;
}
- (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL URLWithString:filePath];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSMutableArray *tempImageArr = [NSMutableArray arrayWithCapacity:0];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//            for (NSString *imagStr in _selectedPhotos) {
////                UIImage *imageName =  [self getImageFromURL:imagStr];
////                [tempImageArr addObject:imageName];
//
//
//                NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imagStr]];
//                UIImage *image = [[UIImage alloc]initWithData:data];
//
//                if (data != nil) {
//                    [tempImageArr addObject:image];
//
//                }
//
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //在这里做UI操作(UI操作都要放在主线程中执行)
    if ([self.delegate respondsToSelector:@selector(jumpTopTopicBigPhoto:sizeArr: withPage:publishFlag:)]) {
                    [self.delegate jumpTopTopicBigPhoto:_selectedPhotos sizeArr:selectedPhotosSize  withPage:indexPath.row publishFlag:_model.PublishFlag];
                }

//            });
//
//    });
//     NSMutableArray *tempImageArr = [NSMutableArray arrayWithCapacity:0];
//     for (NSString *imagStr in _selectedPhotos) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            // 处理耗时操作的代码块...
//            UIImage *imageName =  [self getImageFromURL:imagStr];
//            [tempImageArr addObject:imageName];
//            //通知主线程刷新
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //回调或者说是通知主线程刷新，
//                if ([self.delegate respondsToSelector:@selector(jumpTopTopicBigPhoto:withPage:publishFlag:)]) {
//                    [self.delegate jumpTopTopicBigPhoto:tempImageArr withPage:indexPath.row publishFlag:_model.PublishFlag];
//                }
//            });
//
//        });

}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeLab.textColor = kMainColor;
    self.typeLab.font = [UIFont systemFontOfSize:(12)];
    self.iconImg.layer.cornerRadius = 12.5;
    self.iconImg.layer.masksToBounds = YES;
  
    _selectedPhotos = [NSMutableArray array];
    selectedPhotosSize = [NSMutableArray array];
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 25;
    _itemWH = (KScreenWidth - (2 * _margin)-4) / 3;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH*73/109.0);
    _photoCollectionView.dataSource = self;
    _photoCollectionView.delegate = self;
    _layout.minimumInteritemSpacing = 2;
    _layout.minimumLineSpacing = 2;
    _photoCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _photoCollectionView.collectionViewLayout = _layout;
    [_photoCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicTableCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XKHotTopicTableCollectionViewCell"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
