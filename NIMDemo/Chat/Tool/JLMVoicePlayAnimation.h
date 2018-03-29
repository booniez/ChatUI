//
//  JLMVoicePlayAnimation.h
//  NIMDemo
//
//  Created by 袁量 on 2018/3/29.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLMVoicePlayAnimation : NSObject
+ (instancetype)sharedTool;
/*开始动画*/
- (void)startAnimationWithBtn:(UIButton*)button
                       isMine:(BOOL)isMine;
/*停止动画*/
- (void)endAnimation;
@end
