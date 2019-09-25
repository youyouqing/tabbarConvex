//
//  NetWorkTool.m
//  DecentTrainUser
//
//  Created by shiyong on 2018/6/13.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#import "NetWorkTool.h"
#import "IPTool.h"
#import "EncryptionTool.h"
#import"LFCGzipUtility.h"
#import "BaseNavigationViewController.h"
@implementation NetWorkTool

/**
 *  发送一个POST请求
 */
+ (void)postAction:(NSString *)action params:(id)params finishedBlock:(void (^)(ResponseObject *response))finish;
{
    if([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusNone){
        
        ResponseObject *response = [[ResponseObject alloc] init];
        response.code = CodeTypeNoNetWork;
        response.msg = @"您当前的网络异常,请查看是否连接!";
        NSLog(@"%@-->您当前的网络异常,请查看是否连接!",action);
        
        if (finish) {
            
            finish(response);
        }
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;//请求超时
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy; //缓存策略
     [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Content"];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json;charset=utf-8", @"text/json", @"text/javascript", @"text/plain",@"text/html",@"application/json", nil];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //请求参数处理
    NSDictionary * fullParam = [self addSomethingsToOldParameter:params];
    NSString *bodyString = [fullParam mj_JSONString];
    NSData *postData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置请求接口
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,action]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSLog(@"%@-->URL",URL);
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *dataTask =   [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
     
            
            if (error) {
                
                ResponseObject *result = [[ResponseObject alloc] init];
                result.code = CodeTypeFail;//CodeTypeFail;
                result.msg =  @"大官人请查看网络~";//[NSString stringWithFormat:@"%@",error.description];//error.description;
                NSDictionary *allHeaders = nil;
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    
                    NSHTTPURLResponse *returnResponse = (NSHTTPURLResponse *)response;
                    allHeaders = returnResponse.allHeaderFields;
                    
                }
                
                NSLog(@"\n<Http-POST请求方法host>:-->%@->%@\n<请求头>:%@\n<请求参数>:%@\n<返回的请求头>:%@\n<返回的JSON>:%@---%@",kBaseUrl,action,manager.requestSerializer.HTTPRequestHeaders,fullParam,allHeaders,responseObject,error);
                
                finish(result);
                
            } else {
                
                
                
                
                NSString* strdata = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *jsonData =[ [NSData alloc]initWithBase64EncodedString:strdata options:0];
                NSData * gZipData = [LFCGzipUtility ungzipData:jsonData];
                HttpRequestReturnObject *returnObject = [[HttpRequestReturnObject alloc]init];
                NSDictionary *dic = [[NSDictionary alloc]init];
                if (gZipData.length>0) {
                    //
                    NSError *err;
                    dic = [NSJSONSerialization JSONObjectWithData:gZipData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&err];
                    
                    NSLog(@"-responseObject---%@---%@",responseObject,gZipData);
                    returnObject = [HttpRequestReturnObject mj_objectWithKeyValues:gZipData];
                }else
                {
                    
                    
                    returnObject = [HttpRequestReturnObject mj_objectWithKeyValues:responseObject];
                    dic = responseObject;
                }
                
                
                ResponseObject *result = [[ResponseObject alloc]init];
                result.jsonDic = dic;//原始数据
                result.Result = returnObject.Result;//我们需要拿来用的数据
                result.code = [returnObject.Basis[@"Status"] integerValue];//请求状态码
                result.msg = returnObject.Basis[@"Msg"];//后台给的提示消息
                
                NSDictionary *allHeaders = nil;
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    
                    NSHTTPURLResponse *returnResponse = (NSHTTPURLResponse *)response;
                    allHeaders = returnResponse.allHeaderFields;
                    
                }
                
                NSLog(@"\n<Http-POST请求方法host>:-->%@->%@\n<请求头>:%@\n<请求参数>:%@\n<返回的请求头>:%@\n<返回的JSON>:%@",kBaseUrl,action,manager.requestSerializer.HTTPRequestHeaders,fullParam,allHeaders,responseObject);
                if (![dic isKindOfClass:[NSData class]]) {
                    if ([dic[@"Basis"][@"Status"] integerValue] == CodeTypeSucceed) {
                        
                        result.code = CodeTypeSucceed;
                        
                    }else if ([dic[@"Basis"][@"Status"] integerValue] == CodeTypeTokenFial || [dic[@"Basis"][@"Status"] integerValue] == CodeTypeNotOnLine){
                        
                        result.code = CodeTypeTokenFial;
                        [SingleTon shareInstance].isLogin = NO;
                        
                        
                        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                        
                        UIViewController *currentVC = [rootViewController getCurrentViewController];
                        if ([currentVC isKindOfClass:[UIWindow class]]){
                            if ([rootViewController isKindOfClass:[UITabBarController class]])  {
                                
                                UITabBarController* tabbar = (UITabBarController *)rootViewController;
                                BaseNavigationViewController* nav = (BaseNavigationViewController *)tabbar.viewControllers[tabbar.selectedIndex];
                                
                                UIViewController *result = nav.childViewControllers.lastObject;
                                [result presentLoginView];
                                
                            }
                        }
                        else
                            [currentVC presentLoginView];
                        
                    }
                    else if ([dic[@"Basis"][@"Status"] integerValue] == CodeTypeWechatNotOnLine ){
                        
                        result.code = CodeTypeWechatNotOnLine;
                        
                        
                    }else{
                        
                        result.code = CodeTypeFail;
                        
                    }
                    finish(result);
                }
                
                
            }
            
        
    }];
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//        if (error) {
//
//            ResponseObject *result = [[ResponseObject alloc] init];
//            result.code = CodeTypeFail;//CodeTypeFail;
//            result.msg =  @"大官人请查看网络~";//[NSString stringWithFormat:@"%@",error.description];//error.description;
//            NSDictionary *allHeaders = nil;
//
//            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//
//                NSHTTPURLResponse *returnResponse = (NSHTTPURLResponse *)response;
//                allHeaders = returnResponse.allHeaderFields;
//
//            }
//
//            NSLog(@"\n<Http-POST请求方法host>:-->%@->%@\n<请求头>:%@\n<请求参数>:%@\n<返回的请求头>:%@\n<返回的JSON>:%@---%@",kBaseUrl,action,manager.requestSerializer.HTTPRequestHeaders,fullParam,allHeaders,responseObject,error);
//
//            finish(result);
//
//        } else {
//
//
//
//
//            NSString* strdata = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSData *jsonData =[ [NSData alloc]initWithBase64EncodedString:strdata options:0];
//            NSData * gZipData = [LFCGzipUtility ungzipData:jsonData];
//            HttpRequestReturnObject *returnObject = [[HttpRequestReturnObject alloc]init];
//            NSDictionary *dic = [[NSDictionary alloc]init];
//            if (gZipData.length>0) {
////
//                NSError *err;
//               dic = [NSJSONSerialization JSONObjectWithData:gZipData
//                                                                    options:NSJSONReadingMutableContainers
//                                                                      error:&err];
//
//                NSLog(@"-responseObject---%@---%@",responseObject,gZipData);
//               returnObject = [HttpRequestReturnObject mj_objectWithKeyValues:gZipData];
//            }else
//            {
//
//
//                returnObject = [HttpRequestReturnObject mj_objectWithKeyValues:responseObject];
//                 dic = responseObject;
//            }
//
//
//            ResponseObject *result = [[ResponseObject alloc]init];
//            result.jsonDic = dic;//原始数据
//            result.Result = returnObject.Result;//我们需要拿来用的数据
//            result.code = [returnObject.Basis[@"Status"] integerValue];//请求状态码
//            result.msg = returnObject.Basis[@"Msg"];//后台给的提示消息
//
//            NSDictionary *allHeaders = nil;
//
//            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//
//                NSHTTPURLResponse *returnResponse = (NSHTTPURLResponse *)response;
//                allHeaders = returnResponse.allHeaderFields;
//
//            }
//
//            NSLog(@"\n<Http-POST请求方法host>:-->%@->%@\n<请求头>:%@\n<请求参数>:%@\n<返回的请求头>:%@\n<返回的JSON>:%@",kBaseUrl,action,manager.requestSerializer.HTTPRequestHeaders,fullParam,allHeaders,responseObject);
//            if (![dic isKindOfClass:[NSData class]]) {
//                if ([dic[@"Basis"][@"Status"] integerValue] == CodeTypeSucceed) {
//
//                    result.code = CodeTypeSucceed;
//
//                }else if ([dic[@"Basis"][@"Status"] integerValue] == CodeTypeTokenFial || [dic[@"Basis"][@"Status"] integerValue] == CodeTypeNotOnLine){
//
//                    result.code = CodeTypeTokenFial;
//                    [SingleTon shareInstance].isLogin = NO;
//
//
//                    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//
//                    UIViewController *currentVC = [rootViewController getCurrentViewController];
//                    if ([currentVC isKindOfClass:[UIWindow class]]){
//                        if ([rootViewController isKindOfClass:[UITabBarController class]])  {
//
//                            UITabBarController* tabbar = (UITabBarController *)rootViewController;
//                            BaseNavigationViewController* nav = (BaseNavigationViewController *)tabbar.viewControllers[tabbar.selectedIndex];
//
//                            UIViewController *result = nav.childViewControllers.lastObject;
//                            [result presentLoginView];
//
//                        }
//                    }
//                    else
//                        [currentVC presentLoginView];
//
//                }
//                else if ([dic[@"Basis"][@"Status"] integerValue] == CodeTypeWechatNotOnLine ){
//
//                    result.code = CodeTypeWechatNotOnLine;
//
//
//                }else{
//
//                    result.code = CodeTypeFail;
//
//                }
//                 finish(result);
//            }
//
//
//        }
//
//    }];
    
    [dataTask resume];
    
}
+(NSData *)uncomPressDataWithData:(NSData *)compressedData{
    
    if ([compressedData length] == 0) return compressedData;
    
        unsigned full_length = [compressedData length];
    
        unsigned half_length = [compressedData length] / 2;
        NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
        BOOL done = NO;
        int status;
        z_stream strm;
        strm.next_in = (Bytef *)[compressedData bytes];
        strm.avail_in = [compressedData length];
        strm.total_out = 0;
        strm.zalloc = Z_NULL;
        strm.zfree = Z_NULL;
        if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
        while (!done) {
            // Make sure we have enough room and reset the lengths.
            if (strm.total_out >= [decompressed length]) {
                [decompressed increaseLengthBy: half_length];
            }
            // chadeltu 加了(Bytef *)
            strm.next_out = (Bytef *)[decompressed mutableBytes] + strm.total_out;
            strm.avail_out = [decompressed length] - strm.total_out;
            // Inflate another chunk.
            status = inflate (&strm, Z_SYNC_FLUSH);
            if (status == Z_STREAM_END) {
                done = YES;
            } else if (status != Z_OK) {
                break;
            }
    
        }
        if (inflateEnd (&strm) != Z_OK) return nil;
        // Set real length.
        if (done) {
            [decompressed setLength: strm.total_out];
            return [NSData dataWithData: decompressed];
        } else {
    return nil;
        }
}

//对原始的请求参数进行处理（和后台约定的格式）
+ (NSDictionary *)addSomethingsToOldParameter:(id)parameters
{
    
    NSMutableDictionary *globalDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSMutableDictionary *parmeterDict=[NSMutableDictionary dictionaryWithCapacity:0];
    
    [globalDict setObject:@2 forKey:@"OS"];
    
    [globalDict setObject:[IPTool getIPAdress] forKey:@"IP"];
    
    NSMutableString *signStr = [[NSMutableString alloc]init];
    
    NSMutableArray *sortdArray = [NSMutableArray arrayWithCapacity:0];
    
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
  
    for (int i=0; i<resultArray2.count; i++) {
        
        NSObject *obj=resultArray2[i];
        
        if ([[parameters objectForKey:obj] isKindOfClass:[NSDictionary class]]||[[parameters objectForKey:obj] isKindOfClass:[NSMutableDictionary class]]||[[parameters objectForKey:obj] isKindOfClass:[NSArray class]]||[[parameters objectForKey:obj] isKindOfClass:[NSMutableArray class]]) {
            
            //            NSLog(@"不加入签名");
            
        }else{
            
            NSObject *objKey=[parameters objectForKey:obj];
            
            [signStr appendString:[NSString stringWithFormat:@"%@^",objKey]];
            
        }
        
    }
    
    NSString *sign = @"";
    
    if (signStr.length >= 1) {
        
        sign = [EncryptionTool MD5ForLower32Bate:[NSString stringWithFormat:@"%@9ol.)P:?3edc$RFV5tgb",[signStr substringToIndex:signStr.length-1]]];
        
    }
    
    [globalDict setObject:sign forKey:@"Sign"];
    
    NSDictionary *returnDic = @{@"Global":globalDict,@"Query":parmeterDict};
    
    return returnDic;
}

@end
