//
//  NSString+YLNSString.h
//  StudentsOnlineTutoringSystem
//
//  Created by 袁量 on 2017/5/4.
//  Copyright © 2017年 袁量. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (YLNSString)
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

// 类方法
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

@end
