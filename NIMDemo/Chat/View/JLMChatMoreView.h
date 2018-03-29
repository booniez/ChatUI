//
//  JLMChatMoreView.h
//  NIMDemo
//
//  Created by 袁量 on 2018/3/29.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLMChatMoreViewDelegate <NSObject>

@optional
- (void)didSelected:(NSInteger)tag;
@end

@interface JLMChatMoreView : UIView
/** <#描述#> */
@property(nonatomic, weak) id <JLMChatMoreViewDelegate> delegate;
@end
