//
//  XSBannerView.m
//  XSFramework
//
//  Created by huangxuesong on 2018/1/4.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSBannerView.h"

@interface XSBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;

/// 定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XSBannerView

- (void)dealloc {
    [self stopTimer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.leftImageView];
        [self.scrollView addSubview:self.centerImageView];
        [self.scrollView addSubview:self.rightImageView];
        [self addSubview:self.pageControl];
        //  设置初始值
        self.timeInterval = 3;
        self.currentInex = 0;
    }
    return self;
}

#pragma mark - pubilc
- (void)addTarget:(id)target action:(SEL)action {
    self.centerImageView.userInteractionEnabled = YES;
    [self.centerImageView addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}

#pragma mark - rewrite
- (void)setInfos:(NSArray *)infos {
    _infos = infos;
    
    self.pageControl.numberOfPages = infos.count;
    self.pageControl.frame = CGRectMake(0, 0, 20 * infos.count, 20);
    [self.pageControl setCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 10)];
    self.currentInex = 0;
}

- (void)setCurrentInex:(NSInteger)currentInex {
    _currentInex = currentInex;
    self.pageControl.currentPage = currentInex;
    
    if (self.infos.count == 0) {
        return ;
    }
    //  计算图片索引
    NSInteger leftIndex = (currentInex - 1 + self.infos.count) % self.infos.count;
    NSInteger rightIndex = (currentInex + 1) % self.infos.count;
    
    NSString *leftUrl = self.infos[leftIndex][@"picUrl"];
    NSString *centerUrl = self.infos[currentInex][@"picUrl"];
    NSString *rightUrl = self.infos[rightIndex][@"picUrl"];
    [self.leftImageView setImageWithURL:[NSURL URLWithString:leftUrl]];
    [self.centerImageView setImageWithURL:[NSURL URLWithString:centerUrl]];
    [self.rightImageView setImageWithURL:[NSURL URLWithString:rightUrl]];
}

#pragma mark - private

- (void)startLoopScroll {
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:self afterDelay:0.5];
}

#pragma mark - Timer
- (void)startTimer {
    if (self.timer || self.infos.count  == 1) {
        return ;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(startLoopScroll) userInfo:nil repeats:YES];
}

- (void)pauseTimer {
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)resumeTimer:(NSTimeInterval)timeInterval {
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self resumeTimer:self.timeInterval];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.infos.count <= 0) {
        return;
    }
    
    if (self.scrollView.contentOffset.x == 0) {
        self.currentInex = (self.currentInex - 1 + self.infos.count) % self.infos.count;
    } else if (self.scrollView.contentOffset.x == self.scrollView.bounds.size.width * 2) {
        self.currentInex = (self.currentInex + 1) % self.infos.count;
    } else {
        return;
    }
    
    //  偏移回初始位置
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}

#pragma mark - lazy

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        //  设置 scrollView
        _scrollView.bounces = NO; //  回弹效果
        _scrollView.showsVerticalScrollIndicator = NO;    //  隐藏滚动条（垂直）
        _scrollView.showsHorizontalScrollIndicator = NO;  //  隐藏滚动条（水平）
        _scrollView.pagingEnabled = YES;  //  开启分页
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);  //   偏移量
        _scrollView.contentSize = CGSizeMake(3 * self.bounds.size.width, 0);   //  移动范围
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:
                          CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _leftImageView.backgroundColor = [UIColor blackColor];
    }
    
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc] initWithFrame:
                            CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        _centerImageView.backgroundColor = [UIColor blueColor];
    }
    
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:
                           CGRectMake(2 * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        _rightImageView.backgroundColor = [UIColor orangeColor];
    }
    
    return _rightImageView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    }
    
    return _pageControl;
}

@end
