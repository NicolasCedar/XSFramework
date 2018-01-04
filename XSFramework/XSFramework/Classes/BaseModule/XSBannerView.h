//
//  XSBannerView.h
//  XSFramework
//
//  Created by huangxuesong on 2018/1/4.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBannerView : UIView

/// 时间间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;

/// 详情数组
@property (nonatomic, strong) NSArray<NSDictionary *> *infos;

/// 当前索引
@property (nonatomic, assign) NSInteger currentInex;

/**
 添加监听方法
 
 @param target 监听者对象
 @param action 方法
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 开启定时器
 */
- (void)startTimer;

/**
 暂停定时器
 */
- (void)pauseTimer;

/**
 继续定时器
 
 @param timeInterval 当前时间多久后继续
 */
- (void)resumeTimer:(NSTimeInterval)timeInterval;

/**
 停止定时器
 */
- (void)stopTimer;

@end
