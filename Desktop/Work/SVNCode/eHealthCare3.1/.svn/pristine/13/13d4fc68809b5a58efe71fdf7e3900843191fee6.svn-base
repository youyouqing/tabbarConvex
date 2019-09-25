/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "ChatViewController.h"
#import "ChatNaviExpendView.h"
#import "ChatHeadView.h"
#import "ChatPhotoView.h"
#import "ChatPhotoViewController.h"
#import "AdviserIntroduceViewController2.h"
#import "XKConsultantstarView.h"
//#import "ChatGroupDetailViewController.h"
//#import "ChatroomDetailViewController.h"
//#import "UserProfileViewController.h"
//#import "UserProfileManager.h"
//#import "ContactListSelectViewController.h"
//#import "ChatDemoHelper.h"
//#import "EMChooseViewController.h"
//#import "ContactSelectionViewController.h"

@interface ChatViewController ()<UIAlertViewDelegate,EMClientDelegate,ChatPhotoViewControllerDelegate,XKConsultantstarViewDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    UIMenuItem *_transpondMenuItem;
    UIView *naviView;
    BOOL  isRemovePhotoView;
    BOOL isHeadShow;
}

@property (nonatomic) BOOL isPlayingAudio;

@property (nonatomic) NSMutableDictionary *emotionDic;
@property (nonatomic, copy) EaseSelectAtTargetCallback selectedCallback;
@property (nonatomic, strong) ChatNaviExpendView *expendNaviView;
@property (nonatomic, strong) ChatHeadView *headView;
@property (nonatomic, strong) ChatPhotoView *photoView;
@property (nonatomic,strong)XKArchiveTransetionDelegateModel *archiveCoverDelegate;


/**
 星级评价View
 */
@property(strong,nonatomic) XKConsultantstarView *consultStarView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self _setupBarButtonItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAllMessages:) name:KNOTIFICATIONNAME_DELETEALLMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:@"ExitGroup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage:) name:@"insertCallMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callControllerClose" object:nil];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0];
    
    if (!self.isOnline) {
        //**新增操作方法
        [self addProgressHeadView];
        //提问照片试图--因为试图出现后，保存到本地，所以要写在naviView时间判断之后（现在保存本地改为关闭后存储，就不会有判断前后的问题了）
        [self addPhotoView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    if (self.conversation.type == EMConversationTypeChatRoom)
    {
        //退出聊天室，删除会话
        if (self.isJoinedChatroom) {
            NSString *chatter = [self.conversation.conversationId copy];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                [[EMClient sharedClient].roomManager leaveChatroom:chatter error:&error];
                if (error !=nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Leave chatroom '%@' failed [%@]", chatter, error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                    });
                }
            });
        }
        else {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:YES];
        }
    }
    
    [[EMClient sharedClient] removeDelegate:self];
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        NSDictionary *ext = self.conversation.ext;
        if ([[ext objectForKey:@"subject"] length])
        {
            self.title = [ext objectForKey:@"subject"];
        }
        
//        if (ext && ext[kHaveUnreadAtMessage] != nil)
//        {
//            NSMutableDictionary *newExt = [ext mutableCopy];
//            [newExt removeObjectForKey:kHaveUnreadAtMessage];
//            self.conversation.ext = newExt;
//        }
    }
    
    if ([self isShowPhotoView]) {
        //**判断提问框是否已经关闭，如果已经关闭，则不显示导航栏上面灰色的view
        if (!isRemovePhotoView) {
            naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SystemScreenWidth, 64)];
            naviView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:naviView];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
    
    if ([self isShowPhotoView]) {
        [super viewWillDisappear:animated];
        [naviView removeFromSuperview];
    }
}

#pragma mark - setup subviews
-(void)creatTitleView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
//    titleView.backgroundColor = [UIColor redColor];
    CGSize size = [self.doctorNickName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}context:nil].size;
    UILabel *titleViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    titleViewLabel.center = CGPointMake(titleView.width/2, titleView.height/2);
    titleViewLabel.text = self.doctorNickName;
    titleViewLabel.font = [UIFont boldSystemFontOfSize:20];
    titleViewLabel.textColor = [UIColor whiteColor];
//    titleViewLabel.backgroundColor = [UIColor yellowColor];
    titleViewLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleViewLabel];
    
    UILabel *stausLal = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleViewLabel.frame), CGRectGetMaxY(titleViewLabel.frame) - 16, 50, 16)];
//    stausLal.backgroundColor = [UIColor orangeColor];
    stausLal.font = [UIFont systemFontOfSize:12];
    stausLal.textColor = [UIColor whiteColor];
    if (self.onlineStaus == 0) {
        stausLal.text = @" (离线)";
    }else{
        stausLal.text = @" (在线)";
    }
    [titleView addSubview:stausLal];
    
    self.navigationItem.titleView = titleView;
}
- (void)_setupBarButtonItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];//**环信--导航栏按钮
    
    //
    if (!_isOnline) {
      [self creatTitleView];
    }
    
    //单聊
    if (self.conversation.type == EMConversationTypeChat) {
        if (_isOnline ==NO) {
            
            /*-----------顾问星级——评价 */
           self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"评价" style:UIBarButtonItemStylePlain target:self action:@selector(consultStarBtn)];
//            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"chatmore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(expendMoreBtn)];
        }else{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:nil];
        }
    }else{//群聊
        UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [detailButton setImage:[UIImage imageNamed:@"group_detail"] forState:UIControlStateNormal];
        [detailButton addTarget:self action:@selector(showGroupDetailAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        self.messageTimeIntervalTag = -1;
        [self.conversation deleteAllMessages];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
    }
}

#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}

- (void)messageViewController:(EaseMessageViewController *)viewController
   didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
//    UserProfileViewController *userprofile = [[UserProfileViewController alloc] initWithUsername:messageModel.message.from];
//    [self.navigationController pushViewController:userprofile animated:YES];
}

- (void)messageViewController:(EaseMessageViewController *)viewController
               selectAtTarget:(EaseSelectAtTargetCallback)selectedCallback
{
    _selectedCallback = selectedCallback;
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:self.conversation.conversationId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:self.conversation.conversationId];
    }
    
    if (chatGroup) {
        if (!chatGroup.occupants) {
            __weak ChatViewController* weakSelf = self;
            [self showHudInView:self.view hint:@"Fetching group members..."];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                EMGroup *group = [[EMClient sharedClient].groupManager fetchGroupInfo:chatGroup.groupId includeMembersList:YES error:&error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong ChatViewController *strongSelf = weakSelf;
                    if (strongSelf) {
                        [strongSelf hideHud];
                        if (error) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Fetching group members failed [%@]", error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else {
                            NSMutableArray *members = [group.occupants mutableCopy];
                            NSString *loginUser = [EMClient sharedClient].currentUsername;
                            if (loginUser) {
                                [members removeObject:loginUser];
                            }
                            if (![members count]) {
                                if (strongSelf.selectedCallback) {
                                    strongSelf.selectedCallback(nil);
                                }
                                return;
                            }
//                            ContactSelectionViewController *selectController = [[ContactSelectionViewController alloc] initWithContacts:members];
//                            selectController.mulChoice = NO;
//                            selectController.delegate = self;
//                            [self.navigationController pushViewController:selectController animated:YES];
                        }
                    }
                });
            });
        }
        else {
            NSMutableArray *members = [chatGroup.occupants mutableCopy];
            NSString *loginUser = [EMClient sharedClient].currentUsername;
            if (loginUser) {
                [members removeObject:loginUser];
            }
            if (![members count]) {
                if (_selectedCallback) {
                    _selectedCallback(nil);
                }
                return;
            }
//            ContactSelectionViewController *selectController = [[ContactSelectionViewController alloc] initWithContacts:members];
//            selectController.mulChoice = NO;
//            selectController.delegate = self;
//            [self.navigationController pushViewController:selectController animated:YES];
        }
    }
}

#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
    
    model.failImageName = @"imageDownloadFail";
    return model;
}

- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
//    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];//去掉gif表情包
    
    return @[managerDefault];
}

- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
                                      messageModel:(id<IMessageModel>)messageModel
{
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}

#pragma mark - EaseMob

#pragma mark - EMClientDelegate

- (void)didLoginFromOtherDevice
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)didRemovedFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - action

- (void)backAction
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
//    [[ChatDemoHelper shareHelper] setChatVC:nil];
    
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:NO];
        }
    }
//    [self.headView closeTimer];//**关闭进度条计时器开启
    if (self.isPresentToVC || self.isOnline) {
        [self.view endEditing:YES];
        if (self.isPresentToVC) {
            //发送通知
            NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
            [center postNotificationName:@"chatToIntroduce" object:nil];
        }
        
        if (self.isMessageOnline) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)showGroupDetailAction
{
    [self.view endEditing:YES];
    if (self.conversation.type == EMConversationTypeGroupChat) {
//        ChatGroupDetailViewController *detailController = [[ChatGroupDetailViewController alloc] initWithGroupId:self.conversation.conversationId];
//        [self.navigationController pushViewController:detailController animated:YES];
    }
    else if (self.conversation.type == EMConversationTypeChatRoom)
    {
//        ChatroomDetailViewController *detailController = [[ChatroomDetailViewController alloc] initWithChatroomId:self.conversation.conversationId];
//        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)deleteAllMessages:(id)sender
{
    if (self.dataArray.count == 0) {
        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
        if (self.conversation.type != EMConversationTypeChat && isDelete) {
            self.messageTimeIntervalTag = -1;
            [self.conversation deleteAllMessages];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        }
    }
    else if ([sender isKindOfClass:[UIButton class]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alertView show];
    }
}

- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
//        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
//        ContactListSelectViewController *listViewController = [[ContactListSelectViewController alloc] initWithNibName:nil bundle:nil];
//        listViewController.messageModel = model;
//        [listViewController tableViewDidTriggerHeaderRefresh];
//        [self.navigationController pushViewController:listViewController animated:YES];
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation deleteMessageWithId:model.message.messageId];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        if ([self.dataArray count] == 0) {
            self.messageTimeIntervalTag = -1;
        }
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - notification
- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        [self addMessageToDataSource:message progress:nil];
        [[EMClient sharedClient].chatManager importMessages:@[message]];
    }
}

- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isViewDidAppear = NO;
    } else {
        //结束call
        self.isViewDidAppear = YES;
    }
}

#pragma mark - private

- (void)showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(EMMessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
    if (_transpondMenuItem == nil) {
        _transpondMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"transpond", @"Transpond") action:@selector(transpondMenuAction:)];
    }
    
    if (messageType == EMMessageBodyTypeText) {
        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem,_transpondMenuItem]];
    } else if (messageType == EMMessageBodyTypeImage){
        [self.menuController setMenuItems:@[_deleteMenuItem,_transpondMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}

#pragma mark - app操作方法

#pragma mark - 聊天导航栏按钮响应事件
-(ChatPhotoView *)photoView
{
    if (!_photoView) {
        _photoView = [[ChatPhotoView alloc] init];
        _photoView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _photoView.alpha = 0;
    }
    return _photoView;
}
-(ChatHeadView *)headView
{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle]loadNibNamed:@"ChatHeadView" owner:self options:nil] lastObject];
        _headView.frame = CGRectMake(0, 0, SystemScreenWidth, 50);
        _headView.SysDoctorID = self.SysDoctorID;
        _headView.iscollect = self.isCollect;
    }
    return _headView;
}
-(ChatNaviExpendView *)expendNaviView
{
    if (!_expendNaviView) {
        _expendNaviView = [[[NSBundle mainBundle]loadNibNamed:@"ChatNaviExpendView" owner:self options:nil] lastObject];
        _expendNaviView.alpha = 0;
        _expendNaviView.SysDoctorID = self.SysDoctorID;
        [_expendNaviView.detailBtnView setTarget:self action:@selector(clickDetail)];
        _expendNaviView.frame = CGRectMake(0, 0, SystemScreenWidth, SystemScreenHeight);
        
    }
    return _expendNaviView;
}


/**
 星级打分

 @return <#return value description#>
 */
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        _consultStarView.alpha = 0;
//    } completion:^(BOOL finished) {
//        //        [self removeFromSuperview];
//    }];
//    
//    
//}

-(BOOL)checkConsultStar
{

    if(_consultStarView.startNum == 0){
        [IanAlert alertError:@"请完成打分" length:1.5];
        return NO;
    }
    return YES;
}

-(XKConsultantstarView *)consultStarView
{
    if (!_consultStarView) {
        
        _consultStarView = [[XKConsultantstarView alloc]initWithFrame:CGRectMake(0, 0, SystemScreenWidth, SystemScreenHeight)];
        _consultStarView.delegate = self;
//         _consultStarView.alpha = 0;
        
    }

    return _consultStarView;

}

/**
 提交星级的代理

 @param startNum startNum
 */
-(void)consultantstarBack:(NSInteger)startNum;
{

     NSLog(@"%li星",startNum);
    
    
    [self loadSendArcData:startNum];

}

-(void)loadSendArcData:(NSInteger)startNum
{
    if (self.SysDoctorID.length == 0) {
        self.SysDoctorID = @"";
    }
    
    /*1.有对话产生  2.每日只能评价一次*/
    if (self.dataArray.count <= 0) {
          [IanAlert alertError:@"您还没有与医生进行咨询" length:1.5];
     return;
    }
    
    NSString *current_time = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"star_current_time%@",self.doctorNickName]];
    
    NSLog(@"star_current_time--%@-%@",current_time,[NSDate compareDate:current_time]);
    
    if ([[NSDate compareDate:current_time] isEqualToString:@"今天"]) {
        [IanAlert alertError:@"您已经对该医生进行评价" length:1.5];
        return;
    }

    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[NSNumber numberWithInteger:[UserInfoTool getLoginInfo].MemberID],@"SysDoctorID":[NSNumber numberWithInteger:[self.SysDoctorID integerValue]],@"GradeLevel":[NSNumber numberWithInteger:startNum],@"CommentContent":@""};
    
    //    [[XKLoadingView shareLoadingView] showLoadingText:@"发送中..."];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"423" parameters:dict success:^(id json) {
      XKLOG(@"423评论的星级成功%@",dict)
        ;
        NSDictionary *dic=(NSDictionary *)json;
        NSString *status = [NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]];
        if ([status isEqualToString:@"200"]) {
            [[XKLoadingView shareLoadingView] hideLoding];
            [IanAlert alertSuccess:@"感谢你的评价！" length:1.0];
            
            //记录当天第一次推送的时间
            [[NSUserDefaults standardUserDefaults]setObject:[NSDate dateTostring:[NSDate date]] forKey:[NSString stringWithFormat:@"star_current_time%@",self.doctorNickName]];;
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else{
            if ([status isEqualToString:@"105"]) {
                [[XKLoadingView shareLoadingView] errorloadingText:@"签名错误,签名验证未通过" ];
            }else{
                [[XKLoadingView shareLoadingView] errorloadingText:@"评论星级失败" ];
            }
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:error];
    }];
}



-(XKArchiveTransetionDelegateModel *)archiveCoverDelegate{
    if (!_archiveCoverDelegate) {
        _archiveCoverDelegate=[[XKArchiveTransetionDelegateModel alloc]init];
    }
    return _archiveCoverDelegate;
}
//点击详细资料
-(void)clickDetail
{
//    if (self.isPresentToVC) {
//        [self backAction];
//    }else{
        AdviserIntroduceViewController2 *vc = [[AdviserIntroduceViewController2 alloc]init];
        vc.SysDoctorID = self.SysDoctorID;
        vc.isFromChat = YES;
        XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:vc];
        nav.transitioningDelegate=(id)self.archiveCoverDelegate;
        nav.modalPresentationStyle=UIModalPresentationCustom;
        [self presentViewController:nav animated:YES completion:nil];
//    }
}

//**环信--聊天导航栏按钮响应事件
-(void)expendMoreBtn
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.expendNaviView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.expendNaviView.alpha = 1;
    }];
}


-(void)consultStarBtn{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.consultStarView.alpha = 1.0;
    [window addSubview:self.consultStarView];
    
    

}

//增加头部的View
-(void)addProgressHeadView
{
    if (!isHeadShow) {
       [self.view addSubview:self.headView];
        isHeadShow = YES;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);//**环信--tableView向下移动
//    self.tableView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0];
    
//    [self.headView  openTimer];//**开启计时器;在需要的时候开启
}

-(void)addPhotoView
{
    if ([self isShowPhotoView]) {

        self.photoView.chatImgPickerVC.delegate = self;
        [self.photoView.closeBtn addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
        self.photoView.alpha = 1;
        [self addChildViewController:self.photoView.chatImgPickerVC];
        [self.view addSubview:self.photoView];
    
    }
}

//判断是否超过24小时
-(BOOL)isShowPhotoView
{
    if (self.isOnline) {
        return NO;
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *chatTime = [user objectForKey:[NSString stringWithFormat:@"%@chatTime%@",[UserInfoTool getLoginInfo].UserAccount , self.easeDoctorID]];
//    NSLog(@"chatTime:%@", chatTime);
    
    Dateformat  *dateF = [[Dateformat alloc] init];
    NSString *s = [dateF DateFormatWithDate:chatTime withFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate  *startdate = [formater dateFromString:s];
    
    //当前时间一天之后的时间，用秒来计算 24 * 60 *60，之前的时间用负数
    NSDate *date1 = [[NSDate alloc]initWithTimeInterval:24 * 60 *60 sinceDate:startdate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //时区查，需转换
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *laterStr = [formatter stringFromDate:date1];
    
    NSString *oneDayTime = [dateF timeSpWithDate:laterStr withFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSLog(@"oneDayTime:%@",oneDayTime);
    
    NSString *now = [dateF timeSpWithDate:[dateF getDateTime][@"sumtime"]  withFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSLog(@"now:%@", now);
    
    if ([oneDayTime integerValue] < [now integerValue] || chatTime.length == 0) {
        return YES;
    }
    
    return NO;
}

#pragma mark - ChatPhotoViewControllerDelegate
-(void)clickSureWithBigImageArray:(NSArray *)bigImageArray andBigImageDataArray:(NSArray *)bigImageDataArray andSmallImageArray:(NSArray *)smallImageArray andSmallImageDataArray:(NSArray *)smallImageDataArray andText:(NSString *)text
{
    [self sendTextMessage:text];
    for (UIImage *image in bigImageArray) {
        [self sendImageMessage:image];
    }
    //得到大图数组，大图数据数组，小图数组，小图数据数组
    NSLog(@"%@ -- %@",bigImageArray,text);
    
    [self photoCloseAction];
    
}

-(void)clickClose
{
    [self photoCloseAction];
}

-(void)photoCloseAction
{
    [self.photoView removeFromSuperview];
    [naviView removeFromSuperview];
    isRemovePhotoView = YES;
    
    //存入信息
    Dateformat  *dateF = [[Dateformat alloc] init];
    NSString *nowTime = [dateF timeSpWithDate:[dateF getDateTime][@"sumtime"]  withFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSLog(@"nowTime:%@", nowTime);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:nowTime forKey:[NSString stringWithFormat:@"%@chatTime%@",[UserInfoTool getLoginInfo].UserAccount , self.easeDoctorID]];//**存入本地 用户的用户名 、 医生的用户名
}


@end
