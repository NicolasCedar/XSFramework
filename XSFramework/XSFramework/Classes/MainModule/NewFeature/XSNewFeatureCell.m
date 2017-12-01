//
//  XSNewFeatureCell.m
//  XSFramework
//
//  Created by huangxuesong on 2017/12/1.
//  Copyright © 2017年 huangxuesong. All rights reserved.
//

#import "XSNewFeatureCell.h"

@interface XSNewFeatureCell()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation XSNewFeatureCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - set

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    _imageView.image = [UIImage imageNamed:imageName];
}

#pragma mark - private

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
    
    self.imageView = imageView;
}

@end
