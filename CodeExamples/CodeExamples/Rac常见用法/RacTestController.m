//
//  RacTestController.m
//  CodeExamples
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "RacTestController.h"

@interface RacTestController ()
/** <#des#> */
@property (nonatomic,strong) UITextField * textField;
/** <#des#> */
@property (nonatomic,strong) UIButton * button;
@end

@implementation RacTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [LTUITools lt_creatTextField];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"点击这里" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.equalTo(self.textField);
        make.top.equalTo(self.textField.mas_bottom).offset(20);
    }];
    
    
    
    //7.1 rac_signalForSelector：用于替代代理,监听代理时间,但是不能取代有返回值的代理
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        NSLog(@"7.1 rac_signalForSelector：用于替代代理----------- %@",x);
    }];
    
    //7.2 代替KVO :
    [RACObserve(self.textField, text) subscribeNext:^(id x) {
        NSLog(@"7.2 代替KVO  RACObserve:: ---------- %@",x);
    }];
    
    [[self.textField rac_valuesAndChangesForKeyPath:@"text" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        
        NSLog(@"7.2 代替KVO rac_valuesAndChangesForKeyPath :: ---------- %@",x);
        
    }];
    
    //7.3 监听事件:
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"7.3 监听事件: ---------- %@",x);
    }];
    
    //7.4 代替通知:
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UIKeyboardWillShowNotification" object:nil] subscribeNext:^(id x) {
        NSLog(@"7.4 代替通知: ---------- %@",x);
    }];
    
    //7.5 监听文本框文字改变:
    [[self.textField.rac_textSignal skip:1] subscribeNext:^(id x) {
        NSLog(@"7.5 监听文本框文字改变: ---------- %@",x);
    }];

    
    
    /**
    7.ReactiveCocoa开发中常见用法。
    7.1 代替代理:
    
    rac_signalForSelector：用于替代代理。
    7.2 代替KVO :
    
    rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。
    7.3 监听事件:
    
    rac_signalForControlEvents：用于监听某个事件。
    7.4 代替通知:
    
    rac_addObserverForName:用于监听某个通知。
    7.5 监听文本框文字改变:
    
    rac_textSignal:只要文本框发出改变就会发出这个信号。
    7.6 处理当界面有多次请求时，需要都获取到数据时，才能展示界面
    
    rac_liftSelector:withSignalsFromArray:Signals:当传入的Signals(信号数组)，每一个signal都至少sendNext过一次，就会去触发第一个selector参数的方法。
    使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    */
    
    
}


@end
