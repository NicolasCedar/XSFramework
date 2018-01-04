//
//  XSMineViewController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/4.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSMineViewController.h"

@interface XSMineViewController ()

@end

@implementation XSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self openUpRefresh];
    [self openDownRefresh];
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd ----%@", indexPath.row, self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[XSMineViewController alloc] init] animated:YES];
}
@end
