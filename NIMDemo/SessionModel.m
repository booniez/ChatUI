//
//  SessionModel.m
//  NIMDemo
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import "SessionModel.h"

@implementation SessionModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict

{
    return [[self alloc] initWithDictionary:dict];
}
- (instancetype)initWithDictionary:(NSDictionary *)dict

{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
    
}
+ (SessionModel *)getCurrentSession {
    return [[SessionModel alloc] init];
}
@end
