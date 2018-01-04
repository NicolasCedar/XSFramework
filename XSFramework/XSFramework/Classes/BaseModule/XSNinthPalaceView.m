//
//  XSNinthPalaceView.m
//  XSFramework
//
//  Created by huangxuesong on 2018/1/4.
//  Copyright © 2018年 huangxuesong. All rights reserved.
//

#import "XSNinthPalaceView.h"

@implementation XSNinthPalaceView

+ (instancetype)viewWithFrame:(CGRect)frame dataSource:(NSArray <NSDictionary *>*)dataSource colConst:(int)colConst {
    XSNinthPalaceView *view = [[XSNinthPalaceView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    NSInteger maxRow = dataSource.count / colConst + ((dataSource.count % colConst > 0) ? 1: 0);
    CGFloat w = frame.size.width / colConst;
    CGFloat h = frame.size.height / maxRow;
    
    [dataSource enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat row = idx / colConst;
        CGFloat col = idx % colConst;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(col * w, row * h, w, h)];
        
        NSString *title = [obj objectForKey:@"title"];
        NSString *imgName = [obj objectForKey:@"imageName"];
        NSString *action = [obj objectForKey:@"action"];
        if (title.length > 0) {
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        
        if (imgName.length > 0) {
            [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        }
        
        if (title.length > 0 && imgName.length > 0) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        }
        
        if (action.length > 0) {
            [btn addTarget:nil action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpInside];
        }
        [view addSubview:btn];
    }];
    
    return view;
}

@end
