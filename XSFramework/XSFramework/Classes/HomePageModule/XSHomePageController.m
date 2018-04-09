//
//  XSHomeViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/4.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSHomePageController.h"
#import "XSWebViewController.h"
#import "XSNinthPalaceView.h"
#import "XSBannerView.h"

@interface XSHomePageController ()

@end

@implementation XSHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIButton *pushBtn = [UIButton xs_button:@"push" color:[UIColor redColor]];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:pushBtn];
    pushBtn.frame = CGRectMake(0, 20, 100, 100);
    [pushBtn addTarget:self  action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *modalBtn = [UIButton xs_button:@"push" color:[UIColor orangeColor]];
    modalBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:modalBtn];
    modalBtn.frame = CGRectMake(200, 20, 100, 100);
    [modalBtn addTarget:self  action:@selector(modal) forControlEvents:UIControlEventTouchUpInside];
    
     XSNinthPalaceView *view = [XSNinthPalaceView viewWithFrame:
                               CGRectMake(0, 200, self.view.bounds.size.width, 100)
                                                    dataSource:@[@{@"title": @"哈哈",
                                                                   @"imageName": @"",
                                                                   @"action": @"click"},
                                                                 @{@"title": @"嘿嘿",
                                                                   @"imageName": @"",
                                                                   @"action": @"click"},
                                                                 @{@"title": @"哦哦",
                                                                   @"imageName": @"",
                                                                   @"action": @"click"}]
                                                      colConst:4];
    [self.contentView addSubview:view];
    
    XSBannerView *banner = [[XSBannerView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 200)];
    [banner addTarget:self action:@selector(click)];
    banner.infos = @[@{
                         @"picUrl": @"http://www.etongdai.com/u/cms/www/201707/071028550iuf.jpg"
                         },@{
                         @"picUrl": @"http://www.etongdai.com/u/cms/www/201707/06200031pcvh.jpg"
                         },@{
                         @"picUrl": @"http://www.etongdai.com/u/cms/www/201707/28175723n7t1.jpg"
                         },@{
                         @"picUrl": @"http://www.etongdai.com/u/cms/www/201708/18104439mq82.jpg"
                         }];
    [self.contentView addSubview:banner];
    
    [banner startTimer];
}

- (void)click {
    XSWebViewController *vc = [[XSWebViewController alloc] init];
    vc.urlString = @"https://www. baidu .com ";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push {
    [self.navigationController pushViewController:[XSHomePageController new] animated:YES];
}

- (void)modal {
    XSNavigationController *nav = [[XSNavigationController alloc] initWithRootViewController:[XSHomePageController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
