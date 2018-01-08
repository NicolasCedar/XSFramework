//
//  XSTableViewController.h
//  XSFramework
//
//  Created by huangxuesong on 2018/1/3.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSViewController.h"

@interface XSTableViewController : XSViewController <UITableViewDataSource, UITableViewDelegate>

/// 表格视图
@property (nonatomic, strong) UITableView *tableView;

/// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

/// 开启上拉加载
- (void)openUpRefresh;

/// 开启下拉刷新
- (void)openDownRefresh;

///  加载新数据
- (void)loadNewData;

///  加载更多数据
- (void)loadMoreData;

@end
