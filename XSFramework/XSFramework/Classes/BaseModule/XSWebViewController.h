//
//  XSWebViewController.h
//  XSFramework
//
//  Created by huangxuesong on 2017/12/22.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSViewController.h"

@interface XSWebViewController : XSViewController

/// 请求地址
@property (nonatomic, copy) NSString *urlString;

/// 加载本地文件
@property (nonatomic, copy) NSString *fileName;

@end
