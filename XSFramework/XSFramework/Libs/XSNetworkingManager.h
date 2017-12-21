//
//  XSNetworkingManager.h
//  XSFramework
//
//  Created by huangxuesong on 2017/12/21.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface XSNetworkingManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
