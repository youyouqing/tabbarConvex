//
//  XKTopicHotBigView.m
//  eHealthCare
//
//  Created by John shi on 2018/12/24.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "XKTopicHotBigView.h"
#import "XKMedicalLookBigPhotoCell.h"
#import "XKHotTopicBigViewCollectionViewCell.h"

@implementation XKTopicHotBigView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.phCollectionView.delegate = self;
    self.phCollectionView.dataSource = self;
    self.backgroundColor = [UIColor clearColor];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(KScreenWidth, KScreenHeight);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.phCollectionView setCollectionViewLayout:flow];
    
    [self.phCollectionView registerNib:[UINib nibWithNibName:@"XKHotTopicBigViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    self.phCollectionView.pagingEnabled = YES;
    self.phCollectionView.showsVerticalScrollIndicator = NO;
    self.phCollectionView.showsHorizontalScrollIndicator = NO;
    

    
}
-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.phCollectionView setContentOffset:CGPointMake(KScreenWidth*self.currentPage, 0)];
    });
    [self.phCollectionView reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.photoArray.count;
    
}

+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XKHotTopicBigViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.xkpage = indexPath.row+1;
    cell.counPage = self.photoArray.count;
    
    id photoObject = self.photoArray[indexPath.row];
    id photoSizeObject= nil;

   
    cell.countLab.text = [NSString stringWithFormat:@"%li/%li",indexPath.row+1,self.photoArray.count];
    if ([photoObject isKindOfClass:[UIImage class]]) {
        UIImage *imageSize = (UIImage *)photoObject;
        cell.imageWidthCons.constant =  KScreenWidth;
        cell.imageHeightCons.constant = KScreenWidth *imageSize.size.height/imageSize.size.width;
        cell.iconImg.image = photoObject;
         return cell;
        
    }else{
//        WEAKSELF
//        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:photoObject] placeholderImage:[UIImage imageNamed:@"sugar_pic_5"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            cell.iconImg.image=  image;//[weakSelf ct_imageFromImage:image inRect:cell.iconImg.frame];
//            cell.imageWidthCons.constant =  KScreenWidth;
//            cell.imageHeightCons.constant = KScreenWidth *image.size.height/image.size.width;
//        }];
        if (self.photoSizeArray.count>0) {
            photoSizeObject = self.photoSizeArray[indexPath.row];
            NSArray *sizeArr = [photoSizeObject componentsSeparatedByString:@","];
            double width = 0;
            double height = 0;
            if (sizeArr.count>1) {
                
                width = [sizeArr[0] doubleValue];
                height = [sizeArr[1] doubleValue];
                cell.imageWidthCons.constant =  KScreenWidth;
                cell.imageHeightCons.constant = KScreenWidth *(double)height/(double)width;
        }
        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:photoObject]  placeholderImage:[UIImage imageNamed:@"iv_huati_suolvetu"] ];
            //        cell.iconImg.image = [UIImage imageNamed:@"iv_huati_suolvetu"] ;
            //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //
            //            NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:photoObject]];
            //            UIImage *image = [[UIImage alloc]initWithData:data];
            //            if (data != nil) {
            //
            //                dispatch_async(dispatch_get_main_queue(), ^{
            //                    //在这里做UI操作(UI操作都要放在主线程中执行)
            //
            ////                    UIImage *image = [self getImageFromURL:photoObject];
            //                    cell.imageWidthCons.constant =  KScreenWidth;
            //                    cell.imageHeightCons.constant = KScreenWidth *image.size.height/image.size.width;
            //                    cell.iconImg.image = image;
            //
            //                });
            //            }
            //
            //             });
            
            
            
            
            
            return cell;
        }
       
        
    }
    
    return cell;
}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self removeFromSuperview];
    
}
@end
