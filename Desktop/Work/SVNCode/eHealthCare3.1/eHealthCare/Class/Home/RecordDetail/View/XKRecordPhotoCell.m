//
//  XKRecordPhotoCell.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//电子病历原件信息

#import "XKRecordPhotoCell.h"
#import "XKRecordPhotoCollectionCell.h"
#import "XKMedicalLookBigPhotoController.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import "TZGifPhotoPreviewController.h"
#import "TZVideoPlayerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"

@interface XKRecordPhotoCell ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
//    UIImagePickerController *_imagePickerController;
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;

    
}

//图片视图控制器对象
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

//是否是地方的标示
@property (strong, nonatomic) CLLocation *location;

/**
 是否能访问gif图片的设置
 */
@property (nonatomic,assign) BOOL allowPickingGifSwitch;

/**
 设置最多可以选择多少张图片
 */
@property (nonatomic,assign) NSInteger maxPage;

/**
 是否允许内部拍照
 */
@property (nonatomic,assign) BOOL showTakePhotoBtnSwitch;

/**
 是否允许图片裁剪
 */
@property (nonatomic,assign) BOOL allowCropSwitch;

@property (nonatomic,strong) NSMutableArray *currentPhotoArray;

/**
 提示最多图片标签
 */
@property (weak, nonatomic) IBOutlet UILabel *photoNumbercontrolLab;

@end

@implementation XKRecordPhotoCell

/**
 懒加载图片视图对象
 */
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = [self parentController].navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = [self parentController].navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
//        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        } else {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
//            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
//        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)awakeFromNib {
    [super awakeFromNib];
     self.backgroundColor =kbackGroundGrayColor;
    //初始化数组
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
    //初始化最大可选择招聘
    self.maxPage = 9;
    
    //允许内部拍照
    self.showTakePhotoBtnSwitch = YES;
    
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((KScreenWidth-60-20)/3, (KScreenWidth-60-20)/3);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [self.photoCollectionView setCollectionViewLayout:flow];
    
//    self.photoCollectionView.scrollEnabled = NO;
    
    self.photoCollectionView.showsVerticalScrollIndicator = NO;
    self.photoCollectionView.showsHorizontalScrollIndicator = NO;
    
//    self.photoCollectionView.alwaysBounceVertical = YES;
//    self.photoCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.photoCollectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_selectedPhotos.count >= 9) {
        return 9;
    }
    
    return self.isEnableEdit?_selectedPhotos.count+1:_selectedPhotos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.currentPhotoArray.count < 9) {
        TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
        if (self.isEnableEdit) {
            cell.deleteBtn.hidden = NO;
        }
        else{
            cell.deleteBtn.hidden = YES;
        }
        cell.gifLable.hidden = YES;
        cell.videoImageView.hidden = YES;
        if (indexPath.row == _selectedPhotos.count) {
            cell.imageView.image = [UIImage imageNamed:@"iv_adding_dianzibingli"];
            cell.deleteBtn.hidden = YES;
            cell.gifLable.hidden = YES;
        } else {
            
            id photoObject = _selectedPhotos[indexPath.row];
            
            
            if ([photoObject isKindOfClass:[UIImage class]]) {
                cell.imageView.image = _selectedPhotos[indexPath.row];
                
            }else{
                
                XKPatientPhotoModel *photo = _selectedPhotos[indexPath.row];
                
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:photo.PicUrl] placeholderImage:[UIImage imageNamed:@"homeExtention"]];
            }
            
            if (self.previewMothed == 1) {
                cell.asset = _selectedAssets[indexPath.row];
            }
            
            //        cell.deleteBtn.hidden = NO;
        }
        
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else{
        TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
        if (self.isEnableEdit) {
            cell.deleteBtn.hidden = NO;
        }
        else{
            cell.deleteBtn.hidden = YES;
        }
        
        cell.videoImageView.hidden = YES;
        
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];

        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return nil;
    
}

-(void)setIsEnableEdit:(BOOL)isEnableEdit{
    
    _isEnableEdit = isEnableEdit;
    
    if (_isEnableEdit) {
        self.photoNumbercontrolLab.hidden = NO;
    }else{
        self.photoNumbercontrolLab.hidden = YES;
    }
    
    [self.photoCollectionView reloadData];
    
}

-(void)setModel:(XKPatientDetailModel *)model{
    
    _model = model;
    
    NSArray *array = _model.PicList;
    
    //计算可以选择照片的张数
    _selectedPhotos = (NSMutableArray *)array;
    NSInteger photoModCount = 0;
    for (NSInteger i=0; i<_model.PicList.count; i++) {
        id obj = _model.PicList[i];
        if ([obj isKindOfClass:[XKPatientPhotoModel class]]) {
            photoModCount ++;
        }
    }
    
    self.maxPage = 9-photoModCount;
    
    [self.photoCollectionView reloadData];
    
}

//集合视图删除图片的方法
- (void)deleteBtnClik:(UIButton *)sender {
    
    id photoObject = _selectedPhotos[sender.tag];
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    if ([photoObject isKindOfClass:[UIImage class]]) {//判断是否需要删除预览照片
        if (_selectedAssets[sender.tag]) {
            [_selectedAssets removeObjectAtIndex:sender.tag];
        }
    }else{//从服务器删除照片
        
        XKPatientPhotoModel *mod = (XKPatientPhotoModel *)photoObject;
        
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"935" parameters:@{@"PatientID":@(self.model.PatientID),@"Token":[UserInfoTool getLoginInfo].Token,@"ID":@(mod.ID)} success:^(id json) {
            NSLog(@"%@",@{@"PatientID":@(self.model.PatientID),@"Token":[UserInfoTool getLoginInfo].Token,@"ID":@(mod.ID)});
            NSLog(@"%@",json);
            
            if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                
                NSLog(@"删除照片成功");
                
            }else{
                [[XKLoadingView shareLoadingView]errorloadingText:@"删除照片失败"];
                
            }
            
        } failure:^(id error) {
            
            NSLog(@"%@",error);
            [[XKLoadingView shareLoadingView]errorloadingText:@"删除照片失败"];
            
        }];

        
    }

    //调用代理处理照片
    if ([self.delegate respondsToSelector:@selector(reloadPhotoViewHeight:)]) {
        [self.delegate reloadPhotoViewHeight:_selectedPhotos];
    }
    
    [self.photoCollectionView reloadData];
}

//点击选中集合视图的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(takePhotoWithKeyboardDone)]) {
        [self.delegate takePhotoWithKeyboardDone];
    }
    if (indexPath.row == _selectedPhotos.count) {
        //判断是否允许内部拍照功能
        if (self.showTakePhotoBtnSwitch) {//点击最后一个选择设置方法
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
            [sheet showInView:[self parentController].view];
        } else {
            [self pushTZImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
       
        //判断图片预览方式
        if (self.previewMothed == 1) { //上传时的图片预览方式
            id asset = _selectedAssets[indexPath.row];
            BOOL isVideo = NO;
            //可以访问gif图片
            if ([[asset valueForKey:@"filename"] containsString:@"GIF"] && self.allowPickingGifSwitch) {
                TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
                TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
                vc.model = model;
                [[self parentController]presentViewController:vc animated:YES completion:nil];
            } else if (isVideo) { // perview video / 预览视频 //是否可以访问视频的设置
                TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
                TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
                vc.model = model;
                [[self parentController]presentViewController:vc animated:YES completion:nil];
            } else { // preview photos / 预览照片
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
                //设置图片最大张数
                imagePickerVc.maxImagesCount = self.maxPage;
                //设置是否能发送原图
                imagePickerVc.allowPickingOriginalPhoto = YES;
                imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                    _selectedAssets = [NSMutableArray arrayWithArray:assets];
                    _isSelectOriginalPhoto = isSelectOriginalPhoto;
                    [self.photoCollectionView reloadData];
                    self.photoCollectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
                }];
                [[self parentController]presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }else{//编辑时的图片预览方式
            
            if ([self.delegate respondsToSelector:@selector(jumpTopBigPhoto:withPage:)]) {
                [self.delegate jumpTopBigPhoto:_selectedPhotos withPage:indexPath.row];
            }
            
        }
        
    }
}

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
    
    [self.photoCollectionView reloadData];
}

//内涵拍摄按钮的方法
- (void)pushTZImagePickerController {
    if (self.maxPage <= 0) {//判断是否还可以插入图片
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxPage columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (self.maxPage > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    //设置是否允许内部拍照
    imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch; // 在内部显示拍照按钮
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;//不可以访问视频
    imagePickerVc.allowPickingImage = YES;//设置可以选择照片
    imagePickerVc.allowPickingOriginalPhoto = YES;//设置可以选择原图
    imagePickerVc.allowPickingGif = self.allowPickingGifSwitch;//设置是否可以选择gif图片
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    
    //一次只能选择一张可编辑的图片
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.circleCropRadius = 100;
    imagePickerVc.isStatusBarDefault = NO;
    
#pragma mark - 到这里为止
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [[self parentController]presentViewController:imagePickerVc animated:YES completion:nil];
}

/**
 弹框视图的点击
 */
- (void)takePhoto {
   
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) ) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
     
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
//        } else {
//            [self takePhoto];
//        }
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
   
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}

/**
 调用相机拍照
 */
- (void)pushImagePickerController {
    // 提前定位
     __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        _location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
//        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        }
        [[self parentController]presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        //是否按照时间排序
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
       [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                 TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
//                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
//                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
//                        [tzImagePickerVc hideProgressHUD];
//                        TZAssetModel *assetModel = [models firstObject];
//                        if (tzImagePickerVc.sortAscendingByModificationDate) {
//                            assetModel = [models lastObject];
//                        }
                        if (self.allowCropSwitch) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                            }];
                            //关闭原型裁剪框
                            imagePicker.needCircleCrop = NO;
                            imagePicker.circleCropRadius = 100;
                            [[self parentController]presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                        }
//                    }];
//                }];
            }
        }];
    }
}

/**
 重新刷新集合视图
 */
- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [self.photoCollectionView reloadData];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

/**
 pickerimg点击取消调用的方法
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 拍照相册选择的方法
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushTZImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
     
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }
}

/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    //数据源处理
    _selectedPhotos = [NSMutableArray arrayWithCapacity:0];
    if (self.previewMothed ==1) {
      _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    }else{

        NSLog(@"新图片%@",photos);
        NSLog(@"原来数据%@",self.model.PicList);
        NSLog(@"展示数据%@",_selectedPhotos);
        
        NSLog(@"新图片%@",photos);
        NSLog(@"原来数据%@",self.model.PicList);
        NSLog(@"展示数据%@",_selectedPhotos);
        
        for (int i = 0; i<self.model.PicList.count; i++) {
            id mod = self.model.PicList[i];
            if ([mod isKindOfClass:[XKPatientPhotoModel class]]) {
                [_selectedPhotos addObject:mod];
            }
        }
        
        for (UIImage *img in photos) {
            [_selectedPhotos addObject:img];
        }
        NSLog(@"新图片%@",photos);
        NSLog(@"原来数据%@",self.model.PicList);
        NSLog(@"展示数据%@",_selectedPhotos);
        
    }
    
    if ([self.delegate respondsToSelector:@selector(reloadPhotoViewHeight:)]) {//刷新高度
        
        [self.delegate reloadPhotoViewHeight:_selectedPhotos];
        
    }
    
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [self.photoCollectionView reloadData];
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
  
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
   
}

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    NSLog(@"%@",fileName);
}

/**
 导出视频
 */
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [self.photoCollectionView reloadData];
}

/**
 导出gif图片
 */
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [self.photoCollectionView reloadData];
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    return YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(id)asset {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

/**
 重写图片预览方式
 */
-(void)setPreviewMothed:(NSInteger)previewMothed{
    _previewMothed = previewMothed;
}

@end
