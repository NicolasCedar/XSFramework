//
//  XSTableViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2018/1/3.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSTableViewController.h"

@interface XSTableViewController ()

@property (nonatomic, strong) UIImageView *nodataImageView;

@end

@implementation XSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - public

//  加载新数据
- (void)loadNewData {
    [self.tableView.mj_header endRefreshing];
}

//  加载更多数据
- (void)loadMoreData {
    [self.tableView.mj_footer endRefreshing];
}

//  开启下拉刷新
- (void)openDownRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

//  开启上拉加载
- (void)openUpRefresh {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - lazy

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

#pragma mark - config

- (void)configUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self configNoDataUI];
}

- (void)configNoDataUI {
    self.nodataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noData"]];
    [self.tableView addSubview:self.nodataImageView];
    
    [self.nodataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.nodataImageView.hidden = self.dataSource.count > 0;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

@end
