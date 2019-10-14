//
//  ProFileTopView.m
//  eHealthCare
//
//  Created by jamkin on 16/8/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ProFileTopView.h"


@interface ProFileTopView ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>{
    
    UIImagePickerController *_imagePickerController;
    
}
@property (weak, nonatomic) IBOutlet UIView *circleBackView;
/**康币总数量标签*/
@property (weak, nonatomic) IBOutlet UIButton *kangCoinTotalCountLab;

@property (weak, nonatomic) IBOutlet UIView *backGroundBottomView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeightCons;

- (IBAction)clickUserMessage:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation ProFileTopView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userIcon.layer.borderWidth = 2.f;
    self.userIcon.layer.cornerRadius=self.iconHeightCons.constant/2;
    self.userIcon.layer.masksToBounds=YES;
    self.nameLal.text = @"";
    self.nameLal.tintColor = [UIColor whiteColor];
    
    _imagePickerController=[[UIImagePickerController alloc]init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    self.nameLal.enabled = NO;
    self.nameLal.backgroundColor = [UIColor clearColor];
    self.nameLal.delegate = self;
    
    self.editBtn.layer.cornerRadius = self.editBtn.frame.size.height/2.0;
    self.editBtn.layer.masksToBounds = YES;
//    self.editBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.editBtn.layer.borderWidth = 1;
    self.nameLal.layer.cornerRadius = 13.5;
    self.nameLal.layer.masksToBounds = YES;
    self.nameLal.inputAccessoryView = [UIView new];

    
    self.circleBackView.layer.shadowColor = [UIColor colorWithRed:6/255.0 green:32/255.0 blue:21/255.0 alpha:0.2].CGColor;
     self.circleBackView.layer.shadowOffset = CGSizeMake(0,2);
     self.circleBackView.layer.shadowOpacity = 1;
     self.circleBackView.layer.shadowRadius = 10;
     self.circleBackView.layer.cornerRadius = 5;
}

-(void)setFreshDic:(NSDictionary *)freshDic{
    
    /*
     
     age : 23,
     sex : 男,
     img : <UIImage: 0x7fa5a405fe60> size {1239, 825} orientation 0 scale 1.000000,
     name : Dfsa
     **/
    
    self.nameLal.text=[NSString stringWithFormat:@"%@ %@",freshDic[@"name"],freshDic[@"sex"]];
    
    if (freshDic[@"img"]) {
        
        self.userIcon.image=freshDic[@"img"];
        
    }
}

-(void)setDic:(NSDictionary *)dic
{
    self.nameLal.backgroundColor = [UIColor clearColor];
    self.nameLal.enabled = NO;
    self.editBtn.hidden = NO;
  
    NSString *sex = @"";
    if (((NSString *)dic[@"Result"][@"Sex"]).length != 0) {
        sex = (NSString *)dic[@"Result"][@"Sex"];
    }else{
        sex = @"性别未知";
    }//([UserInfoTool getLoginInfo].Mobile.length>0？[UserInfoTool getLoginInfo].Mobile:
    NSString *headImag = @"iv_question_man";
    if ([sex isEqualToString:@"男"]) {
        headImag = @"iv_question_man";
    }else
        headImag = @"iv_question_female";
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"Result"][@"HeadImg"]] placeholderImage:[UIImage imageNamed:headImag]];
  
   
    self.nameLal.text = [((NSString *)dic[@"Result"][@"NickName"]) length] == 0 ? @"": (NSString *)dic[@"Result"][@"NickName"];
   
    NSNumber *age = dic[@"Result"][@"Age"];
    NSString  *ageStr = (age == nil)?@"年龄不详":[NSString stringWithFormat:@"%@ 岁",age];
/**展示健康币*/
    [self.kangCoinTotalCountLab setTitle:[NSString stringWithFormat:@"%li",[dic[@"Result"][@"Integral"] integerValue]] forState:UIControlStateNormal];
    
}

#pragma mark 上一版本用户信息修改
- (IBAction)clickUserMessage:(id)sender {
    
    NSLog(@"查看用户信息");
    [self.nameLal resignFirstResponder];
    if (![[UserInfoTool getLoginInfo].RecordNo isEqualToString:@"0"]) {

        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"个人资料已确定,不能修改" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *action=[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

            return ;

        }];

        [alertCon addAction:action];

        [[self parentController] presentViewController:alertCon animated:YES completion:nil];

    }

//    MineInfoViewController *mine=[[MineInfoViewController alloc]init];
//
//    XKNavigationController *nav=[[XKNavigationController alloc]initWithRootViewController:mine];
//
//    nav.transitioningDelegate=(id)self.modelDelegate;
//
//    nav.modalPresentationStyle=UIModalPresentationCustom;
//
//    [[self currentViewController] presentViewController:nav animated:YES completion:nil];
    
}

/**
 设置点击
 */
- (IBAction)clickMianMessage:(id)sender {
    
    [self.nameLal resignFirstResponder];
     NSLog(@"我的消息点击");

//
    /*清空角标信息*/
//    PersonalCenterViewController *c = (PersonalCenterViewController *)[self currentViewController] ;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         [c  requestMessageLab];
//    });
//
//    [[self currentViewController] presentViewController:nav animated:YES completion:nil];
//
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtnProFileTopView:)]) {
        [self.delegate clickBtnProFileTopView:6];
    }

}

- (IBAction)editNameAction:(id)sender {
    self.nameLal.enabled = YES;
    self.editBtn.hidden = YES;
    self.nameLal.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.nameLal becomeFirstResponder];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self whowOderMessage];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self editNickName:textField];
    
    return YES;
    
}

/**
 修改会员昵称
 */
-(void)editNickName:(UITextField *) textField{
    
    if ([NSString JudgeTheillegalCharacter:textField.text]) {
        ShowErrorStatus(@"昵称中不能含有特殊字符" );
        return;
    }

    if (textField.text.length == 0) {
        ShowErrorStatus(@"留下昵称再走吧！" );
        return;

    }else if (textField.text.length > 6){
        ShowErrorStatus(@"您的昵称过长了" );
        return;
    }

    if ([textField.text isEqualToString:@"请完善信息"]) {
        return;
    }

    if (textField.text.length > 0 && textField.text.length <= 6) {
        [[XKLoadingView shareLoadingView] showLoadingText:nil];
        [ProtosomaticHttpTool protosomaticPostWithURLString:@"925" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"NickName":textField.text} success:^(id json) {
            [[XKLoadingView shareLoadingView] hideLoding];
            NSLog(@"925:%@",json);
            if ([[NSString stringWithFormat:@"%@",json[@"Basis"][@"Status"]] isEqualToString:@"200"]) {

                [textField resignFirstResponder];//辞去第一响应者
                self.nameLal.backgroundColor = [UIColor clearColor];
                self.nameLal.enabled = NO;
                self.editBtn.hidden = NO;
            
                 ShowSuccessStatus(@"修改名称成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reGetUserMsgl" object:nil];//重新获取个人信息//重新获取个人信息
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter  defaultCenter] removeObserver:self name:@"reGetUserMsgl" object:nil];
                });
            }else{
                ShowErrorStatus(@"修改昵称失败");
            }

        } failure:^(id error) {
            [[XKLoadingView shareLoadingView] hideLoding];
            ShowErrorStatus(@"修改昵称失败");
            NSLog(@"%@",error);

        }];

    }

}

//还原个人页面信息
-(void)whowOderMessage{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reNameLoad" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reNameLoad" object:nil];
    });
    
}

/**
 更改用户头像
 */
- (IBAction)changePHotoAction:(id)sender {
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [[self parentController] presentViewController:_imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [[self parentController] presentViewController:_imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    [alert addAction:action1];
    
    [alert addAction:action3];
    
    [[self parentController] presentViewController:alert animated:YES completion:nil];
    
}

#define mark imagepicker的协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@",info[@"UIImagePickerControllerEditedImage"]);
    UIImage *image = (UIImage *)info[@"UIImagePickerControllerEditedImage"];

    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *data=UIImagePNGRepresentation(image);
    NSString *str=[data base64EncodedStringWithOptions:0];

    NSMutableString *mstr=[[NSMutableString alloc]initWithString:str];

    NSString *ss=[mstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [ProtosomaticHttpTool protosomaticPostWithURLString:@"137" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"MemberID":@([UserInfoTool getLoginInfo].MemberID),@"HeadBinary":ss} success:^(id json) {

            if ([json[@"Basis"][@"Msg"] isEqualToString:@"操作成功"]) {

                [[XKLoadingView shareLoadingView] hideLoding];

                ShowSuccessStatus(@"上传头像成功" );
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reGetUserMsgl" object:nil];//重新获取个人信息
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter  defaultCenter] removeObserver:self name:@"reGetUserMsgl" object:nil];
                });
                NSLog(@"%@",json);

            }else{

                NSLog(@"%@",json);
                [[XKLoadingView shareLoadingView] errorloadingText:@"上传头像失败"];

            }

        } failure:^(id error) {

            [[XKLoadingView shareLoadingView] errorloadingText:error];

        }];


    });

    dispatch_async(dispatch_get_main_queue(), ^{
        self.userIcon.image = image;
    });
    
}
-(void)setArr:(NSArray *)arr
{
    _arr = arr;
    NSLog(@"arr=%@",arr);
    NSArray *backVArr = @[self.backView1,self.backView2,self.backView3,self.backView5,self.backView6,self.backView7];
//    NSArray *imgviewArr = @[self.iconImgV1,self.iconImgV2,self.iconImgV3,self.iconImgV4,self.iconImgV5,self.iconImgV6,self.iconImgV7,self.iconImgV8,self.iconImgV9];
//    NSArray *titleLalArr = @[self.titleLal1,self.titleLal2,self.titleLal3,self.titleLal4,self.titleLal5,self.titleLal6,self.titleLal7,self.titleLal8,self.titleLal9];
    for (int i = 0; i < backVArr.count; i++) {
        UIView *vie  = (UIView *)backVArr[i];
        for (UIView *v in vie.subviews) {
            if ([v isKindOfClass:[UIImageView class]]) {
                UIImageView *imgv = (UIImageView *)v;
                imgv.image = [UIImage imageNamed:arr[i][@"img"]];
            }else if ([v isKindOfClass:[UILabel class]])
            {
                UILabel *titlelab = (UILabel *)v;
                titlelab.text = arr[i][@"remark"];
            }else if ([v isKindOfClass:[UIButton class]])
            {
                UIButton *b = (UIButton *)v;
                b.tag = [arr[i][@"viewTag"] integerValue]+ 1500;
                [b addTarget:self action:@selector(clickMyPage:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        }
       
        

       
        
    }

}
- (IBAction)kangBiAction:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(clickBtnProFileTopView:)]) {
        [self.delegate clickBtnProFileTopView:787878];
    }
    
    
}
-(void)clickMyPage:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(clickBtnProFileTopView:)]) {
        [self.delegate clickBtnProFileTopView:btn.tag  - 1500];
    }
}

@end