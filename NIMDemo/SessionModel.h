//
//  SessionModel.h
//  NIMDemo
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionModel : NSObject
/** <#描述#> */
@property(nonatomic, copy) NSString *sessionID;
+(SessionModel *)getCurrentSession;
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
