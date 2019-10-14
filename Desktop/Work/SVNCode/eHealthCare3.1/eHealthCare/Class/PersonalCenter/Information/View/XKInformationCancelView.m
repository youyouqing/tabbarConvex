//
//  XKInformationCancelView.m
//  eHealthCare
//
//  Created by xiekang on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKInformationCancelView.h"
#import "TZImagePickerController.h"
#import "TZAssetCell.h"
#import "TZTestCell.h"
@interface XKInformationCancelView ()<UITextViewDelegate>
{
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (weak, nonatomic) IBOutlet UIView *backSelectView;

//图片视图控制器对象
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
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
@end
@implementation XKInformationCancelView
-(void)awakeFromNib
{

    [super awakeFromNib];
    self.myTextView.delegate = self;
    //建议内容的背景设置
    self.myTextView.clipsToBounds = YES;
    self.myTextView.layer.borderColor = [UIColor getColor:@"f2f2f2"].CGColor;
    self.myTextView.layer.borderWidth = 1.0;
    self.myTextView.delegate = self;
    self.sureBtn.enabled = NO;
    self.sureBtn.clipsToBounds = YES;
    self.sureBtn.layer.cornerRadius = self.sureBtn.height/2.0;
    self.textViewLal.text = @"我也说一句～";
    
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 1;
    _itemWH = (KScreenWidth-30-(2*_margin)) / 3 - _margin;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = _margin;
    _layout.minimumLineSpacing = _margin;
 
    self.showTakePhotoBtnSwitch = YES;
    [self.pCollectionView setCollectionViewLayout:_layout];
    [self configCollectionView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPopMytextViewAction)];
   
     [self.backSelectView addGestureRecognizer:tap];

}
-(void)clickPopMytextViewAction
{
    [self.myTextView becomeFirstResponder];
    
}
/*防止键盘下落后，回复ABC消失*/
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    self.textViewLal.text = @"我也说一句～";
//    return YES;
//}
-(void)setReplyerMemberID:(NSInteger)ReplyerMemberID
{

    _ReplyerMemberID = ReplyerMemberID;
    
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    if (textView == self.myTextView) {
        
//        if (self.delegate && [self.delegate respondsToSelector:@selector(beginTextViewInputData:)]) {
//            [self.delegate beginTextViewInputData:textView];
//        }
        if (self.ReplyerMemberID ==  [UserInfoTool getLoginInfo].MemberID) {
            
            return NO;
        }
    }

    return YES;

}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.myTextView) {

//        if (self.selectedPhotos.count>0)
//        {
//
//            self.sureBtn.enabled = YES;
//            [self.sureBtn setBackgroundColor:kMainColor];
//        }else
//        {
//
//            self.sureBtn.enabled = NO;
//            [self.sureBtn setBackgroundColor:[UIColor getColor:@"dadada"]];
//        }
        
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.myTextView) {
//        self.textViewLal.text = @"我也说一句～";/*防止键盘下落后，回复ABC消失*/
        if (textView.text.length == 0) {//&&self.selectedPhotos.count==0
            if ([self.textViewLal.text isEqualToString:@"我也说一句～"]) {
                 self.textViewLal.text = @"我也说一句～";
            }

            self.sureBtn.enabled = NO;
            [self.sureBtn setBackgroundColor:[UIColor getColor:@"dadada"]];
//             [self.sureBtn setTitleColor:[UIColor getColor:@"bcbcbc"] forState:UIControlStateNormal];
        }
        else
        {
           
            self.sureBtn.enabled = YES;
             [self.sureBtn setBackgroundColor:kMainColor];
//            [self.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        }
        
    }
}
- (void)textViewDidChange:(UITextView *)textView;
{
    
    if (textView == self.myTextView) {
        if (textView.text.length == 0) {//&&self.selectedPhotos.count==0
            
             self.textViewLal.hidden = NO;
             self.sureBtn.enabled = NO;
             [self.sureBtn setBackgroundColor:[UIColor getColor:@"dadada"]];
//            [self.sureBtn setTitleColor:[UIColor getColor:@"bcbcbc"] forState:UIControlStateNormal];
        }
        else
        {
            self.textViewLal.hidden = YES;
            self.sureBtn.enabled = YES;
              [self.sureBtn setBackgroundColor:kMainColor];
//            [self.sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        }
    }
    
  
}
- (IBAction)takePictureAction:(id)sender {
    if (self.showTakePhotoBtnSwitch) {
//        NSString *takePhotoTitle = @"相机";
//
//        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self takePhoto];
//        }];
//        [alertVc addAction:takePhotoAction];
//        UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self pushTZImagePickerController];
//        }];
//        [alertVc addAction:imagePickerAction];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alertVc addAction:cancelAction];
//        UIPopoverPresentationController *popover = alertVc.popoverPresentationController;
//
//        [[self parentController]  presentViewController:alertVc animated:YES completion:nil];
//    } else {
        [self pushTZImagePickerController];
    }

}

- (IBAction)cancelAction:(id)sender {
      _myTextView.text = @"";
    
     self.textViewLal.text = @"我也说一句～";
//      [self.sureBtn setTitleColor:[UIColor getColor:@"bcbcbc"] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:[UIColor getColor:@"dadada"]];
    [self.selectedPhotos removeAllObjects];
    [self.selectedAssets removeAllObjects];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelForClicked)]) {
        [self.delegate cancelForClicked];
    }
    
}

- (IBAction)sureAction:(id)sender {
    if ([_myTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length <5&&(_isTopic == YES)) {
        
        ShowErrorStatus(@"请输入评论超过5个字");
        
        return;
        
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sureForClickedAction:)]) {
        [self.delegate sureForClickedAction:_myTextView.text];
    }
        self.textViewLal.hidden = NO;
        _myTextView.text = @"";
        [self.myTextView resignFirstResponder];
        [self.txtField resignFirstResponder];
   
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor =  [self parentController].navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor =  [self parentController] .navigationController.navigationBar.tintColor;
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
    _pCollectionView.alwaysBounceVertical = YES;
    _pCollectionView.contentInset = UIEdgeInsetsMake(1, 1, 1, 1);
    _pCollectionView.dataSource = self;
    _pCollectionView.delegate = self;
    [_pCollectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
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
    return _selectedPhotos.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
  
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
   
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   // preview photos or video / 预览照片或者视频
        PHAsset *asset = _selectedAssets[indexPath.item];
        BOOL isVideo = NO;
        isVideo = asset.mediaType == PHAssetMediaTypeVideo;
        if ([[asset valueForKey:@"filename"] containsString:@"GIF"] && self.allowPickingGifSwitch&& !self.allowPickingMuitlpleVideo) {
            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
            vc.model = model;
            [[self parentController]  presentViewController:vc animated:YES completion:nil];
        } else if (isVideo && !self.allowPickingMuitlpleVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [[self parentController]  presentViewController:vc animated:YES completion:nil];
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
                [self->_pCollectionView reloadData];
                self->_pCollectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (self->_margin + self->_itemWH));
            }];
            [[self parentController]  presentViewController:imagePickerVc animated:YES completion:nil];
            
            
            
        }
   
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_pCollectionView reloadData];
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    //    if (self.maxCountTF.text.integerValue <= 0) { //判断是否还可以插入图片
    //        return;
    //    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
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
    

    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];

    
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
    NSInteger widthHeight = self.width - 2 * left;
    NSInteger top = (self.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
         NSLog(@"设置");
        if (self.delegate && [self.delegate respondsToSelector:@selector(finishPicturePopTextViewAction)]) {
            [self.delegate finishPicturePopTextViewAction];
        }
        
    }];
    
   [ [self parentController]  presentViewController:imagePickerVc animated:YES completion:nil];
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
        [[self parentController] presentViewController:_imagePickerVc animated:YES completion:nil];
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
                    [[self parentController] presentViewController:imagePicker animated:YES completion:nil];
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
    [_pCollectionView reloadData];
    
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

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_pCollectionView reloadData];
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
    [_pCollectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_pCollectionView reloadData];
}

// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    return YES;
}
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    return YES;
}

#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.pCollectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
        [self.pCollectionView reloadData];
//        if (self.selectedPhotos.count>0)
//        {
//
//            self.sureBtn.enabled = YES;
//            [self.sureBtn setBackgroundColor:kMainColor];
//        }else
//        {
//
//            self.sureBtn.enabled = NO;
//            [self.sureBtn setBackgroundColor:[UIColor getColor:@"dadada"]];
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteDataUpdateHeghtAction)]) {
            [self.delegate deleteDataUpdateHeghtAction];
        }
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_pCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_pCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_pCollectionView reloadData];
//        if (self.selectedPhotos.count>0)
//        {
//
//            self.sureBtn.enabled = YES;
//            [self.sureBtn setBackgroundColor:kMainColor];
//        }else
//        {
//
//            self.sureBtn.enabled = NO;
//            [self.sureBtn setBackgroundColor:[UIColor getColor:@"dadada"]];
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteDataUpdateHeghtAction)]) {
            [self.delegate deleteDataUpdateHeghtAction];
        }
    }];
    

}
@end