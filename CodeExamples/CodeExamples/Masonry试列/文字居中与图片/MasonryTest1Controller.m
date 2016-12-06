
//
//  MasonryTest1.m
//  CodeExamples
//
//  Created by letian on 16/12/4.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "MasonryTest1Controller.h"


@interface MasonryTest1Controller ()

/** <#des#> */
@property (nonatomic,strong) UIImageView * imageView;
/** <#des#> */
@property (nonatomic,strong) UILabel * label;

/** <#des#> */
@property (nonatomic,strong) UIView* testBackView;

/** <#des#> */
@property (nonatomic,strong) UILabel * clickLbl;

@end

@implementation MasonryTest1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 
     测试需求
     1.整体居中
     2.宽度可变，看文字是否够一行，最宽左右内边距15
     3.内部两个View的centerY对其
     4.最小高度为图片高度，文字高度超度图片，就以文字高度为准
     
     */
    
    [self setupUI];
    [self setConstant];
    
    LT_WEAKSELF
    [self.clickLbl bk_whenTapped:^{
        LT_STRONGSELF
        NSString * text = [strongSelf.label.text isEqualToString:@"哈哈哈"] ? @"死的那附近十多年佛可能为尽快把服务IE抱佛脚不是看大家都方便就开不开机IE抱佛脚不是看大家都方便就开不开机IE抱佛脚不是看大家都方便就开不开机IE抱佛脚不是看大家都方便就开不开机IE抱佛脚不是看大家都方便就开不开机IE抱佛脚不是看大家都方便就开不开机你说呢，哈哈哈哈哈哈哈哈哈哈哈哈哈哈爱安静安静了空间" : @"哈哈哈";
        strongSelf.label.text = text;
    }];
}

- (void)dealloc
{
    NSLog(@"销毁");
}

#pragma mark - 设置UI
- (void)setupUI
{   
    self.testBackView = [LTUITools lt_creatView];
    self.testBackView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testBackView];
    
    self.imageView = [LTUITools lt_creatImageView];
    self.imageView.image = [UIImage imageNamed:@"tu1.jpg"];
    [self.testBackView addSubview:self.imageView];
    
    self.label = [LTUITools lt_creatLabel];
    self.label.text = @"死的那附近十多年佛可能为尽快把服务IE抱佛脚不是看大家都方便就开不开机";
    self.label.backgroundColor = [UIColor yellowColor];
    [self.testBackView addSubview:self.label];
    
    self.clickLbl = [LTUITools lt_creatLabel];
    self.clickLbl.text = @"点击我试试";
    self.clickLbl.textColor = [UIColor redColor];
    self.clickLbl.userInteractionEnabled = YES;
    [self.view addSubview:self.clickLbl];
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.testBackView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerY.equalTo(self.testBackView);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageView.mas_left).offset(-10);
        make.left.equalTo(self.testBackView);
        make.bottom.top.equalTo(self.testBackView).offset(0);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    [self.testBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.centerX.equalTo(self.view);
        make.width.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width - 30);
    }];
    
    [self.clickLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
    }];
}
@end
