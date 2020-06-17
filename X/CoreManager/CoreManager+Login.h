//
//  CoreManager+Login.h
//  X
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "CoreManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreManager (Login)
-(void)registWithPhone:(NSString*)phone CompleteBlock:(FQCompleteBlock)complete FaildBlock:(FQFaildBlock)faild;
@end

NS_ASSUME_NONNULL_END
