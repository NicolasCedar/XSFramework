//
//  XSViewController.h
//  XSFramework
//
//  Created by huangxuesong on 2018/1/3.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSViewController : UIViewController

/**
 自定义导航条
 */
@property (nonatomic, strong) UINavigationBar *navBar;

/**
 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
 */
@property (nonatomic, strong) UINavigationItem *navItem;

/**
 移除控制器
 */
- (void)dismissToPresent;

/**
 返回上一级控制器
 */
- (void)popToPresent;

@end
