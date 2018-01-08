//
//  XSViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2018/1/3.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSViewController.h"

@interface XSViewController ()

@end

@implementation XSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //  配置导航栏
    [self configNav];
    
    //  配置UI
    [self configUI];
}

#pragma mark - pubilc

- (void)dismissToPresent {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - rewrite

- (void)setTitle:(NSString *)title {
    super.title = title;
    self.navItem.title = title;
}

#pragma mark - config

- (void)configUI {
    _contentView = [[UIView alloc] init];
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
}

- (void)configNav {
    
    //  navBar
    _navBar = [[UINavigationBar alloc] init];
    [_navBar setTranslucent:NO];
    [_navBar setTintColor:[UIColor darkGrayColor]];
    [_navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]}];
    
    //  navItem
    _navItem = [[UINavigationItem alloc] initWithTitle:self.title];
    _navBar.items = @[_navItem];
    
    //  返回按钮
    _backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    //  关闭按钮
    _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismissToPresent)];
    
    if (self.presentingViewController != nil) { //  modal
        _navItem.leftBarButtonItem = _closeItem;
        
        if (self.navigationController.childViewControllers.count > 1) {
            _navItem.leftBarButtonItems =  @[_backItem, _closeItem];
        }
    } else { // push
        _navItem.leftBarButtonItem = self.navigationController.childViewControllers.count > 1 ? _backItem : nil;
    }
    
    //  添加到父视图
    [self.view addSubview:_navBar];
    
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kStatusBar_Height);
        make.left.right.offset(0);
        make.height.equalTo(@44);
    }];
}

@end
