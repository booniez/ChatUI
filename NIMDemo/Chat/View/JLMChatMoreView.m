//
//  JLMChatMoreView.m
//  NIMDemo
//
//  Created by 袁量 on 2018/3/29.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import "JLMChatMoreView.h"
#define kBORDERWIDTH 30

@interface JLMChatMoreView()
/** <#描述#> */
@property(nonatomic, strong) UIButton *pictureBtn;
@end
@implementation JLMChatMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    CGFloat btnWidth = ([UIApplication sharedApplication].keyWindow.frame.size.width - 5 * kBORDERWIDTH ) / 4;
    CGFloat btnHeight = btnWidth;
    NSArray * titleArr = @[@"图片",@"拍摄",@"位置",@"图片"];
    NSArray * imageArr = @[@"NIMKitResource.bundle/bk_media_picture_",@"NIMKitResource.bundle/bk_media_shoot_",@"NIMKitResource.bundle/bk_media_position_",@"NIMKitResource.bundle/bk_media_picture_"];
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(kBORDERWIDTH + i * (btnWidth +kBORDERWIDTH), 30, btnWidth, btnHeight)];
        button.tag = 1888888 + i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@normal",imageArr[i]]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@pressed",imageArr[i]]] forState:UIControlStateHighlighted];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(otherBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            self.pictureBtn = button;
        }
        [self addSubview:button];
    }
}
- (void)otherBtnDidPress:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelected:)]) {
        [self.delegate didSelected:button.tag - 1888888];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
