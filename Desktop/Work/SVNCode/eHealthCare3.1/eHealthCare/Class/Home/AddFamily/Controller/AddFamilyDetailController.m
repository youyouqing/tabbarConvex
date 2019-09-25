//
//  AddFamilyDetailController.m
//  eHealthCare
//
//  Created by John shi on 2018/10/17.
//  Copyright © 2018年 Jon Shi. All rights reserved.
//

#import "AddFamilyDetailController.h"
#import "AddFamilyBirthViewController.h"
#import "AddFamilyBindPhoneViewController.h"
@interface AddFamilyDetailController ()
{
    
    UIImagePickerController *_imagePickerController;
    
}
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *relationBtn;
@property (weak, nonatomic) IBOutlet UITextField *familyText;
@property (weak, nonatomic) IBOutlet UILabel *lineOne;

@end

@implementation AddFamilyDetailController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.model.FamilyHead = @"";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTitle = @"添加家人";
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
     [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    self.titleLab.textColor = kMainTitleColor;
   
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.addBtn.clipsToBounds = YES;
    self.addBtn.layer.cornerRadius = self.addBtn.frame.size.height/2.0;
    self.model.FamilyMobile = @"";
    self.relationBtn.clipsToBounds = YES;
    self.relationBtn.layer.cornerRadius = self.relationBtn.frame.size.height/2.0;
    [self.relationBtn setTitle:self.model.DictionaryName forState:UIControlStateNormal];
    self.familyText.delegate = self;
    self.model.FamilyHead = @"";
    _imagePickerController=[[UIImagePickerController alloc]init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    self.lineOne.backgroundColor = [UIColor getColor:@"EBF0F4"];
}
#define mark imagepicker的协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@",info[@"UIImagePickerControllerEditedImage"]);
    
  
    [self.relationBtn setImage:info[@"UIImagePickerControllerEditedImage"] forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *imageNew = info[@"UIImagePickerControllerEditedImage"];
    NSData *data= UIImageJPEGRepresentation(imageNew, 1);
    
    NSString *str=[data base64EncodedStringWithOptions:0];
    NSMutableString *mstr=[[NSMutableString alloc]initWithString:str];
    NSString *ss=[mstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    [[XKLoadingView shareLoadingView]showLoadingText:nil];
    [ProtosomaticHttpTool protosomaticPostWithURLString:@"147" parameters:@{@"Token":[UserInfoTool getLoginInfo].Token,@"HeadBinary":ss} success:^(id json) {
        NSLog(@"%@",json);
        
        [[XKLoadingView shareLoadingView]hideLoding];
        if ([[[json objectForKey:@"Basis"] objectForKey:@"Msg"] isEqualToString:@"操作成功"]) {
            self.model.FamilyHead = json[@"Result"];
           NSLog(@"上传图片成功");
            
        }else{
            [[XKLoadingView shareLoadingView]errorloadingText:@"上传图片失败"];
            
        }
        
    } failure:^(id error) {
        
        
        [[XKLoadingView shareLoadingView]errorloadingText:@"上传图片失败"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nonPhoneAction:(id)sender {
   
    self.model.FamilyMobile = self.familyText.text;
    AddFamilyBirthViewController *add = [[AddFamilyBirthViewController alloc]initWithType:pageTypeNormal];
    add.model = self.model;
    [self.navigationController pushViewController:add animated:YES];
}
- (IBAction)addPhoneAction:(id)sender {
    if (self.familyText.text.length<=0) {
        ShowErrorStatus(@"请先输入手机号码");
        return;
    }
    if ([Judge validateMobile:self.familyText.text]) {
        self.model.FamilyMobile = self.familyText.text;
        AddFamilyBirthViewController *add = [[AddFamilyBirthViewController alloc]initWithType:pageTypeNormal];
        add.model = self.model;
        [self.navigationController pushViewController:add animated:YES];
        //    AddFamilyBindPhoneViewController *add = [[AddFamilyBindPhoneViewController alloc]initWithType:pageTypeNormal];
        //    [self.navigationController pushViewController:add animated:YES];
    }else
    {
        
        ShowErrorStatus(@"请输入正确的手机号码");
        return;
    }
 
    
}
- (IBAction)takePhotoAction:(id)sender {
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    [alert addAction:action1];
    
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    if (textField == self.familyText) {
        self.lineOne.backgroundColor = kMainColor;
       
        
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.familyText) {
//        self.lineOne.textColor = kMainColor;
       
        if (textField.text.length > 0)
        {
            self.lineOne.backgroundColor = kMainColor;
            if ([Judge validateMobile:textField.text]) {
                //电话正确
                
                
            }else{
                //电话错误
                
               
            }
            
        }else
             self.lineOne.backgroundColor = [UIColor getColor:@"EBF0F4"];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.familyText) {
         self.lineOne.backgroundColor = kMainColor;
        
        
        if (range.location > 10) {
            return NO;
        }
        
        return YES;
        
    }
    
     return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
