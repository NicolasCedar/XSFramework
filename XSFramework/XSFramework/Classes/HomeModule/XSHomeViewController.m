//
//  XSHomeViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/4.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSHomeViewController.h"
#import "XSWebViewController.h"

@interface XSHomeViewController ()

@end

@implementation XSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    XSWebViewController *vc = [[XSWebViewController alloc] init];
    
    vc.urlString = @"https://www. baidu .com ";
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
