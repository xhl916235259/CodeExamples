//
//  MainViewController.m
//  CodeExamples
//
//  Created by letian on 16/12/1.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "MainViewController.h"
#import "MasonryTestController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
/** <#des#> */
@property (nonatomic,strong) UITableView * tableView;
/** <#des#> */
@property (nonatomic,strong) NSArray <NSDictionary *> * datas;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setConstant];
    
}


#pragma mark - 设置UI
- (void)setupUI
{
   self.view.backgroundColor = [UIColor redColor];
    self.title = @"测试";
}
#pragma mark - 设置约束
- (void)setConstant
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).offset(0);
        
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.datas[indexPath.row] objectForKey:@"title"];
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
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray<NSDictionary *> *)datas
{
    if(!_datas){
        _datas = @[@{@"title":@"masonry",
                     @"className":@"MasonryTestController"},
                   @{@"title":@"FDTemplateLayoutCell",
                     @"className":@"FDTemplateLayoutCellTabbarController"},
                   @{@"title":@"Rac常见用法",
                     @"className":@"RacTestController"}];
    }
    return _datas;
}
@end
