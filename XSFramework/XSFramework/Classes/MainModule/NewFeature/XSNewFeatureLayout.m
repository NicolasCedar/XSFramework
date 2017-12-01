//
//  XSNewFeatureLayout.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/1.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSNewFeatureLayout.h"

@implementation XSNewFeatureLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

@end
