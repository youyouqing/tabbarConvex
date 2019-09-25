//
//  POVoiceHUD.m
//  POVoiceHUD
//
//  Created by Polat Olu on 18/04/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//


// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2013 Polat Olu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "POVoiceHUD.h"

@implementation POVoiceHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentMode = UIViewContentModeRedraw;

		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];

		self.alpha = 0.0f;
        //注释背景
        hudRect = CGRectMake(0, 0, frame.size.width,  frame.size.height);
        int x = (frame.size.width - HUD_SIZE) / 2;
        btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(x, hudRect.origin.y + HUD_SIZE - CANCEL_BUTTON_HEIGHT, HUD_SIZE, CANCEL_BUTTON_HEIGHT)];
        [btnCancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(cancelled:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btnCancel];注释取消按钮
        
//        imgMicrophone = [UIImage imageNamed:@"microphone"]; 注释麦克风图片

        // fill empty sound meters
        for(int i=0; i<SOUND_METER_COUNT; i++) {
            soundMeters[i] = 0;
        }
    }
    
    return self;
}

- (id)initWithParentView:(UIView *)view {
    return [self initWithFrame:CGRectMake(WAVEX, [UIScreen mainScreen].bounds.size.height-260, [UIScreen mainScreen].bounds.size.width-2*WAVEX,  70)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self commitRecording];
}

- (void)startForFilePath:(NSString *)filePath {
    recordTime = 0;
    
    self.alpha = 1.0f;
    [self setNeedsDisplay];

	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	NSError *err = nil;
	[audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
	[audioSession setActive:YES error:&err];
	err = nil;
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
	
	recordSetting = [[NSMutableDictionary alloc] init];
	
	// You can change the settings for the voice quality
	[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
	[recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
	
	// if you are using kAudioFormatLinearPCM format, activate these settings
	//[recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
	//[recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
	//[recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
	
    NSLog(@"Recording at: %@", filePath);
	recorderFilePath = filePath;
	
	NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
	
	err = nil;
	
	NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
	if(audioData)
	{
		NSFileManager *fm = [NSFileManager defaultManager];
		[fm removeItemAtPath:[url path] error:&err];
	}
	
	err = nil;
	recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
	if(!recorder){
        NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
								   message: [err localizedDescription]
								  delegate: nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
        [alert show];
        return;
	}
	
	[recorder setDelegate:self];
	[recorder prepareToRecord];
	recorder.meteringEnabled = YES;
	
	BOOL audioHWAvailable = audioSession.inputIsAvailable;
	if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
								   message: @"Audio input hardware not available"
								  delegate: nil
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
        [cantRecordAlert show];
        return;
	}
	
	[recorder recordForDuration:(NSTimeInterval) MAXFLOAT];//最大记录时间
	
	timer = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
}

- (void)updateMeters {
    [recorder updateMeters];
    
    recordTime += WAVE_UPDATE_FREQUENCY;
    [self addSoundMeterItem:[recorder averagePowerForChannel:0]];
    
}

- (void)cancelRecording {
    if ([self.delegate respondsToSelector:@selector(voiceRecordCancelledByUser:)]) {
        [self.delegate voiceRecordCancelledByUser:self];
    }
    
    [recorder stop];
}

- (void)commitRecording {
    [recorder stop];
    [timer invalidate];
    
    if ([self.delegate respondsToSelector:@selector(POVoiceHUD:voiceRecorded:length:)]) {
        [self.delegate POVoiceHUD:self voiceRecorded:recorderFilePath length:recordTime];
    }
    
    self.alpha = 0.0;
    [self setNeedsDisplay];
}

- (void)cancelled:(id)sender {
    self.alpha = 0.0;
    [self setNeedsDisplay];
    
    [timer invalidate];
    [self cancelRecording];
}

- (void)setCancelButtonTitle:(NSString *)title {
    btnCancel.titleLabel.text = title;
}

#pragma mark - Sound meter operations
- (void)shiftSoundMeterLeft {
    for(int i=0; i<SOUND_METER_COUNT - 1; i++) {
        soundMeters[i] = soundMeters[i+1];
    }
}

- (void)addSoundMeterItem:(int)lastValue {
    [self shiftSoundMeterLeft];
    [self shiftSoundMeterLeft];
    soundMeters[SOUND_METER_COUNT - 1] = lastValue;
    soundMeters[SOUND_METER_COUNT - 2] = lastValue;
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing operations

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *strokeColor = [UIColor colorWithRed:0.886 green:0.0 blue:0.0 alpha:0.8];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor clearColor].CGColor,
                               (id)[UIColor clearColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    UIBezierPath *border = [UIBezierPath bezierPathWithRoundedRect:hudRect cornerRadius:0];
    CGContextSaveGState(context);
    [border addClip];
    CGContextDrawRadialGradient(context, gradient,
                                CGPointMake(hudRect.origin.x+HUD_SIZE/2, 120), 10,
                                CGPointMake(hudRect.origin.x+HUD_SIZE/2, 195), 215,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGContextRestoreGState(context);
    [strokeColor setStroke];
    border.lineWidth = 0;
    [border stroke];
    
    // Draw sound meter wave
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4] set];
    
    CGContextSetLineWidth(context, 3.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);

    int baseLine = 30;
    int multiplier = 1;
    int maxLengthOfWave = 20;
    int maxValueOfMeter = 20;
    for(CGFloat x = SOUND_METER_COUNT - 1; x >= 0; x--)
    {
        multiplier = ((int)x % 2) == 0 ? 1 : -1;
        
        CGFloat y =  baseLine+((maxValueOfMeter * (maxLengthOfWave - abs(soundMeters[(int)x]))) / maxLengthOfWave) * multiplier;
        
        if(x == SOUND_METER_COUNT - 1) {
            CGContextMoveToPoint(context, x * (HUD_SIZE / SOUND_METER_COUNT) + hudRect.origin.x + 10, y);
            CGContextAddLineToPoint(context, x * (HUD_SIZE/ SOUND_METER_COUNT) + hudRect.origin.x + 7, y);
        }
        else {
            CGContextAddLineToPoint(context, x * (HUD_SIZE / SOUND_METER_COUNT) + hudRect.origin.x + 10, y);
            CGContextAddLineToPoint(context, x * (HUD_SIZE / SOUND_METER_COUNT) + hudRect.origin.x + 7, y);
        }
    }
    
    CGContextStrokePath(context);
}

@end
