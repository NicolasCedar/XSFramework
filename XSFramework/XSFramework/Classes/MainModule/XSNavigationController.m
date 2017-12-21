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
    
    [self setupNavBar];
}

#pragma mark - private

- (void)setupNavBar {
    
    //  去除底部黑线
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {// 隐藏标签栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //  取消返回按钮文字
        UIViewController *sourceVc = self.viewControllers[self.viewControllers.count - 1];
        sourceVc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:sourceVc action:nil];
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
