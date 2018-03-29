//
//  JLMVideoView.m
//  NIMDemo
//
//  Created by 袁量 on 2018/3/29.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import "JLMVideoView.h"
@interface JLMVideoView()
/** 图片 */

@end
@implementation JLMVideoView
//- (instancetype)init{
//    if (self = [super init]) {
//        self.backImageView = [[UIImageView alloc]init];
//        self.videoImgView = [[UIImageView alloc]init];
//        self.videoImgView.userInteractionEnabled = YES;
//        self.videoImgView.image = [UIImage imageNamed:@"NIMKitResource.bundle/icon_play_normal"];
//        UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoImageViewDidPress)];
//        [self.videoImgView addGestureRecognizer:sigleTap];
//        [self addSubview:self.backImageView];
//        [self addSubview:self.videoImgView];
//
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImageView = [[UIImageView alloc]init];
        self.videoImgView = [[UIImageView alloc]init];
        self.videoImgView.userInteractionEnabled = YES;
        
        self.videoImgView.image = [UIImage imageNamed:@"NIMKitResource.bundle/icon_play_normal"];
        UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoImageViewDidPress)];
        [self.videoImgView addGestureRecognizer:sigleTap];
        [self addSubview:self.backImageView];
        [self addSubview:self.videoImgView];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.backImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.videoImgView.frame = CGRectMake(0, 0, 70, 70);
    self.videoImgView.center = self.backImageView.center;
}
- (void)setCoverPath:(NSString *)coverPath {
    _coverPath = coverPath;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:_coverPath]];
}

- (void)videoImageViewDidPress{
    _videoDidPress(self);
}

@end
