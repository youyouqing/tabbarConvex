//
//  XKRemoteMessageController.m
//  eHealthCare
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XKRemoteMessageController.h"

@interface XKRemoteMessageController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;


@end

@implementation XKRemoteMessageController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentLab.text=self.messageBody;
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    self.timeLab.text=[formatter stringFromDate:[NSDate date]];
    
    
}

-(void)setMessageBody:(NSString *)messageBody{
    
    _messageBody=messageBody;
    
    self.contentLab.text=self.messageBody;
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    self.timeLab.text=[formatter stringFromDate:[NSDate date]];
   
}

-(void)reloadWebContent:(NSNotification *)noti{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    self.timeLab.text=[formatter stringFromDate:[NSDate date]];
    
    NSDictionary *dict=noti.object;
    
    self.contentLab.text=dict[@"aps"][@"alert"];;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
