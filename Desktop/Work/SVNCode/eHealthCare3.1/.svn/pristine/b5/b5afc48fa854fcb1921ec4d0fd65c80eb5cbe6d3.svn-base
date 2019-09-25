//
//  ProtosomaticHttpTool.m
//  eHealthCare
//
//  Created by jamkin on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ProtosomaticHttpTool.h"
#import "Reachability.h"
#import"LFCGzipUtility.h"
//#import "UMMobClick/MobClick.h"
@interface ProtosomaticHttpTool ()<UIAlertViewDelegate>

@end

@implementation ProtosomaticHttpTool

NSString *netStatusStr;

+ (void)protosomaticPostWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id json))success
                  failure:(void (^)(id error))failure{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //友盟
  
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            netStatusStr=@"无网络连接";
            failure(netStatusStr);
            return;
            break;
        case ReachableViaWWAN:
            // 使用3G/4G网络
            netStatusStr=@"网络不给力啊";
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            netStatusStr=@"网络不给力啊";
            break;
    }
    
    NSMutableDictionary *globalDict=[NSMutableDictionary dictionaryWithCapacity:0];
    
    NSMutableDictionary *parmeterDict=[NSMutableDictionary dictionaryWithCapacity:0];
    
    [globalDict setObject:@2 forKey:@"OS"];
    
//    [globalDict setObject:[IPConfigTool getDeviceIPIpAddresses] forKey:@"IP"];
    
    NSMutableString *signStr=[[NSMutableString alloc]init];
    
    NSMutableArray *sortdArray=[NSMutableArray arrayWithCapacity:0];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
       
        if ([key isEqualToString:@"Token"]) {
            
            [globalDict setObject:obj forKey:key];
            
            
        }else{
            
            [parmeterDict setObject:obj forKey:key];
                        
            [sortdArray addObject:key];
            
        }
        
    }];
    
    
  
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [sortdArray sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果2%@",resultArray2);
    
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    
    
    NSArray *myDataArray = (NSArray *)sortdArray;
    NSArray *resultArray = [myDataArray sortedArrayUsingDescriptors:descriptors];
     NSLog(@"字符串数组排序结果%@",resultArray);
    for (int i=0; i<resultArray2.count; i++) {
        
        NSObject *obj=resultArray2[i];
        
        if ([[parameters objectForKey:obj] isKindOfClass:[NSDictionary class]]||[[parameters objectForKey:obj] isKindOfClass:[NSMutableDictionary class]]||[[parameters objectForKey:obj] isKindOfClass:[NSArray class]]||[[parameters objectForKey:obj] isKindOfClass:[NSMutableArray class]]) {
            
            NSLog(@"不加入签名");
            
        }else{
            
            NSObject *objKey=[parameters objectForKey:obj];

            [signStr appendString:[NSString stringWithFormat:@"%@^",objKey]];
            
        }
        
    }
    
    NSString *sign=@" ";
    
    NSLog(@"%@",signStr);
    
    if (signStr.length>=1) {
        
        sign=[Dateformat DateFormatWithMd5:[NSString stringWithFormat:@"%@9ol.)P:?3edc$RFV5tgb",[signStr substringToIndex:signStr.length-1]]];
        
    }
    
    [globalDict setObject:sign forKey:@"Sign"];
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:@{@"Global":globalDict,@"Query":parmeterDict} options:NSJSONWritingPrettyPrinted error:nil];
    
     NSString *path = [NSString stringWithFormat:@"%@%@",kBaseUrl,URLString];
    
    NSLog(@"%@",path);
    
    NSString *URL = [NSString stringWithFormat:@"%@",path];
    //以免有中文进行UTF编码
    NSString *UTFPathURL = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //请求路径
    NSURL *url = [NSURL URLWithString:UTFPathURL];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSInteger mId = [UserInfoTool getLoginInfo].MemberID;
    if (mId==0) {
        [request addValue:@" " forHTTPHeaderField:@"MemberID"];
    }else{
        [request addValue:[NSString stringWithFormat:@"%li",mId] forHTTPHeaderField:@"MemberID"];
    }
    
//    [request addValue:[NSString stringWithFormat:@"bytes=%@-",NSFileSize] forHTTPHeaderField:@"Range"];
    
    request.HTTPMethod=@"POST";
    
    request.HTTPBody=data;
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    //设置请求超时
    request.timeoutInterval = 12;
    //创建session配置对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders=@{@"Accept": @"application/json",@"api-key": @"API_KEY",@"Content-Type": @"application/json"};
    
 
    
  
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //创建session对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    //添加网络任务
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                failure(netStatusStr);
                
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data.length>0) {
                    NSString* strdata = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    NSData *jsonData =[ [NSData alloc]initWithBase64EncodedString:strdata options:0];
                    NSData * gZipData = [LFCGzipUtility ungzipData:jsonData];
                    NSData *tempData = [[NSData alloc]init];
                    if (gZipData.length>0) {
                        tempData = gZipData;
                    }else
                        tempData = data;
                    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:nil];
                    NSString *statusStr = [NSString stringWithFormat:@"%@",dataDict[@"Basis"][@"Status"]];
                    if ([statusStr isEqualToString:@"102"] || [statusStr isEqualToString:@"113"]) {
                        NSLog(@"path:%@ 102" ,path);
                        
                        [[XKLoadingView shareLoadingView] loginError:@"您的登录状态异常，请重新登录"];
                        
                    }else{
                        success(dataDict);
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    }
                    
                }

                
            });
            
        }
    }];
    //开始任务
    [task resume];
    
}



@end
