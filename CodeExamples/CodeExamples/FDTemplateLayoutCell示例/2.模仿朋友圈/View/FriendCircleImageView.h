//
//  FriendCircleImageView.h
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCircleImageView : UIView

/** <#des#> */
@property (nonatomic,strong) UICollectionView * collectionView;

- (void)cellDataWithImageArray:(NSArray *)imageArray;

@end
