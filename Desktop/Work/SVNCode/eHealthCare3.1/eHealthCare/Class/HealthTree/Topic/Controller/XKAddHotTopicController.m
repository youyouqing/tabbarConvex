//
//  XKAddHotTopicController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKAddHotTopicController.h"
#import "XKTopicTagHotView.h"
#import "TZImagePickerController.h"
#import "TZAssetCell.h"
#import "TZTestCell.h"
#import "XKMedicalLookBigPhotoController.h"
#import "TZImagePreviewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
@interface XKAddHotTopicController ()<XKTopicTagHotViewDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger AddHotTopicType;
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightCons;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
//图片视图控制器对象
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
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


@property (nonatomic,assign) BOOL allowPickingMuitlpleVideo;
/**
 是否允许图片裁剪
 */
@property (nonatomic,assign) BOOL allowCropSwitch;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

/**
 添加标签视图按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addTagBtn;

/**
 发表视图按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *topicPublishBtn;

/**
 标签视图
 */
@property (nonatomic,strong) XKTopicTagHotView *tagView;

/**
 文本视图
 */
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

/**
 字数限制标签
 */
@property (weak, nonatomic) IBOutlet UILabel *fontLimtLab;

@end

@implementation XKAddHotTopicController

-(XKTopicTagHotView *)tagView{
    
    if (!_tagView) {
        
        _tagView = [[[NSBundle mainBundle] loadNibNamed:@"XKTopicTagHotView" owner:self options:nil] firstObject];
        _tagView.x = 0;
        _tagView.y = 0;
        _tagView.width = KScreenWidth;
        _tagView.delegate = self;
        _tagView.height = KScreenHeight;
        
    }
    
    return _tagView;
}

/**
 添加标签
 */
- (IBAction)addTagAction:(UIButton *)sender {
    
    NSLog(@"添加话题标签");
    [self.txtView resignFirstResponder];
    [[UIApplication sharedApplication].delegate.window addSubview:self.tagView];
    
    if ([sender.titleLabel.text isEqualToString:@"添加标签"]) {
        for (XKHealthPlanModel *model in self.typeArray) {
            model.isSelect = NO;
        }
        self.tagView.typeArray = self.typeArray;
    }else{
        self.tagView.typeArray = self.typeArray;
    }
    
}

/**
 发表按钮
 */
- (IBAction)publicAction:(id)sender {
    NSLog(@"发表");
    NSInteger type = -1;
    AddHotTopicType = -1;
    for (XKHealthPlanModel *model in self.typeArray) {
        if (model.isSelect) {
            type = model.TypeID;
            NSLog(@"发表----#######-------%li",type);
            break;
        }
    }
    
    if (type == -1) {
        [self showAlert:@"请选择话题分类"];
        return;
    }
    if (self.txtView.text.length==0) {
        [self showAlert:@"请输入话题内容"];
        return;
    }
    //   判定输入框不为空格以及空
    NSString *textField=[self.txtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([textField length] == 0) {
        
       [self showAlert:@"请输入话题内容"];
        
        return ;
        
    }
      dispatch_group_t downloadGroup = dispatch_group_create();
        static NSString *TopicImgUrlTempStr = @"";
        BOOL isVideo = NO;
       [[XKLoadingView shareLoadingView]showLoadingText:nil];

        for (PHAsset *imagePH in _selectedAssets) {
             dispatch_group_enter(downloadGroup);
           
            isVideo = imagePH.mediaType == PHAssetMediaTypeVideo;
            [[TZImageManager manager] requestImageDataForAsset:imagePH completion:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                NSString *str=[imageData base64EncodedStringWithOptions:0];
                NSMutableString *mstr=[[NSMutableString alloc]initWithString:str];
                NSString *ss=[mstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [ProtosomaticHttpTool protosomaticPostWithURLString:@"947" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"HeadBinary":ss} success:^(id json) {
                        
                        dispatch_group_leave(downloadGroup);
                        //                    [[XKLoadingView shareLoadingView]hideLoding];
                        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                            if (TopicImgUrlTempStr.length<=0) {
                                //                             TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@", json[@"Result"]];
                                TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@;%li,%li", json[@"Result"],imagePH.pixelWidth,imagePH.pixelHeight];
                                
                            }else
                                //                        TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@|%@", TopicImgUrlTempStr,json[@"Result"]];
                                
                                TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@|%@;%li,%li", TopicImgUrlTempStr,json[@"Result"],imagePH.pixelWidth,imagePH.pixelHeight];
                            
                            NSLog(@"--947--%@---%@",json,TopicImgUrlTempStr);
                        }else{
                            
                        }
                        
                    } failure:^(id error) {
                        
                        
                        
                    }];
                });
            } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                NSLog(@"--info--%@",info);
            }];
           
               


        }
    AddHotTopicType = type;
    WEAKSELF
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
       
            NSLog(@"--907----%@",TopicImgUrlTempStr);
//            [[XKLoadingView shareLoadingView]showLoadingText:nil];
            NSDictionary *dicT = [NSDictionary dictionary];
            if (isVideo == YES) {
                dicT = @{@"Token":[UserInfoTool getLoginInfo].Token,@"TopicType":@(type),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TopicContent":self.txtView.text,@"TopicImgUrl":@"",@"TopicVideoUrl":TopicImgUrlTempStr};
            }else
                dicT = @{@"Token":[UserInfoTool getLoginInfo].Token,@"TopicType":@(type),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TopicContent":self.txtView.text,@"TopicImgUrl":TopicImgUrlTempStr,@"TopicVideoUrl":@""};
            [ProtosomaticHttpTool protosomaticPostWithURLString:@"907" parameters:dicT success:^(id json) {
                
                NSLog(@"907-----%@",json);
                if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                    
                    [[XKLoadingView shareLoadingView] hideLoding];
                    //发表健康话题
                    XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
                    [tools validationAndAddScore:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(6)} withAdd:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(6)} isPopView:YES];
                    
                    ShowSuccessStatus(@"发表成功");
                    [self.txtView resignFirstResponder];
                    self.txtView.text = @"";
                    [weakSelf.selectedPhotos removeAllObjects];
                    [weakSelf.selectedAssets removeAllObjects];
                    TopicImgUrlTempStr = @"";
                    
                    if (_didRefreshPageBlock) {
                        weakSelf.didRefreshPageBlock(YES,AddHotTopicType);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    [[XKLoadingView shareLoadingView]errorloadingText:@"发表失败"];
                    
                }
                
            } failure:^(id error) {
                
                NSLog(@"%@",error);
                [[XKLoadingView shareLoadingView]errorloadingText:@"发表失败"];
                
            }];
            
       
    });
   

}

-(void)showAlert:(NSString *)str{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

/**
 文本框的协议方法
 */
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length >= 400) {
        textView.text = [textView.text substringToIndex:400];
    }
    self.fontLimtLab.text = [NSString stringWithFormat:@"%li/400",textView.text.length];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topCons.constant = (PublicY);
    [self.addTagBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    self.addTagBtn.layer.borderColor = kMainColor.CGColor;
    self.addTagBtn.layer.borderWidth = 1;
    
    self.topicPublishBtn.backgroundColor = kMainColor;
    [self.topicPublishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.topicPublishBtn.layer.cornerRadius = 22.5;
    self.topicPublishBtn.layer.masksToBounds = YES;
    
    self.deleteBtn.hidden = YES;
    
    self.tagView.typeArray = self.typeArray;
    
    self.txtView.delegate = self;
    
    self.txtView.inputAccessoryView = [[UIView alloc]initWithFrame:CGRectZero];
    
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 1;
    _itemWH = (KScreenWidth-30-(2*_margin)) / 3 - _margin;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = _margin;
    _layout.minimumLineSpacing = _margin;
    self.collectionHeightCons.constant = _itemWH;
    self.allowCropSwitch = YES;
    self.showTakePhotoBtnSwitch = YES;
    [self.photoCollectionView setCollectionViewLayout:_layout];
    [self configCollectionView];
    AddHotTopicType = -1;
}
/**
 删除标签按钮的操作
 */
- (IBAction)deleteAction:(id)sender {
    
    for (XKHealthPlanModel *model in self.typeArray) {
        model.isSelect = NO;
    }
    
    self.tagView.typeArray = self.typeArray;
    
    [self.addTagBtn setTitle:@"添加标签" forState:UIControlStateNormal];
    
    self.deleteBtn.hidden = YES;
    
}

-(void)changeDataSoure:(NSArray *)array{
    
    self.typeArray = array;
    
    for (XKHealthPlanModel *model in self.typeArray) {
        if (model.isSelect == YES) {
            [self.addTagBtn setTitle:model.TypeName forState:UIControlStateNormal];
             self.deleteBtn.hidden = NO;
            break;
        }
    }
    
}

/**
 点击按钮开始编辑
 */
- (IBAction)editAction:(id)sender {
    
    [self.txtView becomeFirstResponder];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
replacementText:(NSString *)text
{
    //如果为回车则将键盘收起
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor =  self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor =  self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

- (void)configCollectionView {
    _photoCollectionView.alwaysBounceVertical = YES;
    _photoCollectionView.contentInset = UIEdgeInsetsMake(1, 1, 1, 1);
    _photoCollectionView.dataSource = self;
    _photoCollectionView.delegate = self;
    _photoCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_photoCollectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}
#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count >= 3) {
    return _selectedPhotos.count;
    }
    if (!self.allowPickingMuitlpleVideo) {
        for (PHAsset *asset in _selectedAssets) {
            if (asset.mediaType == PHAssetMediaTypeVideo) {
                return _selectedPhotos.count;
            }
        }
    }
     return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.item == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"iv__huati_adding-1"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
        
        
//        id photo = _selectedPhotos[indexPath.item];
//        if ([photo isKindOfClass:[UIImage class]]) {
//            cell.imageView.image = photo;
//        } else if ([photo isKindOfClass:[NSURL class]]) {
//            [self configImageView:cell.imageView URL:(NSURL *)photo completion:nil];
//        } else if ([photo isKindOfClass:[PHAsset class]]) {
//            [[TZImageManager manager] getPhotoWithAsset:photo photoWidth:100 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
//                cell.imageView.image = photo;
//            }];
//        }
//        cell.asset = _selectedPhotos[indexPath.item];
//        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _selectedPhotos.count) {
        

            [self pushTZImagePickerController];
        
    } else { // preview photos or video / 预览照片或者视频
        PHAsset *asset = _selectedAssets[indexPath.item];
        BOOL isVideo = NO;
        isVideo = asset.mediaType == PHAssetMediaTypeVideo;
        if ([[asset valueForKey:@"filename"] containsString:@"GIF"] && self.allowPickingGifSwitch&& !self.allowPickingMuitlpleVideo) {
            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (isVideo && !self.allowPickingMuitlpleVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.item];
            imagePickerVc.maxImagesCount = 3;
            //            imagePickerVc.allowPickingGif = self.allowPickingGifSwitch.isOn;
            imagePickerVc.allowPickingOriginalPhoto = YES; //设置是否能发送原图
            imagePickerVc.allowPickingMultipleVideo = NO;
            //            imagePickerVc.showSelectedIndex = self.showSelectedIndexSwitch.isOn;
            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
                self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
                self->_isSelectOriginalPhoto = isSelectOriginalPhoto;
                [self->_photoCollectionView reloadData];
                self->_photoCollectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (self->_margin + self->_itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];



        }
        
        
//        TZImagePreviewController *previewVc = [[TZImagePreviewController alloc] initWithPhotos:self.selectedPhotos currentIndex:indexPath.row tzImagePickerVc:[self createTZImagePickerController]];
//        [previewVc setBackButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
//            self.isSelectOriginalPhoto = isSelectOriginalPhoto;
//            NSLog(@"预览页 返回 isSelectOriginalPhoto:%d", isSelectOriginalPhoto);
//        }];
//        [previewVc setSetImageWithURLBlock:^(NSURL *URL, UIImageView *imageView, void (^completion)(void)) {
//            [self configImageView:imageView URL:URL completion:completion];
//        }];
//        [previewVc setDoneButtonClickBlock:^(NSArray *photos, BOOL isSelectOriginalPhoto) {
//            self.isSelectOriginalPhoto = isSelectOriginalPhoto;
//            self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
//            NSLog(@"预览页 完成 isSelectOriginalPhoto:%d photos.count:%zd", isSelectOriginalPhoto, photos.count);
//            [self.photoCollectionView reloadData];
//        }];
//        [self presentViewController:previewVc animated:YES completion:nil];
    }
}
- (void)configImageView:(UIImageView *)imageView URL:(NSURL *)URL completion:(void (^)(void))completion{
    if ([URL.absoluteString.lowercaseString hasSuffix:@"gif"]) {
        // 先显示静态图占位
        [[SDWebImageManager sharedManager] loadImageWithURL:URL options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (!imageView.image) {
                imageView.image = image;
            }
        }];
        // 动图加载完再覆盖掉
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            imageView.image = [UIImage sd_animatedGIFWithData:data];
            if (completion) {
                completion();
            }
        }];
    } else {
        [imageView sd_setImageWithURL:URL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (completion) {
                completion();
            }
        }];
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    //    if (self.maxCountTF.text.integerValue <= 0) { //判断是否还可以插入图片
    //        return;
    //    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;

#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;

    //    if (self.maxCountTF.text.integerValue > 1) {
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];

    // imagePickerVc.photoWidth = 1000;

    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    /*
     [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
     cell.contentView.clipsToBounds = YES;
     cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
     }];
     */

    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto =YES;
    imagePickerVc.allowPickingGif = self.allowPickingGifSwitch;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频

    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;

    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;

    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;

    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
        NSInteger left = 30;
        NSInteger widthHeight = self.view.width - 2 * left;
        NSInteger top = (self.view.height - widthHeight) / 2;
        imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
//     设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/

    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */

    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;

    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;

    //    // 自定义gif播放方案
    //    [[TZImagePickerConfig sharedInstance] setGifImagePlayBlock:^(TZPhotoPreviewView *view, UIImageView *imageView, NSData *gifData, NSDictionary *info) {
    //        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
    //        FLAnimatedImageView *animatedImageView;
    //        for (UIView *subview in imageView.subviews) {
    //            if ([subview isKindOfClass:[FLAnimatedImageView class]]) {
    //                animatedImageView = (FLAnimatedImageView *)subview;
    //                animatedImageView.frame = imageView.bounds;
    //                animatedImageView.animatedImage = nil;
    //            }
    //        }
    //        if (!animatedImageView) {
    //            animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:imageView.bounds];
    //            animatedImageView.runLoopMode = NSDefaultRunLoopMode;
    //            [imageView addSubview:animatedImageView];
    //        }
    //        animatedImageView.animatedImage = animatedImage;
    //    }];

    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";

    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];

#pragma mark - 到这里为止

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

    }];

    [self  presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - TZImagePickerController

- (TZImagePickerController *)createTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.videoMaximumDuration = 10;
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.allowPickingMultipleVideo = NO;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    imagePickerVc.showSelectBtn = NO;
#pragma mark - 到这里为止
    return imagePickerVc;
}
#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        //        if (self.showTakeVideoBtnSwitch.isOn) {
        [mediaTypes addObject:(NSString *)kUTTypeMovie];
        //        }
        if (self.showTakePhotoBtnSwitch) {
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];

    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                if (self.allowCropSwitch) { // 允许裁剪,去裁剪
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                    }];
                    imagePicker.allowPickingImage = YES;
                    imagePicker.needCircleCrop = NO;
                    imagePicker.circleCropRadius = 100;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                } else {
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                }
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_photoCollectionView reloadData];

    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
//
#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// You can also set autoDismiss to NO, then the picker don't dismiss itself.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_photoCollectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    
    /*
     // 3. 获取原图的示例，这样一次性获取很可能会导致内存飙升，建议获取1-2张，消费和释放掉，再获取剩下的
     __block NSMutableArray *originalPhotos = [NSMutableArray array];
     __block NSInteger finishCount = 0;
     for (NSInteger i = 0; i < assets.count; i++) {
     [originalPhotos addObject:@1];
     }
     for (NSInteger i = 0; i < assets.count; i++) {
     PHAsset *asset = assets[i];
     PHImageRequestID requestId = [[TZImageManager manager] getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
     finishCount += 1;
     [originalPhotos replaceObjectAtIndex:i withObject:photo];
     if (finishCount >= assets.count) {
     NSLog(@"All finished.");
     }
     }];
     NSLog(@"requestId: %d", requestId);
     }
     */
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    [_photoCollectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_photoCollectionView reloadData];
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    /*
     if ([albumName isEqualToString:@"个人收藏"]) {
     return NO;
     }
     if ([albumName isEqualToString:@"视频"]) {
     return NO;
     }*/
    return YES;
}

// Decide asset show or not't
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    /*
     switch (asset.mediaType) {
     case PHAssetMediaTypeVideo: {
     // 视频时长
     // NSTimeInterval duration = phAsset.duration;
     return NO;
     } break;
     case PHAssetMediaTypeImage: {
     // 图片尺寸
     if (phAsset.pixelWidth > 3000 || phAsset.pixelHeight > 3000) {
     // return NO;
     }
     return YES;
     } break;
     case PHAssetMediaTypeAudio:
     return NO;
     break;
     case PHAssetMediaTypeUnknown:
     return NO;
     break;
     default: break;
     }
     */
    return YES;
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.photoCollectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
        [self.photoCollectionView reloadData];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_photoCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_photoCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_photoCollectionView reloadData];
    }];
}



#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
        // NSLog(@"图片名字:%@",fileName);
    }
}
@end