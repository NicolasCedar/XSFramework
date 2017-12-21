//
//  XSNewFeatureController.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/1.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSNewFeatureController.h"
#import "XSNewFeatureLayout.h"
#import "XSNewFeatureCell.h"
#import "XSMainTabBarController.h"

#define kNewFeatureMaxCount 2

@interface XSNewFeatureController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIButton *exitButton;

@end

@implementation XSNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - private

- (void)setupUI {
    
    //  滚动视图
    XSNewFeatureLayout *layout = [[XSNewFeatureLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[XSNewFeatureCell class] forCellWithReuseIdentifier:@"newFeatureCell"];
    self.collectionView = collectionView;
    
    //  分页指示器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    
    pageControl.userInteractionEnabled = NO;
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = kNewFeatureMaxCount;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    self.pageControl = pageControl;
    
    //  离开按钮
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:exitButton];
    
    [exitButton setTitle:@"开始体验" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [exitButton setBackgroundColor:[UIColor blueColor]];
    [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    exitButton.hidden = YES;
    exitButton.layer.cornerRadius = 10;
    self.exitButton = exitButton;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-60);
        make.centerX.offset(0);
    }];
    
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - private

- (void)exitButtonClick {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[XSMainTabBarController alloc] init];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
    
    self.exitButton.hidden = page != kNewFeatureMaxCount - 1;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kNewFeatureMaxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XSNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newFeatureCell" forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"newFeature_%zd", indexPath.row];
    return cell;
}

@end
