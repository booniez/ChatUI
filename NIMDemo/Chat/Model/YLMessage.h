//
//  YLMessage.h
//
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 袁量. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef enum {
//    YLCellStyleTypeVoice = 0, // 语音
//    YLCellStyleTypeImage = 1, //图片
//    YLCellStyleTypeText = 2,   //文字
//    YLCellStyleTypeVideo = 3,  //视频
//    YLCellStyleTypeScreen = 4, //白板请求
//} YLCellStyleType;

typedef enum {
    CZMessageTypeMe = 0,    // 表示自己
    CZMessageTypeOther = 1,  // 表示对方
} CZMessageType;

@interface YLMessage : NSObject
// 消息正文
@property (nonatomic, copy) NSString *text;

// 消息发送时间
@property (nonatomic, copy) NSString *time;

// 消息来源（表示是对方发送的消息还是自己发送的消息）
@property (nonatomic, assign) CZMessageType type;
/** 消息类型 */
@property(nonatomic, assign) NIMMessageType messageType;

// 用来记录是否需要显示"时间Label"
@property (nonatomic, assign) BOOL hideTime;
/** 消息附件 */
@property(nonatomic, strong) id<NIMMessageObject> messageObject;;


/**
 *标志是不是 + ENUM
 */
//@property (nonatomic, assign) YLCellStyleType cellType;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;


@end
