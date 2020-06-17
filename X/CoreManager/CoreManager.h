//
//  CoreManager.h
//  X
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "NSString+TRHString.h"


static NSString * _Nullable  host = @"http://47.52.157.85/";//
NS_ASSUME_NONNULL_BEGIN


typedef void(^FQCompleteBlock)(id success);

typedef void(^FQFaildBlock)(id error);

@interface CoreManager : NSObject
@property (nonatomic,copy)FQCompleteBlock completeBlock;
@property (nonatomic,copy)FQFaildBlock  faildBlock;

@property (nonatomic,strong)AFHTTPSessionManager*manager;

-(void)PostRequestWithPara:(NSDictionary*)para Path:(NSString*)path CompleteBlock:(FQCompleteBlock)complete FaildBlock:(FQFaildBlock)faild;

-(void)getRequestWithPara:(NSDictionary*)para Path:(NSString*)path CompleteBlock:(FQCompleteBlock)complete FaildBlock:(FQFaildBlock)faild;

@end

NS_ASSUME_NONNULL_END
