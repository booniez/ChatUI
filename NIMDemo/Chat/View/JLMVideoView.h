//
//  JLMVideoView.h
//  NIMDemo
//
//  Created by 袁量 on 2018/3/29.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^videoImageViewDidPress)(UIView * view);
@interface JLMVideoView : UIView
/** 视频播放图片 */
@property(nonatomic, strong) UIImageView *videoImgView;
/** <#描述#> */
@property(nonatomic, copy) videoImageViewDidPress videoDidPress;
/** <#描述#> */
@property(nonatomic, copy) NSString *coverPath;
/** <#描述#> */
@property(nonatomic, copy) NSString *path;
@property(nonatomic, strong)  UIImageView  *  backImageView;

@end
