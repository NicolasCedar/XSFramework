//
//  XSNavigationController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/4.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSNavigationController.h"

@interface XSNavigationController ()

@end

@implementation XSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
}

#pragma mark - rewrite

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {// 隐藏标签栏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
