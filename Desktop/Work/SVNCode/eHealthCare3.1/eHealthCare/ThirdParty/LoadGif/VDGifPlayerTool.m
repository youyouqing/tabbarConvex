//
//  VDGifPlayerTool.m
//  eHealthCare
//
//  Created by John shi on 2018/10/31.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "VDGifPlayerTool.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface VDGifPlayerTool ()
@property (nonatomic, strong)UIView *gifContentView;

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;

@end
@implementation VDGifPlayerTool

- (void)addGifWithName:(NSString *)gifName toView:(UIView *)view{
    self.gifContentView = view;
    [self createGif:gifName];
}

- (void)createGif:(NSString *)name{
    
    //    _gifContentView.layer.borderColor = UIColorFromRGB(No_Choose_Color).CGColor;
    //    _gifContentView.layer.borderWidth = 1.0;
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:name ofType:@"gif"]];
    _gif = CGImageSourceCreateWithData((CFDataRef)gif, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(startLoading) userInfo:nil repeats:YES];
    [_timer fire];
}
-(void)startLoading
{
    _index ++;
    //    _index = _index%_count;
    if (_index>=_count) {
        
        if (self.call_back) {
            self.call_back(TRUE);
        }
        
    }
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.gifContentView.layer.contents = (__bridge id)ref;
    if (ref) {
        CFRelease(ref);
    }else{
        [_timer invalidate];
        _timer = NULL;
        return;
    }
}

-(void)stopLoading{
    
//    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
//    self.gifContentView.layer.contents = (__bridge id)ref;
//    if (ref) {
//        CFRelease(ref);
//    }
//    if (_gif) {
//        CFRelease(_gif);
//    }
    [self.gifContentView removeFromSuperview];
    [_timer invalidate];
    _timer = NULL;
   
}
-(void)remove{
    [_timer invalidate];
    _timer = NULL;
    if (_gif) {
        CFRelease(_gif);
    }
}
- (void)dealloc{
    [_timer invalidate];
    _timer = NULL;
//    if (_gif) {
//        CFRelease(_gif);
//    }
}


-(void)startAnimateGifMethod:(NSString *)name toView:(UIImageView *)imgView{
//     NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
//      NSDictionary *gifCountDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
     NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:name ofType:@"gif"]];
//     CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)gifData, (CFDictionaryRef)gifCountDic);
     CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
     size_t count = CGImageSourceGetCount(imageSource);
    NSTimeInterval duration = 0;
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<count; i++) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
        NSTimeInterval frameDuration = [self gifImageDeleyTime:imageSource index:i];
        duration += frameDuration;
            // 3.2.获取时长
//        guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) , let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
//        (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) else { continue }
        UIImage *imageName =  [UIImage imageWithCGImage:cgImage];
        [imageArr addObject:imageName];
        if (i == count-1) {
//            imgView.image = imageName;
          
        }
        CGImageRelease(cgImage);
    }
    imgView.animationImages = imageArr;
    imgView.animationDuration = 0.3;
    imgView.animationRepeatCount = 1;
    [imgView startAnimating];
}
    //获取GIF图片每帧的时长
- (NSTimeInterval)gifImageDeleyTime:(CGImageSourceRef)imageSource index:(NSInteger)index {
    NSTimeInterval duration = 0;
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, index, NULL);
    if (imageProperties) {
        CFDictionaryRef gifProperties;
        BOOL result = CFDictionaryGetValueIfPresent(imageProperties, kCGImagePropertyGIFDictionary, (const void **)&gifProperties);
        if (result) {
            const void *durationValue;
            if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFUnclampedDelayTime, &durationValue)) {
                duration = [(__bridge NSNumber *)durationValue doubleValue];
                if (duration < 0) {
                    if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFDelayTime, &durationValue)) {
                        duration = [(__bridge NSNumber *)durationValue doubleValue];
                    }
                }
            }
        }
    }
    
    return duration;
}

@end
