//
//  LTUITools.m
//  CodeExamples
//
//  Created by letian on 16/12/1.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import "LTUITools.h"

@implementation LTUITools

+ (UITableView *)lt_creatTableViewWithStyle:(UITableViewStyle )tableViewStyle
{
    UITableViewStyle style;
    style = tableViewStyle ? tableViewStyle : UITableViewStylePlain;
    UITableView * tableView  = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    return tableView;
}

+ (UILabel *)lt_creatLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    return label;
}

+ (UIView *)lt_creatView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

+ (UITextView *)lt_creatTextView;
{
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectZero];
    return textView;
}

+ (UIImageView *)lt_creatImageView
{
    UIImageView *imageView = [UIImageView new];
    return imageView;
}

+ (UICollectionView *)lt_creatCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    return collectionView;
}

+ (UITextField *)lt_creatTextField
{
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectZero];
    return textField;
}

@end
