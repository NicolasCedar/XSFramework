//
//  XSMainTabBarController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/1.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSMainTabBarController.h"
#import "XSNavigationController.h"

@interface XSMainTabBarController ()

@end

@implementation XSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    
    [self setupTabBar];
}

#pragma mark - private

- (void)setupTabBar {
    
    //  去除顶部黑线
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.translucent = NO;
}

/**
 添加子控制器
 */
- (void)addChildViewControllers {
    
    //  加载子控制器相关信息
    NSString *path = [[NSBundle mainBundle] pathForResource:@"main.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
    NSArray *controllers = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //  创建子控制器
    NSMutableArray *controllerArray = [NSMutableArray array];
    for (NSDictionary *controller in controllers) {
        [controllerArray addObject:[self childControllerWithDict:controller]];
    }
    
    self.viewControllers = controllerArray;
}


/**
 创建子控制器

 @param dict 子控制器相关信息
 @return 控制器
 */
- (UIViewController *)childControllerWithDict:(NSDictionary *)dict {
    
    NSString *className = dict[@"className"];
    
    if (className == nil) {
        return [UIViewController new];
    }
    
    Class cls = NSClassFromString(className);
    
    UIViewController *vc = [[cls alloc] init];
    vc.title = dict[@"title"];
    NSString *imageName = [NSString stringWithFormat:@"tabBar_%@", dict[@"imageName"]];
    NSString *selectedImageName = [NSString stringWithFormat:@"tabBar_%@_selected", dict[@"imageName"]];
    vc.tabBarItem.image = [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = vc.tabBarItem.image = [[UIImage imageNamed: selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return [[XSNavigationController alloc] initWithRootViewController:vc];
}


@end
