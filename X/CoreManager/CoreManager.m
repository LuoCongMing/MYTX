//
//  CoreManager.m
//  X
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "CoreManager.h"

@implementation CoreManager
-(AFHTTPSessionManager*)manager{
    if(_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain",@"charset=UTF-8",@"multipart/form-data",@"application/octet-stream", nil];
        _manager.requestSerializer.timeoutInterval = 5;
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _manager.securityPolicy.allowInvalidCertificates = YES;
        //也不验证域名一致性
        _manager.securityPolicy.validatesDomainName = NO;
        //关闭缓存避免干扰测试
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
       
      
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [_manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
    }
    
    return _manager;
}





-(void)PostRequestWithPara:(NSDictionary *)para Path:(NSString *)path CompleteBlock:(FQCompleteBlock)complete FaildBlock:(FQFaildBlock)faild{
    
    
  
    [self.manager POST:path parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
    
}

-(void)getRequestWithPara:(NSDictionary *)para Path:(NSString *)path CompleteBlock:(FQCompleteBlock)complete FaildBlock:(FQFaildBlock)faild{

    [self.manager GET:path parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }];
}

@end
