//
//  YLMessageFrame.m
//
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 袁量. All rights reserved.
//

#import "YLMessageFrame.h"
#import <UIKit/UIKit.h>
#import "YLMessage.h"

#import "NSString+YLNSString.h"
@implementation YLMessageFrame
- (void)setMessage:(YLMessage *)message
{
    _message = message;
    
    // 计算每个控件的frame 和 行高
    // 获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 设置一个统一的间距
    CGFloat margin = 5;
    
    // 计算时间label的frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    if (!message.hideTime) {
        // 如果需要显示时间label, 那么再计算时间label的frame
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    
    // 计算头像的frame
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
    CGFloat iconX = message.type == CZMessageTypeOther ? margin : screenW - margin - iconW;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    
    // 计算消息正文的frame
    // 1. 先计算正文的大小
    
    switch (message.messageType) {
        case NIMMessageTypeText:
        {
            CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:textFont];
            CGFloat textW = textSize.width + 40;
            CGFloat textH = textSize.height + 30;
            // 2. 再计算x,y
            CGFloat textY = iconY;
            CGFloat textX = message.type == CZMessageTypeOther ? CGRectGetMaxX(_iconFrame) : (screenW - margin - iconW - textW);
            
            
            _textFrame = CGRectMake(textX, textY, textW, textH);
        }
            break;
        case NIMMessageTypeImage:
        {
            NIMImageObject *fileObject = (NIMImageObject *)message.messageObject;
            CGSize imageSize = fileObject.size;
            CGFloat  scale = imageSize.width/imageSize.height;
            CGFloat imgW = imageSize.width + 0;
            CGFloat imgH = imageSize.height + 0;
            if (imageSize.width - imageSize.height > 0) {//宽大于高 横着
                imgH = [UIApplication sharedApplication].keyWindow.frame.size.height * 0.2;
                imgW = imgH * scale;
            }else{//竖着
                imgW = [UIApplication sharedApplication].keyWindow.frame.size.width * 0.3;
                imgH = imgW / (scale < 0.5 ? 0.5 : scale);
            }
            
            CGFloat imgY = iconY;
            CGFloat imgX = message.type == CZMessageTypeOther ? CGRectGetMaxX(_iconFrame) : (screenW - margin - iconW - imgW);
            _textFrame = CGRectMake(imgX, imgY, imgW, imgH);
        }
            break;
        case NIMMessageTypeAudio:
        {
            CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:textFont];
            CGFloat textW = textSize.width + 40;
            CGFloat textH = textSize.height + 30;
            // 2. 再计算x,y
            CGFloat textY = iconY;
            CGFloat textX = message.type == CZMessageTypeOther ? CGRectGetMaxX(_iconFrame) : (screenW - margin - iconW - textW);
            
            
            _textFrame = CGRectMake(textX, textY, textW, textH);
        }
            break;
        case NIMMessageTypeVideo:
        {
            NIMVideoObject *fileObject = (NIMVideoObject *)message.messageObject;
            CGSize videoSize = [fileObject coverSize];
//            CGFloat textW = videoSize.width + 40;
//            CGFloat textH = textSize.height + 30;
            CGFloat  scale = videoSize.width/videoSize.height;
            CGFloat imgW = videoSize.width + 0;
            CGFloat imgH = videoSize.height + 0;
            if (videoSize.width - videoSize.height > 0) {//宽大于高 横着
                imgH = [UIApplication sharedApplication].keyWindow.frame.size.height * 0.2;
                imgW = imgH * scale;
            }else{//竖着
                imgW = [UIApplication sharedApplication].keyWindow.frame.size.width * 0.3;
                imgH = imgW / (scale < 0.5 ? 0.5 : scale);
            }
            // 2. 再计算x,y
            CGFloat textY = iconY;
            CGFloat textX = message.type == CZMessageTypeOther ? CGRectGetMaxX(_iconFrame) : (screenW - margin - iconW - imgW);
            
            
            _textFrame = CGRectMake(textX, textY, imgW, imgH);
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    // 计算行高
    // 获取 头像的最大的Y值和正文的最大的Y值, 然后用最大的Y值+ margin
    CGFloat maxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = maxY + margin;
}

@end
