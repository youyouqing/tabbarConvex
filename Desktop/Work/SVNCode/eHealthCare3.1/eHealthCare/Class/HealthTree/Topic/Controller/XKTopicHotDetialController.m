//
//  XKTopicHotDetialController.m
//  eHealthCare
//
//  Created by jamkin on 2017/6/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKTopicHotDetialController.h"
#import "XKHotTopicTableViewCell.h"
#import "XKTopicHotDetialCell.h"
#import "XKFirstCommtentModel.h"
#import "XKSecondeCommtentModel.h"
#import "XKInformationCancelView.h"
#import "TZImagePreviewController.h"
#import "XKVideoBigView.h"
#import "XKTopicHotBigView.h"
@interface XKTopicHotDetialController ()<UITableViewDelegate,UITableViewDataSource,XKTopicHotDetialCellDelegate,UITextFieldDelegate,XKInformationCancelViewDelegate>
@property (strong, nonatomic)XKTopicHotBigView *bigPhoto;
@property (strong, nonatomic)XKVideoBigView *videoBigView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@property (weak, nonatomic) IBOutlet UITableView *detialTable;

/**
 当前以及评论页数的下标
 */
@property (nonatomic,assign) NSInteger pageIndex;

/**
 当前话题
 */
@property (nonatomic,strong)XKTopicModel *currentModel;

@property (nonatomic,strong)NSMutableArray *dataArray;

/**
 文本视图容器
 */
@property (weak, nonatomic) IBOutlet UIView *txtContianerview;

/**
 文本视图
 */
@property (weak, nonatomic) IBOutlet UITextField *txtfiled;

/**
 控制对话题评论的标示
 */
@property (nonatomic,assign) NSInteger topicBrand;

/**
 控制对一级评论的标示
 */
@property (nonatomic,assign) NSInteger firstBrand;

/**
 控制回复话题的标示
 */
@property (nonatomic,assign) NSInteger secondeBrand;

/**
 一级评论的保存
 */
@property (nonatomic,strong) XKFirstCommtentModel *saveFirst;

/**二级评论的保存*/
@property (nonatomic,strong) XKSecondeCommtentModel *saveSeconde;

/**
 评论输入框
 */
@property (strong, nonatomic)  XKInformationCancelView *backView;

@property (weak, nonatomic) IBOutlet UIView *keyContainerV;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;


@end

@implementation XKTopicHotDetialController
-(XKTopicHotBigView *)bigPhoto
{
    if (!_bigPhoto) {
        _bigPhoto = [[[NSBundle mainBundle] loadNibNamed:@"XKTopicHotBigView" owner:self options:nil] lastObject];
        _bigPhoto.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        
    }
    return _bigPhoto;
}
-(XKVideoBigView *)videoBigView
{
    if (!_videoBigView) {
        _videoBigView = [[[NSBundle mainBundle] loadNibNamed:@"XKVideoBigView" owner:self options:nil] lastObject];
        _videoBigView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        
    }
    return _videoBigView;
}
- (XKInformationCancelView *)backView
{
    if (_backView == nil) {
        
        _backView = [[NSBundle mainBundle]loadNibNamed:@"XKInformationCancelView" owner:nil options:nil].firstObject;
        _backView.left = 0;
        _backView.top = 0.5;
        _backView.width = self.view.frame.size.width;
        _backView.height = 60.5f;
        _backView.isTopic = YES;

    }
    return _backView;
}
- (void)deleteDataUpdateHeghtAction;
{
    if (self.backView.selectedPhotos.count==0) {
        self.backView.pCollectionHeight.constant = 0;
        self.bottomCons.constant = 146.5f+self.backView.pCollectionHeight.constant;
    }
    
}
- (void)finishPicturePopTextViewAction{
    
    if (self.backView.selectedPhotos.count>0) {
        [self.backView.myTextView becomeFirstResponder];
    }
    
}
-(void)popToUpViewController
{
    if (_didRefreshPageBlock) {
        _didRefreshPageBlock(YES);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//实现接收到通知时的操作
-(void) keyBoardChange:(NSNotification *)note

{
    //获取键盘弹出或收回时frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //获取键盘弹出所需时长
    float duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //添加弹出动画
    [UIView animateWithDuration:duration animations:^{
        self.keyContainerV.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - (KScreenHeight));
        
        if (keyboardFrame.origin.y == KScreenHeight) {
            
            self.backView.cancelBtn.hidden = YES;
            
           self.backView.pCollectionView.hidden =   self.backView.pictureBtn.hidden = self.backView.sureBtn.hidden = YES;
            
            self.bottomCons.constant = 60.5f;
            
            self.backView.myTextViewTop.constant = 10;

            self.backView.textViewLabTop.constant = 20.f;
            self.backView.textViewLal.text = @"我也说一句~";
        }
        else
        {
            
            self.backView.cancelBtn.hidden = NO;
            
             self.backView.sureBtn.hidden = NO;
            
            if (self.firstBrand== 2) {
                 NSLog(@"回复一级评论");
                 self.backView.pCollectionHeight.constant = 0;
                 self.backView.pCollectionView.hidden =  self.backView.pictureBtn.hidden = YES;
              
            }else if(self.secondeBrand == 2){
                NSLog(@"对话");
                self.backView.pCollectionHeight.constant = 0;
                self.backView.pCollectionView.hidden =  self.backView.pictureBtn.hidden = YES;
            }else{
                NSLog(@"直接评论话题");
                if (self.backView.selectedPhotos.count>0) {
                    self.backView.pCollectionHeight.constant = 73;
                }else
                    self.backView.pCollectionHeight.constant = 0;
                
                self.backView.pCollectionView.hidden =  self.backView.pictureBtn.hidden = NO;
            }
            
          
            self.bottomCons.constant = 146.5f+self.backView.pCollectionHeight.constant;
            
            self.backView.myTextViewTop.constant = 47;
            
            self.backView.textViewLabTop.constant = 52;
            
        }
        
        
    }];
    
}

#pragma mark   xkInformationDelegate
- (void)cancelForClicked;
{
//    [self.view endEditing:YES];
    self.firstBrand =1;
    self.secondeBrand = 1;
    self.backView.textViewLal.hidden = NO;
    self.backView.myTextView.hidden = NO;
    self.backView.textViewLal.text = @"我也说一句～";
    [self.backView.myTextView resignFirstResponder];
   

}
//拍照。
- (void)takePicktureBtn;
{
    
    
}


- (void)sureForClickedAction:(NSString *)topicString;
{
    
//    if (topicString.length<=0) {
//        [IanAlert alertError:@"请输入数据" length:1.0];
//        return;
//    }
    [self updateComment:topicString];
        
//    self.backView.textViewLal.hidden = NO;
//    self.backView.myTextView.text = @"";
//    //        [self bringSubviewToFront:self.myTextView];
//    //        [self bringSubviewToFront:self.textViewLal];
//    [self.backView.myTextView resignFirstResponder];
//    [self.backView.txtField resignFirstResponder];
    
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitle = @"话题详情";
    self.topCons.constant = (PublicY);
    self.topicBrand = 1;
    self.firstBrand = 1;
    self.secondeBrand = 1;
    self.backView.delegate = self;
//    self.txtfiled.delegate = self;
    
    self.txtContianerview.layer.cornerRadius = 5;
    self.txtContianerview.layer.masksToBounds = YES;
    
    self.detialTable.delegate = self;
    self.detialTable.dataSource = self;
    
    self.detialTable.showsVerticalScrollIndicator = NO;
    self.detialTable.showsHorizontalScrollIndicator = NO;
    
    //预设cell高度
    self.detialTable.estimatedRowHeight = 100;
    
    self.detialTable.tableFooterView = [UITableView new];
    
    //打开自动计算行高
    self.detialTable.rowHeight = UITableViewAutomaticDimension;
    
    [self.detialTable registerNib:[UINib nibWithNibName:@"XKTopicHotDetialCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.detialTable registerNib:[UINib nibWithNibName:@"XKHotTopicTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
   
    self.pageIndex = 1;
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.detialTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewTopics)];
    //        // 自动改变透明度
    //        self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    [self.topicTable.mj_header beginRefreshing];
    
    self.detialTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreTopics)];
    
    [self loadData:1 withIsFresh:YES];
    
    
    [self.detialTable sendSubviewToBack:self.view];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];//健康监听通知
    
    
    [self.keyContainerV addSubview:self.backView];

    self.backView.width = CGRectGetWidth(self.keyContainerV.frame);
    
    //去掉评论是按钮键盘的完成
    self.backView.myTextView.inputAccessoryView = [UIView new];
    //改变系统线条颜色
    [self.detialTable setSeparatorColor:[UIColor getColor:@"d8d8d8"]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadData:1 withIsFresh:YES];

}

-(void)setIsOther:(BOOL)isOther{
    
    _isOther = isOther;
    if (_isOther) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark - 事件处理
- (void)_loadNewTopics
{
    
    [self loadData:1 withIsFresh:NO];
    
}

- (void)_loadMoreTopics
{
    
    [self loadData:2 withIsFresh:NO];
    
}

#pragma mark   请求数据变更
-(void)loadData:(NSInteger)mothed withIsFresh:(BOOL)isf{
    
    if (isf) {
        
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        
    }
    
    NSInteger pageSize=8;
    
    if (mothed==1) {//刷新
        
        pageSize=8;//self.dataArray.count>8?self.dataArray.count:8;
        self.pageIndex = 1;
    }else{//加载更多
        
        pageSize=8;
        
        self.pageIndex++;
        
    }
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"902" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"TopicID":@(self.modelID),@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"PageIndex":@(self.pageIndex),@"PageSize":@(pageSize)} success:^(id json) {
        
        NSLog(@"902----%@",json);
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            
            [[XKLoadingView shareLoadingView] hideLoding];
            
            self.currentModel = [XKTopicModel objectWithKeyValues:[json objectForKey:@"Result"][@"TopicDetailEntity"]];
            
            NSArray *arr =  [XKFirstCommtentModel objectArrayWithKeyValuesArray:[json objectForKey:@"Result"][@"FirstCommentList"]];
            
            if (mothed==1) {
                
                self.dataArray = (NSMutableArray *)arr;
                
            }else{
                
                if (self.pageIndex==1) {
                    
                    self.dataArray = (NSMutableArray *)arr;
                    
                }else{
                    
                    [self.dataArray addObjectsFromArray:arr];
                }
                
            }
            
            
            [self.detialTable reloadData];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//               [self.detialTable reloadData];
//            });
            
            [self.detialTable.mj_header endRefreshing];
            // 结束刷新
            [self.detialTable.mj_footer endRefreshing];
            
            
            if (self.dataArray.count>=[[json objectForKey:@"Rows"] integerValue]) {
                
                [self.detialTable.mj_footer endRefreshingWithNoMoreData];
                
                if (self.pageIndex > 1) {
                    self.pageIndex --;
                }

            }
                        
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:nil];
            [self.detialTable.mj_header endRefreshing];
            // 结束刷新
            [self.detialTable.mj_footer endRefreshing];
        }
        
    } failure:^(id error) {
        
        NSLog(@"%@",error);
        [[XKLoadingView shareLoadingView]errorloadingText:nil];
        [self.detialTable.mj_header endRefreshing];
        // 结束刷新
        [self.detialTable.mj_footer endRefreshing];
    }];
    
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    [self updateComment:textField.text];
//
//    self.firstBrand =1;
//    self.secondeBrand = 1;
//    
//    textField.text = @"";
//    
//    return YES;
//}

-(void)updateComment:(NSString *)content{

    if ([content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0) {
        
        ShowErrorStatus(@"既然来了、留个💗情再走吧");
        [[XKLoadingView shareLoadingView] hideLoding];
        
        return;
        
    }
    if ([content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length <5) {
        
        ShowErrorStatus(@"请输入评论超过5个字");
        [[XKLoadingView shareLoadingView] hideLoding];
        
        return;
        
    }
    if (content.length >50) {
        
        ShowErrorStatus(@"您的💗情也太多了吧！");
        [[XKLoadingView shareLoadingView] hideLoding];
        return;
        
    }
    

    dispatch_group_t downloadGroup = dispatch_group_create();
    static NSString *TopicImgUrlTempStr = @"";
    [[XKLoadingView shareLoadingView]showLoadingText:nil];

    for (PHAsset *imagePH in self.backView.selectedAssets) {
        dispatch_group_enter(downloadGroup);
        [[TZImageManager manager] requestImageDataForAsset:imagePH completion:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            NSString *str=[imageData base64EncodedStringWithOptions:0];
            NSMutableString *mstr=[[NSMutableString alloc]initWithString:str];
            NSString *ss=[mstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ProtosomaticHttpTool protosomaticPostWithURLString:@"947" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"HeadBinary":ss} success:^(id json) {
                    
                    dispatch_group_leave(downloadGroup);
                    //                [[XKLoadingView shareLoadingView]hideLoding];
                    if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
                        if (TopicImgUrlTempStr.length<=0) {
                            //                        TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@", json[@"Result"]];
                            TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@;%li,%li", json[@"Result"],imagePH.pixelWidth,imagePH.pixelHeight];
                            
                        }else
                            //                        TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@|%@", TopicImgUrlTempStr,json[@"Result"]];
                            TopicImgUrlTempStr  = [NSString stringWithFormat:@"%@|%@;%li,%li", TopicImgUrlTempStr,json[@"Result"],imagePH.pixelWidth,imagePH.pixelHeight];
                        NSLog(@"-Detail-947--%@---%@",json,TopicImgUrlTempStr);
                    }else{
                        
                    }
                    
                } failure:^(id error) {
                    
                    [[XKLoadingView shareLoadingView]hideLoding];
                    
                    
                }];
            });

        } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
            NSLog(@"--info--%@",info);
        }];
        
        
        
        
    }

     dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
         
         NSDictionary *dict;
         NSString *str= @"";
         if (self.firstBrand== 2) {
             NSLog(@"回复一级评论");
             dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(1),@"TopicID":@(self.saveFirst.ReplyID),@"ParentID":@(self.saveFirst.ReplyID),@"TotalID":@(self.currentModel.TopicID),@"ReplyContent":content,@"ReplyImgUrl":@""};
             str = @"回复成功";
         }else if(self.secondeBrand == 2){
             NSLog(@"对话");
             dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(1),@"TopicID":@(self.saveFirst.ReplyID),@"ParentID":@(self.saveSeconde.ReplyID),@"TotalID":@(self.currentModel.TopicID),@"ReplyContent":content,@"ReplyImgUrl":@""};
             str = @"回复成功";
         }else{
             NSLog(@"直接评论话题");
             dict = @{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"TypeID":@(1),@"TopicID":@(self.currentModel.TopicID),@"ParentID":@(0),@"TotalID":@(self.currentModel.TopicID),@"ReplyContent":content,@"ReplyImgUrl":TopicImgUrlTempStr};
             str = @"评论成功";
         }
         NSLog(@"%@",dict);
    [[XKLoadingView shareLoadingView] showLoadingText:nil];
    //获取首页健康计划、热门话题数据
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"903" parameters:dict success:^(id json) {
        
        NSLog(@"%@",json);
        
        [[XKLoadingView shareLoadingView] hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
             ShowSuccessStatus(str );
            
            [self loadData:1 withIsFresh:YES];
            self.firstBrand =1;
            self.secondeBrand = 1;
            [self.backView.selectedAssets removeAllObjects];
            [self.backView.selectedPhotos removeAllObjects];
            TopicImgUrlTempStr = @"";

        }else{
           [[XKLoadingView shareLoadingView] errorloadingText:@"评论失败"];
        }
        
    } failure:^(id error) {
        [[XKLoadingView shareLoadingView] errorloadingText:@"评论失败"];
        NSLog(@"%@",error);
        
    }];
     });
}

-(void)detailChangeTopicDataSoure:(XKFirstCommtentModel *)model{
    
    for (int i= 0; i< self.dataArray.count; i++) {
        XKFirstCommtentModel *topic = self.dataArray[i];
        if (topic == model) {
            [self.dataArray replaceObjectAtIndex:i withObject:model];
            [self.detialTable reloadData];
            break;
        }
        
    }
    
}

/**
 评论回复代理方法
 */
-(void)replySecondeCommtent:(XKFirstCommtentModel *)firstModel withSeconde:(XKSecondeCommtentModel *)secondeModel{
    
    self.secondeBrand = 2;
    
    self.saveFirst = firstModel;
    self.saveSeconde = secondeModel;
    
    [self.backView.myTextView becomeFirstResponder];
    
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复：%@",secondeModel.RNickName];
//    [self.txtfiled becomeFirstResponder];
    
}

/**
 一级评论回复的代理方法
 */
-(void)commtentFistReply:(XKFirstCommtentModel *)firstModel{
    
    self.firstBrand = 2;
    
    self.saveFirst = firstModel;
    
    [self.backView.myTextView becomeFirstResponder];
    
    self.backView.textViewLal.text = [NSString stringWithFormat:@"回复：%@",firstModel.NickName];
    
//    [self.txtfiled becomeFirstResponder];
    
}

-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.currentModel?1:0;
    }
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        XKHotTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.model = self.currentModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
        
    }
    
    XKTopicHotDetialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.topicModel = self.currentModel;
    cell.model = self.dataArray[indexPath.row];
    
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.05;
    }else{
        return 10;
    }
    
}
-(void)jumpTopTopicBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
{


    if (publishFlag == 1) {
        self.bigPhoto.photoSizeArray = sizeArr;

        self.bigPhoto.photoArray = photoArray;
        self.bigPhoto.currentPage = page;
        [[UIApplication sharedApplication].keyWindow addSubview:self.bigPhoto];
    }else if (publishFlag == 2)
    {
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBigView];
        
    }
    //    XKVideoBigView *video = [[[NSBundle mainBundle] loadNibNamed:@"XKVideoBigView" owner:self options:nil] lastObject];
}
-(void)jumpTopXKHotTopicChildCellBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
{
    if (publishFlag == 1) {
        self.bigPhoto.photoSizeArray = sizeArr;
        
        self.bigPhoto.photoArray = photoArray;
        self.bigPhoto.currentPage = page;
        [[UIApplication sharedApplication].keyWindow addSubview:self.bigPhoto];
    }else if (publishFlag == 2)
    {
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBigView];
        
    }
    
    
}
-(void)jumpTopXKHotTopicDetailBigPhoto:(NSArray *) photoArray  sizeArr:(NSArray *) sizeArr withPage:(NSInteger) page publishFlag:(NSInteger)publishFlag;
{
    
//    if (publishFlag == 1) {
        self.bigPhoto.photoSizeArray = sizeArr;
        
        self.bigPhoto.photoArray = photoArray;
        self.bigPhoto.currentPage = page;
        [[UIApplication sharedApplication].keyWindow addSubview:self.bigPhoto];
//    }else if (publishFlag == 2)
//    {
//
//
//        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBigView];
//
//    }
}
@end
