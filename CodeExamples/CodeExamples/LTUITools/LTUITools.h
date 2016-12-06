//
//  LTUITools.h
//  CodeExamples
//
//  Created by letian on 16/12/1.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTUITools : NSObject


/**
 @param tableViewStyle 样式
 @return UITableView实例
 */
+ (UITableView *)lt_creatTableViewWithStyle:(UITableViewStyle )tableViewStyle;

/**
 @return labe实例,默认换行0，字体14，黑色字体
 */
+ (UILabel *)lt_creatLabel;

/**
 @return UIView实例,默认亮灰色
 */
+ (UIView *)lt_creatView;

/**
 @return 返回UITextView实例
 */
+ (UITextView *)lt_creatTextView;


/**
 @return UIImageView实例
 */
+ (UIImageView *)lt_creatImageView;

/**
 @return collectionView实例
 */
+ (UICollectionView *)lt_creatCollectionView;

/**
 @return TextField实例
 */
+ (UITextField *)lt_creatTextField;

@end
