//
//  MasonryTest2Controller.m
//  CodeExamples
//
//  Created by letian on 16/12/4.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "MasonryTest2Controller.h"

@interface MasonryTest2Controller ()
/** <#des#> */
@property (nonatomic,strong) UIView * backView;
/** <#des#> */
@property (nonatomic,strong) UILabel * label;

/** <#des#> */
@property (nonatomic,strong) UIView * greenView;
@end

@implementation MasonryTest2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setConstant];
    
    LT_WEAKSELF
    [self.view bk_whenTapped:^{
        LT_STRONGSELF
        NSString * text = strongSelf.label.text;
        text = [text isEqualToString:@"速度快放哪里开始了努力思考的那份"] ? @"十多年分类考试你都快来烦你了可是你的快乐发你看了什么贷款方面是看了没打开发了没上课没打开发了没上课的模仿开始的了免费" : @"速度快放哪里开始了努力思考的那份";
        strongSelf.label.text = text;
    }];
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.backView = [LTUITools lt_creatView];
    self.backView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.backView];
    
    self.greenView = [LTUITools lt_creatView];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.backView addSubview:self.greenView];
    
    self.label = [LTUITools lt_creatLabel];
    self.label.text = @"你好啊";
    self.label.backgroundColor = [UIColor redColor];
    [self.backView addSubview:self.label];
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.backView).offset(10);
        make.right.equalTo(self.backView).offset(-10);
        make.height.mas_equalTo(100);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.greenView.mas_bottom).offset(10);
        make.left.equalTo(self.greenView).offset(10);
        make.width.mas_lessThanOrEqualTo(self.greenView.mas_width).offset(-20);
        make.bottom.equalTo(self.backView).offset(-10);
    }];
}

@end
