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
 内容视图
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/**
 自定义导航条
 */
@property (nonatomic, strong, readonly) UINavigationBar *navBar;

/**
 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
 */
@property (nonatomic, strong, readonly) UINavigationItem *navItem;

/// 返回控件
@property (nonatomic, strong, readonly) UIBarButtonItem *backItem;

/// 关闭控件
@property (nonatomic, strong, readonly) UIBarButtonItem *closeItem;

/// 配置界面
- (void)configUI;

/// 移除
- (void)dismissToPresent;

/// 返回
- (void)goBack;

@end
