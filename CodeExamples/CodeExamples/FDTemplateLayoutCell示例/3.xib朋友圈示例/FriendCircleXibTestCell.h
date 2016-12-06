//
//  FriendCircleXibTestCell.h
//  ReactCocoaDemo
//
//  Created by letian on 16/12/6.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendCircleModel;
@interface FriendCircleXibTestCell : UITableViewCell

- (void)cellDataWithModel:(FriendCircleModel *)model;

- (void)cellClickBt:(dispatch_block_t)clickBtBlock;

@end
