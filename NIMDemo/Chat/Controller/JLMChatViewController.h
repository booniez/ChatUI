//
//  JLMChatViewController.h
//  NIMDemo
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLMChatViewController : UIViewController
/** <#描述#> */
@property(nonatomic, strong) NIMSession *session;
/** <#描述#> */
@property(nonatomic, strong) SessionModel *model;
- (instancetype)initWithSession:(NIMSession *)session;
@end
