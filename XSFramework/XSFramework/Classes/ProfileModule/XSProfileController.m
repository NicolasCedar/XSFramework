//
//  XSProfileController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/4.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSProfileController.h"

@interface XSProfileController ()

@end

@implementation XSProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self openUpRefresh];
    [self openDownRefresh];
}

#pragma mark - rewrite

- (void)loadNewData {
    [self.dataSource removeAllObjects];
    
    for (int i = 0; i < 10; i++) {
        [self.dataSource addObject:@"new"];
    }
    [self.tableView reloadData];
    [super loadNewData];
}

- (void)loadMoreData {
    
    for (int i = 0; i < 10; i++) {
        [self.dataSource addObject:@"more"];
    }
    [self.tableView reloadData];
    [super loadMoreData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd ----%@", indexPath.row, self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row % 2 == 0) {
        [self.navigationController pushViewController:[[XSProfileController alloc] init] animated:YES];
    } else {
        XSNavigationController *nav = [[XSNavigationController alloc] initWithRootViewController:[XSProfileController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
