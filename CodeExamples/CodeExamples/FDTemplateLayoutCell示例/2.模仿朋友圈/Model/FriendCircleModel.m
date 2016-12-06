//
//  FriendCircleModel.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleModel.h"

@implementation FriendCircleModel

+ (NSArray <FriendCircleModel *>*)getDatasFormPlist
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Property List.plist" ofType:nil];
    NSArray * data = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray * datas = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        FriendCircleModel * model = [FriendCircleModel new];
        [model setValuesForKeysWithDictionary:dic];
        [datas addObject:model];
    }
    return datas.copy;
}

@end
