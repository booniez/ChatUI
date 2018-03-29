//
//  YLMessage.m
//
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 袁量. All rights reserved.
//

#import "YLMessage.h"

@implementation YLMessage
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
