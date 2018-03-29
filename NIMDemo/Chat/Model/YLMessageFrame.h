//
//  YLMessageFrame.h
//  
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 袁量. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#define textFont [UIFont systemFontOfSize:13]
@class YLMessage;
@interface YLMessageFrame : NSObject
// 引用数据模型
@property (nonatomic, strong) YLMessage *message;

// 时间Label的frame
@property (nonatomic, assign, readonly) CGRect timeFrame;

// 头像的frame
@property (nonatomic, assign, readonly) CGRect iconFrame;

// 正文的frame
@property (nonatomic, assign, readonly) CGRect textFrame;

/**
 *语音的frame + CGRect
 */
@property (nonatomic, assign, readonly) CGRect voiceFrame;
/**
 *图片的frame + CGRect
 */
@property (nonatomic, assign, readonly) CGRect imageFrame;

// 行高
@property (nonatomic, assign, readonly) CGFloat rowHeight;


@end
