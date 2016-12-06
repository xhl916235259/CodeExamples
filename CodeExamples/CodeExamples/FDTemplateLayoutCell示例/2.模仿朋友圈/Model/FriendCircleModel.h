//
//  FriendCircleModel.h
//  ReactCocoaDemo
//
//  Created by letian on 16/12/5.
//  Copyright © 2016年 cmsg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendCircleModel : NSObject

/** <#des#> */
@property (nonatomic,copy) NSString * icon;

/** <#des#> */
@property (nonatomic,copy) NSString * userId;

/** <#des#> */
@property (nonatomic,copy) NSString * name;

/** <#des#> */
@property (nonatomic,copy) NSString * personalizedSignature;

/** <#des#> */
@property (nonatomic,copy) NSString * content;

/** <#des#> */
@property (nonatomic,copy) NSString * time;

/** <#des#> */
@property (nonatomic,strong) NSArray * images;

/** <#des#> */
@property (nonatomic, assign,getter=isSelect) BOOL select;

+ (NSArray <FriendCircleModel *>*)getDatasFormPlist;

@end
