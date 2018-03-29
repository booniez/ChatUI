//
//  YLMessageCell.h
//
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 袁量. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLMessageFrame;
@interface YLMessageCell : UITableViewCell
// 为自定义单元格增加一个frame 模型属性
@property (nonatomic, strong) YLMessageFrame *messageFrame;


// 封装一个创建自定义Cell的方法
+ (instancetype)messageCellWithTableView:(UITableView *)tableView;

@end
