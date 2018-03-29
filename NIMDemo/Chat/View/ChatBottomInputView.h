//
//  ChatBottomInputView.h
//  NIMDemo
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChatBottomInputViewDelegate<NSObject>
/*要发送的文字内容消息*/
- (void)chatInputViewDidEndEdit:(NSString*)message;
/*改变self.view的高度*/
- (void)changeViewHeight:(CGFloat)height;
/*发送语音消息*/
- (void)sendVoiceMessage:(NSString*)recordPath
               aDuration:(NSInteger)aDuration;
/*发送图片消息*/
- (void)sendImageMessage:(UIImage*)image;
- (void)sendVideoMessage:(NSString *)path;
@end

@interface ChatBottomInputView : UIView
/** <#描述#> */
@property(nonatomic, weak) id<ChatBottomInputViewDelegate> delegate;
/** 左侧按钮 */
@property(nonatomic, strong)  UIButton  *  leftBtn;
/** 中间的输入框 */
@property(nonatomic, strong)  UITextView  *  inputText;
/** 发送语音的按钮 */
@property(nonatomic, strong)  UIButton  *  voiceBtn;
/** 表情按钮 */
@property(nonatomic, strong)  UIButton  *  faceBtn;
/** 右侧加号按钮 */
@property(nonatomic, strong)  UIButton  *  rightBtn;

/*释放第一响应者*/
- (void)resignResponder;
@end
