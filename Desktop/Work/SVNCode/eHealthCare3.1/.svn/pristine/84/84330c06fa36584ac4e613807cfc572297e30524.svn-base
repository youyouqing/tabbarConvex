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

#import "ConversationListController.h"

#import "ChatViewController.h"
//#import "EMSearchBar.h"
//#import "EMSearchDisplayController.h"
//#import "RobotManager.h"
//#import "RobotChatViewController.h"
//#import "UserProfileManager.h"
//#import "RealtimeSearchUtil.h"
//#import "RedPacketChatViewController.h"
//#import "ChatDemoHelper.h"

@implementation EMConversation (search)

//根据用户昵称,环信机器人名称,群名称进行搜索
- (NSString*)showName
{
    if (self.type == EMConversationTypeChat) {
//        if ([[RobotManager sharedInstance] isRobotWithUsername:self.conversationId]) {
//            return [[RobotManager sharedInstance] getRobotNickWithUsername:self.conversationId];
//        }
//        return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.conversationId];
    } else if (self.type == EMConversationTypeGroupChat) {
        if ([self.ext objectForKey:@"subject"] || [self.ext objectForKey:@"isPublic"]) {
            return [self.ext objectForKey:@"subject"];
        }
    }
    return self.conversationId;
}

@end

@interface ConversationListController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource,UISearchDisplayDelegate, UISearchBarDelegate,EMChatManagerDelegate>

@property (nonatomic, strong) UIView *networkStateView;
//@property (nonatomic, strong) EMSearchBar           *searchBar;
//
//@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ConversationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self tableViewDidTriggerHeaderRefresh];
    
//    [self.view addSubview:self.searchBar];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self networkStateView];
    
//    [self searchController];
    
    [self removeEmptyConversationsFromDB];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations deleteMessages:YES];
    }
}

#pragma mark - getter
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - EMChatManagerDelegate收到消息回调**
- (void)didReceiveMessages:(NSArray *)aMessages
{
    [self tableViewReceiveMessageRefresh];
}

#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
//            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//                RobotChatViewController *chatController = [[RobotChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//                chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//                [self.navigationController pushViewController:chatController animated:YES];
//            } else {
#ifdef REDPACKET_AVALABLE
                RedPacketChatViewController *chatController = [[RedPacketChatViewController alloc]
#else
                ChatViewController *chatController = [[ChatViewController alloc]
#endif
                                                      initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//                chatController.title = conversationModel.title;
                //**取到客服的id
                //从135接口获得客服id
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSDictionary *dic = [user objectForKey:@"XKPersonmineInfo"];
                NSString *easeId = dic[@"Result"][@"ServiceAccount"];
                if([conversation.conversationId isEqualToString:easeId]){
                    chatController.isOnline = YES;
                    chatController.isMessageOnline = YES;
                }
                [[UserEaseInfoManager shareInstance] getNicknameByUserNameDic:conversation.conversationId cellInfoDic:^(id json) {
                    NSDictionary *userDic = (NSDictionary *)json;
                    UserEaseInfoModel *doctorModel = [UserEaseInfoModel objectWithKeyValues:userDic];
                    //客服账号的vc的title改为客服，其他的为医生名称
                    if([conversation.conversationId isEqualToString:easeId]){
                        chatController.title = @"客服";
                    }else{
                        chatController.title = doctorModel.Name;
                        chatController.doctorNickName = doctorModel.Name;
                    }
                    chatController.onlineStaus = doctorModel.OnLineStatus;
                    chatController.SysDoctorID = [NSString stringWithFormat:@"%li",doctorModel.SysDoctorId];
                    
                    //本地获取收藏的信息
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    NSString *collectStr = [ud objectForKey:[NSString stringWithFormat:@"%licollect",doctorModel.SysDoctorId]];
                    if(collectStr.length == 0 || collectStr == nil){
                       chatController.isCollect = (doctorModel.CollectFlag == 1) ?YES:NO;
                    }else{
                        chatController.isCollect = ([collectStr isEqualToString:@"1"]) ? YES:NO;
                    }
                    NSLog(@"chatController.isCollect:%d",chatController.isCollect);
                    chatController.easeDoctorID = doctorModel.UserAccount;
                    [self.navigationController pushViewController:chatController animated:YES];
                }];
//            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
    }
}
                                                
#pragma mark - EaseConversationListViewControllerDataSource

-(NSAttributedString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    //**发送通知，更新tabbar的未读消息数角标
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        NSString *latestMessageTitle = @"";
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
        
        if (lastMessage.direction == EMMessageDirectionReceive) {
            NSString *from = lastMessage.from;//消息从哪里来
//            latestMessageTitle = [NSString stringWithFormat:@"%@: %@", from, latestMessageTitle];//
            latestMessageTitle = [NSString stringWithFormat:@"%@",latestMessageTitle];
        }
        
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
        
    }
    return attributedStr;
}
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }

    
    return latestMessageTime;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    __weak typeof(self) weakSelf = self;
//    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataArray searchText:(NSString *)searchText collationStringSelector:@selector(title) resultBlock:^(NSArray *results) {
//        if (results) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.searchController.resultsSource removeAllObjects];
//                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
//                [weakSelf.searchController.searchResultsTableView reloadData];
//            });
//        }
//    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
//    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - public

-(void)refresh
{
    [self refreshAndSortView];
    [self tableViewReceiveMessageRefresh];
}

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

@end
