
//
//  FriendCircleImageViewTestController.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/6.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleImageViewTestController.h"
#import "FriendCircleImageView.h"
@interface FriendCircleImageViewTestController ()
/** <#des#> */
@property (nonatomic,strong) FriendCircleImageView * imageView;

/** <#des#> */
@property (nonatomic,strong) UIButton * clickBt;

/** <#des#> */
@property (nonatomic,strong) UILabel * testLabel;

@end

@implementation FriendCircleImageViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setConstant];
    LT_WEAKSELF
    [[self.clickBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LT_STRONGSELF
        [strongSelf.imageView cellDataWithImageArray:[strongSelf arc4random]];
    }];
}

- (NSArray *)arc4random
{
    int count = arc4random() % 14  + 1;
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [arr addObject:@"http://4493bz.1985t.com/uploads/allimg/150127/4-15012G52133.jpg"];
    }
    return arr.copy;
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.imageView = [[FriendCircleImageView alloc] init];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView];
    
    [self.imageView cellDataWithImageArray:[self arc4random]];
    
    self.clickBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clickBt setTitle:@"点击我改变图片" forState:UIControlStateNormal];
    [self.clickBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.clickBt];
    
    self.testLabel = [LTUITools lt_creatLabel];
    self.testLabel.text = @"这是多图片底部验证label";
    [self.view addSubview:self.testLabel];
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        //        make.height.equalTo(self.imageView.collectionView.mas_height);
    }];
    
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.clickBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
}

@end
