//
//  MasonryTest4Controller.m
//  CodeExamples
//
//  Created by letian on 16/12/4.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "MasonryTest4Controller.h"

@interface MasonryTest4Controller ()

@property (nonatomic, strong) UIView *constraintsView;
@property (nonatomic, strong) UIView *frameView;
@property (nonatomic, assign) BOOL constrainIsExpend;
@property (nonatomic, assign) BOOL frameIsExpend;

@end

@implementation MasonryTest4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    LT_WEAKSELF
    _constrainIsExpend = NO;
    UIView *constraintsView = [[UIView alloc] init];
    constraintsView.center = self.view.center;
    constraintsView.backgroundColor = [UIColor redColor];
    constraintsView.layer.borderColor = [UIColor blueColor].CGColor;
    constraintsView.layer.borderWidth = 2;
    [self.view addSubview:constraintsView];
    self.constraintsView = constraintsView;
    
    [constraintsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view).offset(-SCREEN_HEIGHT/4);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [constraintsView bk_whenTapped:^{
        weakSelf.constrainIsExpend = !weakSelf.constrainIsExpend;
        [weakSelf.view setNeedsUpdateConstraints]; //标记为需要更新约束
        [weakSelf.view updateConstraintsIfNeeded]; //立即调用updateViewConstraints更新约束, 此方法只是更新了约束, 并没有刷新布局
        [UIView animateWithDuration:1.0 animations:^{
            [weakSelf.view layoutIfNeeded];  //动画 刷新布局
            
        }];
    }];
}

//不是一定需要把更新约束写在这个方法里, 可以自动一个方法, 苹果推荐使用这个方法更新约束
- (void)updateViewConstraints {
    [self.constraintsView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGSize upSize = self.constrainIsExpend ? CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/2) : CGSizeMake(100, 100);
        make.size.mas_equalTo(upSize);
    }];
    [super updateViewConstraints];
    NSLog(@"updateViewConstraints");
}

- (void)dealloc
{
    NSLog(@"销毁");
}

@end
