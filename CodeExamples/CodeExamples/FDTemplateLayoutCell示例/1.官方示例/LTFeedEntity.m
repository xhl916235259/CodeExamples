//
//  FDFeedEntity.m
//  CodeExamples
//
//  Created by sunnyxx on 15/4/16.
//  Copyright (c) 2015年 forkingdog. All rights reserved.
//

#import "LTFeedEntity.h"

@implementation LTFeedEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _identifier = [self uniqueIdentifier];
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
