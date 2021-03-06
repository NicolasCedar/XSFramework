//
//  AppDelegate.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/1.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "AppDelegate.h"
#import "XSNewFeatureController.h"
#import "XSMainController.h"

#define appId @"888174458"
#define appQueryUrl @"https://itunes.apple.com/lookup?id=888174458"
#define appUpdateUrl @"https://itunes.apple.com/app/id888174458"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private

/**
 设置主控制器
 */
- (void)setRootViewController{
    
    // 1.获取当前版本号
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    // 2.取出本地保存的版本号
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppVersion"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 3.比较两个版本号是否相同
    if ([version isEqualToString:currentVersion]) {
        
        XSMainController *mainVc = [[XSMainController alloc] init];
        self.window.rootViewController = mainVc;
        
        [self checkAppUpdate];
        
    } else {
        
        // 存版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"AppVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //显示新特性界面
        self.window.rootViewController = [[XSNewFeatureController alloc] init];
    }
    
    // 显示窗口
    [self.window makeKeyAndVisible];
}


/**
 校验是否有版本更新
 */
- (void)checkAppUpdate {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        //  获取查询信息
        NSURL *queryUrl = [NSURL URLWithString:appQueryUrl];
        NSString *queryString = [NSString stringWithContentsOfURL:queryUrl encoding:NSUTF8StringEncoding error:nil];
        
        if (queryString != nil) {
            NSData *jsonData = [queryString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *queryDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSDictionary *resultsDict = [queryDict[@"results"] lastObject];
            NSString *releaseNotes = resultsDict[@"releaseNotes"];
            NSString *version = resultsDict[@"version"];
            
            NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            
            //  判断是否有新版本
            if (![currentVersion isEqualToString:version]) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"检测到新版本" message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUpdateUrl]];
                    }];
                    [alertVC addAction:updateAction];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertVC addAction:cancelAction];
                    
                    [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
                }];
            }
        }
    }];
}

@end
