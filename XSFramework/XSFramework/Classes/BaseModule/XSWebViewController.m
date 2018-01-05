//
//  XSWebViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/22.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSWebViewController.h"
@import WebKit;

@interface XSWebViewController () <WKNavigationDelegate, WKUIDelegate>

/// 网络视图
@property (nonatomic, strong) WKWebView *webView;

/// 加载进度条
@property (nonatomic, strong) UIProgressView *progressView;

/// 刷新控件
@property (nonatomic, strong) UIBarButtonItem *refreshItem;

@end

@implementation XSWebViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加载中...";
    
    //  加载请求
    [self loadRequest];
}

- (void)configUI {
    
    self.webView = [[WKWebView alloc] init];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
    self.progressView.progressTintColor = [UIColor blueColor];
    [self.webView addSubview:self.progressView];
    
    //  添加监听者对象
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)loadRequest {
    //  加载网页
    if (self.fileName != nil) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:@"html"];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    } else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }
}

#pragma mark - lazy

- (UIBarButtonItem *)refreshItem {
    if (_refreshItem == nil) {
        _refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshView)];
    }
    
    return _refreshItem;
}

#pragma mark - set

- (void)setUrlString:(NSString *)urlString {
    //  过滤地址中包含的空格
    _urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark - rewrite

- (void)goBack {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self dismissToPresent];
    }
}

- (void)dismissToPresent {
    if (self.presentingViewController != nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat progress = [change[NSKeyValueChangeNewKey] floatValue];
        
        self.progressView.progress = progress;
        self.progressView.hidden = progress >= 1;
    }
    
    //  监听回退
    if ([keyPath isEqualToString:@"canGoBack"]) {
        
        self.navItem.leftBarButtonItems = [change[NSKeyValueChangeNewKey] boolValue] ? @[self.backItem, self.closeItem] : @[self.backItem];
    }
}

#pragma mark - monitor

- (void)refreshView {
    [self.webView reload];
}

#pragma mark - WKNavigationDelegate, WKUIDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSLog(@"%@", navigationAction.request.mainDocumentURL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *title, NSError * _Nullable error) {
        self.title = title;
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@", error);
    self.navItem.rightBarButtonItem = self.refreshItem;
}

@end
