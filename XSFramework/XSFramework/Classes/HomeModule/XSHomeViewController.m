//
//  XSHomeViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/4.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSHomeViewController.h"
#import "XSWebViewController.h"

#import "XSNinthPalaceView.h"
#import "XSBannerView.h"

@interface XSHomeViewController ()

@end

@implementation XSHomeViewController

- (void)configUI {
    [super configUI];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [self.contentView addSubview:btn];
    btn.frame = CGRectMake(0, 100, 100, 100);
    [btn addTarget:self  action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSLog(@"点击");
    
    XSWebViewController *vc = [[XSWebViewController alloc] init];
    
    vc.urlString = @"https://www. baidu .com ";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)clickBtn {
    [self.navigationController pushViewController:[XSHomeViewController new] animated:YES];
}

@end
