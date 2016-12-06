//
//  TestHeader.h
//  CodeExamples
//
//  Created by letian on 16/12/1.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#ifndef TestHeader_h
#define TestHeader_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LTUITools.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>



#define LT_WEAKSELF typeof(self) __weak weakSelf = self;
#define LT_STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#endif /* TestHeader_h */
