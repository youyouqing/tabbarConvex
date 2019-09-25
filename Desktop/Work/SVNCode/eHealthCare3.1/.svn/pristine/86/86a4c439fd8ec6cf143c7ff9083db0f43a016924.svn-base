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

#import "EaseConversationListViewController.h"

#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseMessageViewController.h"
#import "NSDate+Category.h"
#import "EaseLocalDefine.h"
#import "MessagePublicCell.h"
//#import "PublicNoticeViewController.h"
#import "NewPublicViewController.h"
#import "MessagePublicModel.h"

@interface EaseConversationListViewController ()
{
    BOOL isFirst;
}

@property (nonatomic, strong) MessagePublicModel *publicModel;
@property (nonatomic, strong) MessagePublicModel *sysModel;
@property (nonatomic, strong) NSMutableArray *publicDataArr;
@end

@implementation EaseConversationListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.publicModel = [[MessagePublicModel alloc]init];
    self.sysModel = [[MessagePublicModel alloc]init];
    self.publicDataArr = [[NSMutableArray alloc] init];
    [self loadPublicFromBase];//读取公告缓存的数据
//    [self loadPublicData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readRefresh) name:@"ReadRefresh" object:nil];
}
-(void)readRefresh
{
    [self loadPublicData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取数据
-(void)loadPublicFromBase
{
    if ([[EGOCache globalCache] hasCacheForKey:@"messagePublicDic"]) {
        NSDictionary *dic = (NSDictionary *) [[EGOCache globalCache]objectForKey:@"messagePublicDic"];
        [self dealWithPublicDic:dic];
        [self.tableView reloadData];
    }
}

-(void)loadPublicData
{
    NSDictionary *dict=@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":[NSNumber numberWithInteger:[UserInfoTool getLoginInfo].MemberID],@"PageIndex":@1,@"PageSize":@10};
   
//    [[XKLoadingView shareLoadingView]showLoadingText:@"努力加载中..."];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"116" parameters:dict success:^(id json) {
        XKLOG(@"消息列表--公告系统消息116：%@",json);
        NSDictionary *dic=(NSDictionary *)json;
        if ([[NSString stringWithFormat:@"%@",dic[@"Basis"][@"Status"]] isEqualToString:@"200"]) {
            [[XKLoadingView shareLoadingView] hideLoding];
            //得到数据，删除数组中的数据
            [self.publicDataArr removeAllObjects];
            
            [self dealWithPublicDic:dic];
            
            [self.tableView reloadData];
            
            //缓存
            [[EGOCache globalCache]setObject:dic forKey:@"messagePublicDic"];
            
        }else{
            [[XKLoadingView shareLoadingView] errorloadingText:@"加载失败"];
        }
        
    } failure:^(id error) {
        
        XKLOG(@"%@",error);
        [[XKLoadingView shareLoadingView] errorloadingText:error];
    }];
}
//处理公告数据
-(void)dealWithPublicDic:(NSDictionary *)dic
{
    //存数据
    //公告
    self.publicModel.NoticeTitle = dic[@"Result"][@"NewNotice"][@"NoticeTitle"];
    self.publicModel.NoticeCreateTime = dic[@"Result"][@"NewNotice"][@"CreateTime"];
    self.publicModel.NoticeReadNum = [dic[@"Result"][@"NewNotice"][@"ReadNum"] integerValue];
    self.publicModel.indexs = @"0";
    
    //健康消息
    self.sysModel.NoticeTitle = dic[@"Result"][@"NewHealthNotice"][@"NoticeTitle"];
    self.sysModel.NoticeCreateTime = dic[@"Result"][@"NewHealthNotice"][@"NoticeTime"];
    self.sysModel.NoticeReadNum = [dic[@"Result"][@"NewHealthNotice"][@"NoticeNoReadNum"] integerValue];
    self.sysModel.indexs = @"1";
    
    [self.publicDataArr addObject:self.publicModel];
    [self.publicDataArr addObject:self.sysModel];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.publicDataArr.count;
    }else{
        return [self.dataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //公告 -- 系统消息
        NSString *cellid = @"MessagePublicCell";
        MessagePublicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MessagePublicCell" owner:self options:nil] lastObject];
        }
        MessagePublicModel *model = self.publicDataArr[indexPath.row];
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.publicDataArr.count-1==indexPath.row) {
            cell.lineLab.hidden = YES;
        }
        return cell;
        
    }else{
        //医生消息
        NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
        EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if ([self.dataArray count] <= indexPath.row) {
            return cell;
        }
        
        id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row];
        cell.model = model;
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
            NSMutableAttributedString *attributedText = [[_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model] mutableCopy];
            [attributedText addAttributes:@{NSFontAttributeName : cell.detailLabel.font} range:NSMakeRange(0, attributedText.length)];
            cell.detailLabel.attributedText =  attributedText;
        } else {
            cell.detailLabel.attributedText =  [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:[self _latestMessageTitleForConversationModel:model]textFont:cell.detailLabel.font];
        }
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
            cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
        } else {
            cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
        }
        
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //公告
        return 90;
    }else{
        //医生消息
        return [EaseConversationCell cellHeightWithModel:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //公告
        XKLOG(@"section:%li, row:%li, 公告消息",indexPath.section,indexPath.row);
        NewPublicViewController *publicVC = [[NewPublicViewController alloc]init];
        if (indexPath.row == 0) {
            publicVC.isPublic = YES;
        }
        [self.navigationController pushViewController:publicVC animated:YES];
    }else{
        //医生消息
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:didSelectConversationModel:)]) {
            EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
            [_delegate conversationListViewController:self didSelectConversationModel:model];
        } else {
            EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
            EaseMessageViewController *viewController = [[EaseMessageViewController alloc] initWithConversationChatter:model.conversation.conversationId conversationType:model.conversation.type];
            viewController.title = model.title;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}
//删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [[EMClient sharedClient].chatManager deleteConversation:model.conversation.conversationId deleteMessages:YES];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //刷新未读条数
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];

    if (section == 1) {
        view.frame = CGRectMake(0, 0, SystemScreenWidth, 50);
        view.backgroundColor = COLOR(227, 235, 239, 1.0);
        view.backgroundColor =[UIColor colorWithWhite:0.95 alpha:1.0];
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, view.width, view.height  -10)];
        view1.backgroundColor = [UIColor whiteColor];
        [view addSubview:view1];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, view.frame.size.width - 30, view1.height-10)];
//        label.textColor = COLOR(149, 149, 149, 1.0); 
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = @"顾问消息";
        label.textColor = BLACKCOLOR;
        [view1 addSubview:label];
    }else{
        
    }
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return 50;
    }
}


#pragma mark - data

-(void)refreshAndSortView
{
    if ([self.dataArray count] > 1) {
        if ([[self.dataArray objectAtIndex:0] isKindOfClass:[EaseConversationModel class]]) {
            NSArray* sorted = [self.dataArray sortedArrayUsingComparator:
                               ^(EaseConversationModel *obj1, EaseConversationModel* obj2){
                                   EMMessage *message1 = [obj1.conversation latestMessage];
                                   EMMessage *message2 = [obj2.conversation latestMessage];
                                   if(message1.timestamp > message2.timestamp) {
                                       return(NSComparisonResult)NSOrderedAscending;
                                   }else {
                                       return(NSComparisonResult)NSOrderedDescending;
                                   }
                               }];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:sorted];
        }
    }
    [self.tableView reloadData];
}
//每次下拉刷新后的刷新
- (void)tableViewDidTriggerHeaderRefresh
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
                       }];
    
    
    
    [self.dataArray removeAllObjects];
    for (EMConversation *converstion in sorted) {
        EaseConversationModel *model = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
            model = [self.dataSource conversationListViewController:self
                                                   modelForConversation:converstion];
        }
        else{
            model = [[EaseConversationModel alloc] initWithConversation:converstion];
        }
        
        if (model) {
            [self.dataArray addObject:model];
        }
    }
    
    if (!isFirst) {
        //**得到username数组
        [[UserEaseInfoManager shareInstance]loadUserProfileWithEaseConversationModelArr:self.dataArray];
        isFirst = YES;
    }
    
    [self.tableView reloadData];
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
    
    [self loadPublicData];//**请求公告的接口
}

#pragma mark - 收到消息后的刷新，复制了代码新建的方法名，在消息回调方法中调用这个，为了和下拉刷新更新情况区别开
- (void)tableViewReceiveMessageRefresh
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
                       }];
    
    
    
    [self.dataArray removeAllObjects];
    for (EMConversation *converstion in sorted) {
        EaseConversationModel *model = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
            model = [self.dataSource conversationListViewController:self
                                               modelForConversation:converstion];
        }
        else{
            model = [[EaseConversationModel alloc] initWithConversation:converstion];
        }
        
        if (model) {
            [self.dataArray addObject:model];
        }
    }
    
    if (!isFirst) {
        //**得到username数组
        [[UserEaseInfoManager shareInstance]loadUserProfileWithEaseConversationModelArr:self.dataArray];
        isFirst = YES;
    }
    
    [self.tableView reloadData];
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
}


#pragma mark - EMGroupManagerDelegate

- (void)didUpdateGroupList:(NSArray *)groupList
{
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - private
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSEaseLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSEaseLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSEaseLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSEaseLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSEaseLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"HH:mm:ss"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
        NSLog(@"latestMessageTime:%@",latestMessageTime);
    }
    return latestMessageTime;
}

@end
