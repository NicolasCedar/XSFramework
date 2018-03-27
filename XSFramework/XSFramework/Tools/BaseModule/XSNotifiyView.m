//
//  XSNotifiyView.m
//  XSFramework
//
//  Created by huangxuesong on 2018/3/27.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSNotifiyView.h"

@interface XSNotifiyView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XSNotifiyView

- (void)dealloc {
    [self stopTimer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        
        self.timeInterval = 3;
    }
    
    return self;
}

#pragma mark - pubilc
- (void)addTarget:(id)target action:(SEL)action {
    self.centerLabel.userInteractionEnabled = YES;
    [self.centerLabel addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}

- (void)setInfos:(NSArray *)infos {
    _infos = infos;
    
    self.currentIdx = 0;
}

- (void)setCurrentIdx:(NSInteger)currentIdx {
    _currentIdx = currentIdx;
    
    if (self.infos.count == 0) {
        return ;
    }
    
    NSInteger topIdx = (currentIdx - 1 + self.infos.count) % self.infos.count;
    NSInteger bottomIdx = (currentIdx + 1) % self.infos.count;
    
    self.topLabel.text = self.infos[topIdx];
    self.centerLabel.text = self.infos[currentIdx];
    self.bottomLabel.text = self.infos[bottomIdx];
}

- (void)startLoopScroll {
    [self.scrollView setContentOffset:CGPointMake(0, self.xs_height * 2) animated:YES];
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
    if (self.infos.count == 0) {
        return;
    }
    
    if (self.scrollView.contentOffset.y == 0) {
        self.currentIdx = (self.currentIdx - 1 + self.infos.count) % self.infos.count;
    } else if (self.scrollView.contentOffset.y == self.scrollView.xs_height * 2) {
        self.currentIdx = (self.currentIdx + 1) % self.infos.count;
    } else {
        return;
    }
    
    //  偏移回初始位置
    self.scrollView.contentOffset = CGPointMake(0, self.xs_height);
}

#pragma mark - config

- (void)configUI {
    
    //  图标
    self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.iconView.frame = CGRectMake(10, (self.xs_height - self.iconView.xs_height) / 2, self.iconView.xs_width, self.iconView.xs_height);
    [self addSubview:self.iconView];
    
    //  滚动视图
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 5;
    CGFloat w = self.xs_width - x;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, 0, w, self.xs_height)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(0, self.xs_height * 3);
    self.scrollView.contentOffset = CGPointMake(0, self.xs_height);
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    //  滚动视图子视图
    self.topLabel = [UILabel xs_labelWithText:@"" fontSize:12 color:[UIColor xs_colorWithHex:0x666666]];
    self.topLabel.frame = CGRectMake(0, 0, w, self.xs_height);
    [self.scrollView addSubview:self.topLabel];
    
    self.centerLabel = [UILabel xs_labelWithText:@"" fontSize:12 color:[UIColor xs_colorWithHex:0x666666]];
    self.centerLabel.frame = CGRectMake(0, self.xs_height, w, self.xs_height);
    [self.scrollView addSubview:self.centerLabel];
    
    self.bottomLabel = [UILabel xs_labelWithText:@"" fontSize:12 color:[UIColor xs_colorWithHex:0x666666]];
    self.bottomLabel.frame = CGRectMake(0, self.xs_height * 2, w, self.xs_height);
    [self.scrollView addSubview:self.bottomLabel];
}

@end
