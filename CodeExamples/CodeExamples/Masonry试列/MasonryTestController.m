
//
//  MasonryTestController.m
//  CodeExamples
//
//  Created by letian on 16/12/1.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "MasonryTestController.h"

@interface MasonryTestController () <UITableViewDataSource, UITableViewDelegate>

/** <#des#> */
@property (nonatomic,strong) UITableView * tableView;

/** <#des#> */
@property (nonatomic,strong) NSArray <NSString *> * datas;

@end

@implementation MasonryTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setConstant];
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"masonry示例";
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewdelegate &&  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.datas[indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Class class = NSClassFromString([self.datas[indexPath.row] valueForKey:@"className"]);
    UIViewController * controller = [class new];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.title = [self.datas[indexPath.row] valueForKey:@"title"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - getter
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [LTUITools lt_creatTableViewWithStyle:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray <NSString *> *)datas
{
    if(!_datas){
        _datas = @[@{@"title":@"文字居中与图片",
                     @"className":@"MasonryTest1Controller"},
                   @{@"title":@"父View是一个子View",
                     @"className":@"MasonryTest2Controller"},
                   @{@"title":@"等间距",
                     @"className":@"MasonryTest3Controller"},
                   @{@"title":@"动画更新",
                     @"className":@"MasonryTest4Controller"}];
    }
    return _datas;
}

@end
