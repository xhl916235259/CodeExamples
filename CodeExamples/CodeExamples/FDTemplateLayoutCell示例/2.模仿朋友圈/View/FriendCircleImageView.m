//
//  FriendCircleImageView.m
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "FriendCircleImageView.h"
#import "FriendCircleImageCell.h"
#import "SDPhotoBrowser.h"

@interface FriendCircleImageView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SDPhotoBrowserDelegate>

/** <#des#> */
//@property (nonatomic,strong) UICollectionView * collectionView;

/** <#des#> */
@property (nonatomic,strong) NSArray * images;
@end

@implementation FriendCircleImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self setConstant];
    }
    return self;
}

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    [self setupUI];
    [self setConstant];
}

#pragma mark - 设置UI
- (void)setupUI
{
    self.collectionView = [LTUITools lt_creatCollectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:[FriendCircleImageCell class] forCellWithReuseIdentifier:@"FriendCircleImageCell"];
    [self addSubview:self.collectionView];
    
}

#pragma mark - 设置约束
- (void)setConstant
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCircleImageCell * cell = (FriendCircleImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FriendCircleImageCell" forIndexPath:indexPath];
    [cell cellDataWithImageName:self.images[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.images.count == 1) {
        return CGSizeMake(self.frame.size.width, 160);
    } else if(self.images.count >1){
        CGFloat width = (self.frame.size.width - 20)/3;
        return CGSizeMake(width, 100);
    }else{
        return CGSizeZero;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = indexPath.row;
    browser.sourceImagesContainerView = self.collectionView;
    browser.imageCount = self.images.count;
    browser.delegate = self;
    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url;
    if (index < self.images.count) {
        url = [NSURL URLWithString:self.images[index]];
    }
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    FriendCircleImageCell * cell = (FriendCircleImageCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"FriendCircleImageCell" forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell.imageView.image;
}

- (void)cellDataWithImageArray:(NSArray *)imageArray
{
    self.images = imageArray;
    CGFloat height = 0;
    
    if (imageArray.count == 1) {
        height = 160;
    } else if (imageArray.count > 1){
        int columnCount = ceilf(self.images.count * 1.0 / 3);
        height = columnCount * 100 + (columnCount - 1) * 10;
    } else{
        height = 0;
    }
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.collectionView reloadData];
}

@end
