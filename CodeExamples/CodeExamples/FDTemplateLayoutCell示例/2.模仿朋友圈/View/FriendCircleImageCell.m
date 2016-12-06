//
//  FriendCircleImageCell.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FriendCircleImageCell ()

@end

@implementation FriendCircleImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [LTUITools lt_creatImageView];
        [self.contentView addSubview:self.imageView];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)cellDataWithImageName:(NSString *)imageName
{
//    self.imageView.image = [UIImage imageNamed:imageName];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
}

@end
