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

@end

@implementation XSWebViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)loadView {
    
    self.webView = [[WKWebView alloc] init];
    
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"加载中...";
        
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    self.progressView = [[UIProgressView alloc]
                                         initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
    self.progressView.progressTintColor = [UIColor blueColor];
    [self.webView addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

#pragma mark - set

- (void)setUrlString:(NSString *)urlString {
    //  过滤地址中包含的空格
    _urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
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
}

#pragma mark - WKNavigationDelegate, WKUIDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@", navigationAction.request.mainDocumentURL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title"
              completionHandler:^(id _Nullable title, NSError * _Nullable error) {
                  self.title = title;
              }];
}

@end
