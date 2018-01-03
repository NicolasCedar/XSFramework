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

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    XSHomeViewController *vc = [[XSHomeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
