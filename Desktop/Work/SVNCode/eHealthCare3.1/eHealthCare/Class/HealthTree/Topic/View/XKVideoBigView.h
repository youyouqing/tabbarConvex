//
//  XKVideoBigView.h
//  eHealthCare
//
//  Created by John shi on 2018/12/24.
//  Copyright © 2018 Jon Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface XKVideoBigView : UIView
{
    AVPlayer *_player;
    AVPlayerLayer *_playerLayer;
    UIButton *_playButton;
    UIImage *_cover;
    
    UIView *_toolBar;
    UIButton *_doneButton;
    UIProgressView *_progress;
}
@end
