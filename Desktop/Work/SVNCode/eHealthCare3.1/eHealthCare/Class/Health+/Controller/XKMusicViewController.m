//
//  XKMusicViewController.m
//  eHealthCare
//
//  Created by xiekang on 2017/10/18.
//  Copyright © 2017年 mac. All rights reserved.
//携康3.0版本健康+ 正念训练视图控制器

#import "XKMusicViewController.h"
#import "XKBackButton.h"
//导入播放音频库
#import <AVFoundation/AVFoundation.h>
#import "XKValidationAndAddScoreTools.h"
#import "XKMusicListView.h"
#import "SJMP3Player.h"

@interface XKMusicViewController ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) SJMP3Player *mp3Player;

@property (nonatomic,strong) XKMusicListView *pView;
/**
 数据源载体实体
 */
@property (nonatomic,strong) MusicTrainModel *model;
/**
 列表
 */
@property (strong, nonatomic)  UIButton *listBtn;
/**
 正念训练标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mindfulnessTitle;

/**
 开始暂停音乐按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mindfulnessBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

/**
 正念训练背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mindfulnessBackImg;
@property(nonatomic,retain)AVPlayerItem *songItem;
@property(nonatomic,retain)AVPlayer *player;
@end

@implementation XKMusicViewController
- (SJMP3Player *)mp3Player {
    if ( _mp3Player )
        return _mp3Player;
    _mp3Player = [SJMP3Player player];
    _mp3Player.delegate = self;
    _mp3Player.enableDBUG = YES;
    return _mp3Player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (is_IPhoneX) {
        self.topCons.constant = 50;
    }else
        self.topCons.constant = 35;
    self.headerView.backgroundColor = [UIColor clearColor];
    [self backImageAction];
    NSString *backPleackName = @"bg_health_home_background_quiet";
    self.mindfulnessTitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    self.model = [[MusicTrainModel alloc]init];
    if (self.musicArray.count>0) {
       self.model = self.musicArray[0];
      }
//    [self onlinePlay:self.model.MusicUrl];//播放在线音乐
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([r currentReachabilityStatus] == ReachableViaWiFi) {
        //开始下载歌曲
    }
    if (self.mp3Player) {
        self.mp3Player = nil;
    }
    [self.mp3Player playWithURL:[NSURL URLWithString:self.model.MusicUrl]];
    
    self.mindfulnessTitle.text =self.model.EaseName;
    [self.mindfulnessBackImg sd_setImageWithURL:[NSURL URLWithString:self.model.BgImgUrl] placeholderImage:[UIImage imageNamed:backPleackName]];
    [self loadRecordData:self.model];//提交记录
    
//    [self getDetailData];//  根据正念训练获取到详情
    /*MindfulnessType
     Int
     正念类型(1：安静调节、2：缓解压力、3：正念训练)
     */

//    if (self.model.EaseType == 3 ) {
        //展示当天任务是否完成
        XKValidationAndAddScoreTools *tools = [[XKValidationAndAddScoreTools alloc] init];
        [tools validationAndAddScore:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(12)} withAdd:@{@"Token": [UserInfoTool getLoginInfo].Token,@"TaskType":@(1),@"MemberID":@( [UserInfoTool getLoginInfo].MemberID),@"TypeID":@(12)} isPopView:YES];
//    }


}

/**
 在线播放音乐
 */
-(void)onlinePlay:(NSString *)musicName
{
    
    if (self.player) {//正在播放停止播放
       self.player=nil;

    }
    if (self.songItem) {
        [self.songItem removeObserver:self forKeyPath:@"status"];
        [self.songItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [self.songItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
        self.songItem = nil;
        
    }
   
    NSString *urlStr= musicName;//[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",musicName] ofType:nil];//没有播放文件  零时的
    NSError *error=nil;
    //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
//    self.audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    //设置播放器属性
     self.songItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlStr]];
     self.player = [[AVPlayer alloc] initWithPlayerItem:_songItem];
     _player.volume=1.0;
    [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.songItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [self.songItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
     [_player play];
    //设置后台播放
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self enableBackgroundPlay];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterOrLeaveForeground) name:UIApplicationDidEnterBackgroundNotification object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterOrLeaveForeground) name:UIApplicationWillEnterForegroundNotification object:_player];
}
- (void)resetPlayer{
    if (self.player) {
      
        [self.player seekToTime:CMTimeMakeWithSeconds(0, self.songItem.currentTime.timescale)];
//        [self clickPlay:self.mindfulnessBtn];
    }
}
- (void)enableBackgroundPlay{
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)appEnterOrLeaveForeground{
    if(self.mindfulnessBtn.isSelected){
        [self play];
    }else{
        [self pause];
    }
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//
//    if ([keyPath isEqualToString:@"status"]) {
//        switch (self.player.status) {
//            case AVPlayerStatusUnknown:
//                NSLog(@"KVO：未知状态，此时不能播放");
//                ShowErrorStatus(@"未知状态，此时不能播放" );
//                break;
//            case AVPlayerStatusReadyToPlay:
////                self.status = SUPlayStatusReadyToPlay;
//                NSLog(@"KVO：准备完毕，可以播放");
//                break;
//            case AVPlayerStatusFailed:
//               NSLog(@"KVO：加载失败，网络或者服务器出现问题");
//               ShowErrorStatus(@"加载失败，网络或者服务器出现问题");
//                break;
//            default:
//                break;
//        }
//    }
//    else if ([keyPath isEqualToString:@"playbackBufferEmpty"])
//    {
//        if (self.songItem.playbackBufferEmpty) {
//
//
//
//        }
//    }
//    else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"])
//    {
//
//
//        if (self.songItem.playbackLikelyToKeepUp) {
//
//
//        }
//    }
//}
#pragma mark -SJMPp3Player

- (void)audioPlayer:(SJMP3Player *)player audioDownloadProgress:(CGFloat)progress {
    NSLog(@"audioDownloadProgress:%lf",progress);
    
}

- (void)audioPlayer:(SJMP3Player *)player currentTime:(NSTimeInterval)currentTime reachableTime:(NSTimeInterval)reachableTime totalTime:(NSTimeInterval)totalTime {
 
    
    NSLog(@"totalTime-88888-::::%lf---------------currentTime:%lf---",totalTime,currentTime * 1.0 / totalTime);
    
    
    
}
- (void)audioPlayerDidFinishPlaying:(SJMP3Player *)player {
    NSLog(@"--55555#################-");
   
    
}

/**提交行为记录
 */
-(void)loadRecordData:(MusicTrainModel *) upModel{
//    [[XKLoadingView shareLoadingView] showLoadingText:@"努力加载中"];
    NSDictionary *dict = @{@"Token": [UserInfoTool getLoginInfo].Token,@"MemberId":@( [UserInfoTool getLoginInfo].MemberID),@"MemName": [UserInfoTool getLoginInfo].Name,@"Mobile": [UserInfoTool getLoginInfo].Mobile,@"BehaviorType":@(self.model.MindfulnessType),@"EaseID":@(self.model.EaseID)};
    
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"961" parameters:dict success:^(id json) {
        
        NSLog(@"提交行为记录961--:%@",json);
        
        if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {
            //广告信息
//            [[XKLoadingView shareLoadingView] hideLoding];
          
        }else{
//            [[XKLoadingView shareLoadingView] errorloadingText:@"加载失败"];
        }
    } failure:^(id error) {
        NSLog(@"%@",error);
//        [[XKLoadingView shareLoadingView] errorloadingText:@"加载失败"];
    }];
}

/**
 懒加载
 */
-(XKMusicListView *)pView{
    if (!_pView) {
        _pView = [[[NSBundle mainBundle] loadNibNamed:@"XKMusicListView" owner:self options:nil] firstObject];
        _pView.left = 0;
        _pView.top = 0;
        _pView.width = KScreenWidth;
        _pView.height = KScreenHeight;
        _pView.delegate = self;
       
        _pView.imageNameArr =  self.musicArray;
        _pView.selectedBoolArr = [NSMutableArray arrayWithObjects: [NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], nil];
    }
    return _pView;
}
/**
 返回按钮信息初始化
 */
-(void)backImageAction{
    
    //选择主题背景
    UIButton *choseTopicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [choseTopicButton setImage:[UIImage imageNamed:@"topicChoseImage"] forState:UIControlStateNormal];
    [choseTopicButton addTarget:self action:@selector(listBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:choseTopicButton];
    [choseTopicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo((PublicY) - 42);
        make.right.mas_equalTo(- 12);
        make.size.mas_equalTo(CGSizeMake(KWidth(40), KWidth(40)));
    }];
    
    self.listBtn = choseTopicButton;
    
//    [self.leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [self.listBtn setBackgroundImage:[UIImage imageNamed:@"icon_plus_list"] forState:UIControlStateNormal];
//
//
//
//    [self.listBtn addTarget:self action:@selector(listBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.listBtn.frame = CGRectMake(KScreenWidth-15-40, (PublicY-40)/2.0, 40, 40);
//
//    [self.view addSubview:self.listBtn];
    
}
-(IBAction)listBtnAction:(id)sender{
    
    
    [self.view addSubview:self.pView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.pView.listView.y = KScreenHeight-((44*(KScreenWidth-12)/181.0+6.0)*self.pView.imageNameArr.count);
//        self.pView.listViewHeight.constant = ((44*(KScreenWidth-12)/181.0+6.0)*self.pView.imageNameArr.count);
    }];
    
}
/**
 返回按钮的点击事件
 */
//-(void)clickBtn:(UIButton *)btn{
//    [self.navigationController popViewControllerAnimated:YES];
//}

/**
 收到内存警告
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//播放
-(void)play{
    if (self.player) {
        [self.player play];
    }
}

//暂停
-(void)pause{
    if (self.player) {
        [self.player pause];
    }
}
/**
 播放暂停按钮的点击事件
*/
- (IBAction)clickPlay:(UIButton *)sender {
    if (sender.selected) {
//        [self.player play];
         [self.mp3Player resume];
    }else
    {
//        [self.player pause];
         [self.mp3Player pause];
    }
   
    sender.selected = !sender.selected;
    
}

/**
 控制器销毁的方法
 */
-(void)dealloc{
    
//    [self.player pause];
//    [self.songItem removeObserver:self forKeyPath:@"status"];
//    [self.songItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
//    [self.songItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
//
//
//
//    self.player = nil;
//    self.songItem = nil;
}
/*
 判断是否缓冲中
 */
- (BOOL)buffering{
    if (CMTimeGetSeconds(self.songItem.currentTime) < [self getBufferTime]) {
        return NO;
    }else {
        return YES;
    }
}

/*
 获取缓冲好的时间
 */
- (NSTimeInterval)getBufferTime{
    NSArray *loadTimeRanges = [_songItem loadedTimeRanges];
    CMTimeRange timeRange = [[loadTimeRanges firstObject] CMTimeRangeValue];
    NSTimeInterval start = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval duration = CMTimeGetSeconds(timeRange.duration);
    return start + duration;
}


- (NSString *)timeFormatWithTimtInterval:(NSTimeInterval)duration{
    NSInteger min = duration / 60;
    NSInteger sec = (NSInteger)duration % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",(long)min, (long)sec];
}
#pragma mark   Delegate
-(void)prepare:(NSInteger)row;//准备好了方法  替换按钮和颜色
{
    
     MusicTrainModel *mod = self.musicArray[row];
     [self.mindfulnessBackImg sd_setImageWithURL:[NSURL URLWithString:mod.BgImgUrl] placeholderImage:[UIImage imageNamed:@"bg_health_home_background_quiet"]];
    self.mindfulnessTitle.text =mod.EaseName;
    //替换音乐
//    [self onlinePlay:mod.MusicUrl];
      self.mindfulnessBtn.selected = NO;//替换按钮的时候也播放
  
      [self.mp3Player playWithURL:[NSURL URLWithString:mod.MusicUrl]];
}
@end
