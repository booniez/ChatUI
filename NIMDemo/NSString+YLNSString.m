//
//  NSString+YLNSString.m
//  StudentsOnlineTutoringSystem
//
//  Created by 袁量 on 2017/5/4.
//  Copyright © 2017年 袁量. All rights reserved.
//

#import "NSString+YLNSString.h"
@implementation NSString (YLNSString)
// 对象方法
// 实现对象方法
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

// 类方法
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font
{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
