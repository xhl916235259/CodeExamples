//
//  FriendCircleImageCell.h
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCircleImageCell : UICollectionViewCell

/** <#des#> */
@property (nonatomic,strong) UIImageView * imageView;

- (void)cellDataWithImageName:(NSString *)imageName;

@end
