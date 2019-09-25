//
//  XKVideoBigView.m
//  eHealthCare
//
//  Created by John shi on 2018/12/24.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import "XKVideoBigView.h"

@implementation XKVideoBigView

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
    
    _playerLayer.frame = self.bounds;
    _playButton.frame = CGRectMake((KScreenWidth-40)/2.0, (KScreenHeight-40)/2.0, 40, 40);
    //    _toolBar.frame = CGRectMake(0, self.view.tz_height - toolBarHeight, self.view.tz_width, toolBarHeight);
    //    _doneButton.frame = CGRectMake(self.view.tz_width - 44 - 12, 0, 44, 44);
    //    _playButton.frame = CGRectMake(0, statusBarAndNaviBarHeight, self.view.tz_width, self.view.tz_height - statusBarAndNaviBarHeight - toolBarHeight);
    [self configMoviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayerAndShowNaviBar) name:UIApplicationWillResignActiveNotification object:nil];
    
}
- (void)configMoviePlayer {
    //    [[TZImageManager manager] getPhotoWithAsset:_model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
    //        if (!isDegraded && photo) {
    //            self->_cover = photo;
    //            self->_doneButton.enabled = YES;
    //        }
    //    }];
    AVPlayerItem *playerItem =  [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@""]];
    self->_player = [AVPlayer playerWithPlayerItem:playerItem];
    self->_playerLayer = [AVPlayerLayer playerLayerWithPlayer:self->_player];
    self->_playerLayer.frame = self.bounds;
    [self.layer addSublayer:self->_playerLayer];
    [self addProgressObserver];
    [self configPlayButton];
    [self configBottomToolBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayerAndShowNaviBar) name:AVPlayerItemDidPlayToEndTimeNotification object:self->_player.currentItem];
    
}
/// Show progress，do it next time / 给播放器添加进度更新,下次加上
- (void)addProgressObserver{
    AVPlayerItem *playerItem = _player.currentItem;
    UIProgressView *progress = _progress;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playerItem duration]);
        if (current) {
            [progress setProgress:(current/total) animated:YES];
        }
    }];
}
- (void)configPlayButton {
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"icon_avi_sanjiao"] forState:UIControlStateNormal];
    [_playButton setImage:[UIImage imageNamed:@"icon_avi_sanjiao"] forState:UIControlStateHighlighted];
    [_playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playButton];
}

- (void)configBottomToolBar {
    _toolBar = [[UIView alloc] initWithFrame:CGRectZero];
    CGFloat rgb = 34 / 255.0;
    _toolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    if (!_cover) {
        _doneButton.enabled = NO;
    }
    [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0] forState:UIControlStateNormal];
    
    [_doneButton setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
    [_toolBar addSubview:_doneButton];
    [self addSubview:_toolBar];
    
    
}

#pragma mark - Click Event

- (void)playButtonClick {
    CMTime currentTime = _player.currentItem.currentTime;
    CMTime durationTime = _player.currentItem.duration;
    if (_player.rate == 0.0f) {
        if (currentTime.value == durationTime.value) [_player.currentItem seekToTime:CMTimeMake(0, 1)];
        [_player play];
       
        _toolBar.hidden = YES;
        [_playButton setImage:nil forState:UIControlStateNormal];
        [UIApplication sharedApplication].statusBarHidden = YES;
    } else {
        [self pausePlayerAndShowNaviBar];
    }
}

- (void)doneButtonClick {
//    if (self.navigationController) {
//
//        [self.navigationController dismissViewControllerAnimated:YES completion:^{
//            [self callDelegateMethod];
//        }];
//    } else {
//        [self dismissViewControllerAnimated:YES completion:^{
//            [self callDelegateMethod];
//        }];
//    }
    
    [self removeFromSuperview];
    
     [self callDelegateMethod];
    
}

- (void)callDelegateMethod {
    
}

#pragma mark - Notification Method

- (void)pausePlayerAndShowNaviBar {
    [_player pause];
    [_playButton setImage:[UIImage imageNamed:@"icon_avi_sanjiao"] forState:UIControlStateNormal];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
