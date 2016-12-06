//
//  FriendCircleXibTestController.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/6.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleXibTestController.h"
#import "FriendCircleXibTestCell.h"
#import "FriendCircleModel.h"

@interface FriendCircleXibTestController () <UITableViewDelegate, UITableViewDataSource>

/** <#des#> */
@property (nonatomic,strong) UITableView * tableView;
/** <#des#> */
@property (nonatomic,strong) NSArray * datas;

@end

@implementation FriendCircleXibTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setConstant];
    
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendCircleXibTestCell" bundle:nil] forCellReuseIdentifier:@"FriendCircleXibTestCell"];
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
    FriendCircleXibTestCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCircleXibTestCell"];
    [cell cellDataWithModel:self.datas[indexPath.row]];
    [cell cellClickBt:^{
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView fd_heightForCellWithIdentifier:@"FriendCircleXibTestCell" cacheByIndexPath:indexPath configuration: ^(FriendCircleXibTestCell *cell) {
        if (indexPath.row < self.datas.count) {
            [cell cellDataWithModel:self.datas[indexPath.row]];
        }
    }];
}

#pragma mark - getter
- (NSArray *)datas
{
    if(!_datas){
        _datas = [FriendCircleModel getDatasFormPlist];
    }
    return _datas;
}

@end
