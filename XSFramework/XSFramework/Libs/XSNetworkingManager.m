//
//  XSNetworkingManager.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/21.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSNetworkingManager.h"

@implementation XSNetworkingManager

+ (instancetype)sharedManager {
    
    static XSNetworkingManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 10.0;
        config.timeoutIntervalForResource = 10.0;
        
        instance = [[XSNetworkingManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    
    return instance;
}

@end
