//
//  FriendCircleCell.h
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendCircleModel;
@interface FriendCircleCell : UITableViewCell

- (void)cellDataWithModel:(FriendCircleModel *)model;

- (void)cellClickBt:(dispatch_block_t)clickBtBlock;

@end
