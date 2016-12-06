//
//  FDTemplateLayoutCellTabbarController.m
//  CodeExamples
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FDTemplateLayoutCellTabbarController.h"

@interface FDTemplateLayoutCellTabbarController () <UITableViewDataSource, UITableViewDelegate>

/** <#des#> */
@property (nonatomic,strong) NSArray <NSDictionary *> * datas;

/** <#des#> */
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation FDTemplateLayoutCellTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setConstant];
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [LTUITools lt_creatTableViewWithStyle:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewdelegate &&  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text = [self.datas[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * controller;
    if (indexPath.row == 0) {
        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        controller = [storyBoard instantiateViewControllerWithIdentifier:@"FDTemplateLayoutCellTestController"];
    } else {
        
        Class class = NSClassFromString([self.datas[indexPath.row] valueForKey:@"className"]);
        controller = [class new];
    }
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.title = [self.datas[indexPath.row] valueForKey:@"title"];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - getter
- (NSArray <NSDictionary *> *)datas
{
    if(!_datas){
        _datas = @[@{@"title":@"官方示例",
                     @"className":@"FDTemplateLayoutCellTestController"},
                   @{@"title":@"朋友圈",
                     @"className":@"FriendCircleController"},
                   @{@"title":@"多图片测试",
                     @"className":@"FriendCircleImageViewTestController"},
                   @{@"title":@"xib朋友圈示例",
                     @"className":@"FriendCircleXibTestController"}];
    }
    return _datas;
}

@end
