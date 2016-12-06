//
//  MasonryTest3Controller.m
//  CodeExamples
//
//  Created by letian on 16/12/4.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "MasonryTest3Controller.h"

@interface MasonryTest3Controller ()

@end

@implementation MasonryTest3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LT_WEAKSELF
    //屏幕中间放一个边长200 * 200的红色View
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //再对一个View布局之前, 一定要将这个View add到一个superView上
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 200));
        make.center.equalTo(weakSelf.view);
    }];
    
    
    //在红色View里面放三个正方形View, 等间距为10
    NSInteger padding = 10;
    UIView *yellowView1 = [[UIView alloc] init];
    yellowView1.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView1];
    
    UIView *yellowView2 = [[UIView alloc] init];
    yellowView2.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView2];
    
    UIView *yellowView3 = [[UIView alloc] init];
    yellowView3.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView3];
    
    /**
     *  确定间距等间距布局
     *
     *  @param axisType     布局方向
     *  @param fixedSpacing 两个item之间的间距(最左面的item和左边, 最右边item和右边都不是这个)
     *  @param leadSpacing  第一个item到父视图边距
     *  @param tailSpacing  最后一个item到父视图边距
     */
    [@[yellowView1, yellowView2, yellowView3] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
    
    [@[yellowView1, yellowView2, yellowView3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView).offset(10);
        make.height.mas_equalTo(yellowView3.mas_width);
    }];
    
    
    
    
    
    //在红色View里面放三个正方形蓝色View, 宽度均为30, 间隙一样大
    NSMutableArray *blueViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *blueView = [[UIView alloc] init];
        blueView.backgroundColor = [UIColor blueColor];
        [redView addSubview:blueView];
        [blueViews addObject:blueView];
    }
    CGFloat padding2 = (300 - 3 * 30) / 4;
    /**
     *  distribute with fixed item size
     *
     *  @param axisType  布局方向
     *  @param fixedItemLength 每个item的布局方向的长度
     *  @param leadSpacing  第一个item到父视图边距
     *  @param tailSpacing  最后一个item到父视图边距
     */
    [blueViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:padding2 tailSpacing:padding2];
    [blueViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yellowView1.mas_bottom).offset(20);
        UIView *blueView = (UIView *)blueViews[0];
        make.height.mas_equalTo(blueView.mas_width);
    }];
    
}

@end
