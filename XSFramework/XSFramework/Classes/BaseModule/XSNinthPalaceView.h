//
//  XSNinthPalaceView.h
//  XSFramework
//
//  Created by huangxuesong on 2018/1/4.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//  九宫布局

#import <UIKit/UIKit.h>

@interface XSNinthPalaceView : UIView

/**
 九宫格按钮视图
 
 @param frame 大小位置
 @param dataSource 数据源
 @param colConst 列数
 @return view
 */
+ (instancetype)viewWithFrame:(CGRect)frame dataSource:(NSArray <NSDictionary *>*)dataSource colConst:(int)colConst;

@end
