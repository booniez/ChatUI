//
//  YLMessageCell.m
//
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 袁量. All rights reserved.
//

#import "YLMessageCell.h"
#import "YLMessage.h"
#import "YLMessageFrame.h"
#import "JLMVoicePlayAnimation.h"
#import "JLMVideoView.h"
#import "ZFPlayerView.h"
@interface YLMessageCell()<NIMMediaManagerDelegate, ZFPlayerDelegate>
@property (nonatomic, weak) UILabel *lblTime;
@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UIButton *btnText;
/** <#描述#> */
@property(nonatomic, strong) JLMVideoView *videoView;
@property(nonatomic, strong)  ZFPlayerView  *playerView;
@end
@implementation YLMessageCell


#pragma mark -  重写initWithStyle方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[NIMSDK sharedSDK].mediaManager addDelegate:self];
        // 创建子控件
        // 显示时间的label
        UILabel *lblTime = [[UILabel alloc] init];
        // 设置文字大小
        lblTime.font = [UIFont systemFontOfSize:12];
        // 设置文字居中
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        // 显示头像的UIImageView
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        // 显示正文的按钮
        UIButton *btnText = [[UIButton alloc] init];
        // 设置正文的字体大小
        btnText.titleLabel.font = textFont;
        // 修改按钮的正文文字颜色
        [btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // 设置按钮中的label的文字可以换行
        btnText.titleLabel.numberOfLines = 0;
        // 设置按钮的背景色
        //btnText.backgroundColor = [UIColor purpleColor];
        [btnText addTarget:self action:@selector(contentTapped) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮中的titleLabel的背景色
        //btnText.titleLabel.backgroundColor = [UIColor greenColor];
        
        // 设置按钮的内边距
        btnText.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
        JLMVideoView *videoView = [[JLMVideoView alloc] init];
        self.videoView = videoView;
        [self.contentView addSubview:self.videoView];
        [self.videoView setHidden:true];
        
        //语音的 Btu
//        UIButton *voiceBtu = [[UIButton alloc] init];
        
    }
    
    // 设置单元格的背景色为clearColor
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    NSLog(@"即将进行播放");
}
/// 消息被点击
- (void)contentTapped {
    switch (self.messageFrame.message.messageType) {
        case NIMMessageTypeAudio:
            {
                [[JLMVoicePlayAnimation sharedTool] startAnimationWithBtn:self.btnText isMine:self.messageFrame.message.type ? true : false];
                NIMAudioObject *fileObject = (NIMAudioObject *)self.messageFrame.message.messageObject;
                [[NIMSDK sharedSDK].mediaManager play:fileObject.path];
            }
            break;
        case NIMMessageTypeImage:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NIMImageObject *fileObject = (NIMImageObject *)self.messageFrame.message.messageObject;
                    IDMPhotoBrowser * p = [[IDMPhotoBrowser alloc] initWithPhotoURLs:[NSArray arrayWithObject:fileObject.url] animatedFromView:self.btnText];
                    [p setInitialPageIndex:self.btnText.tag];
                    p.displayDoneButton = NO;
                    p.dismissOnTouch = YES;
                    p.usePopAnimation = NO;
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:p animated:YES completion:^{
                        
                    }];
                });
                
            }
            break;
        default:
            break;
    }
    
}
- (void)playAudio:(NSString *)filePath didCompletedWithError:(NSError *)error {
    [[JLMVoicePlayAnimation sharedTool] endAnimation];
}
#pragma mark -  重写frame 模型的set方法
- (void)setMessageFrame:(YLMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    // 获取数据模型
    YLMessage *message = messageFrame.message;
    
    // 分别设置每个子控件的数据 和 framer
    
    // 设置 "时间Label"的数据 和 frame
//    self.lblTime.text = message.time;
//    self.lblTime.frame = messageFrame.timeFrame;
//    self.lblTime.hidden = message.hideTime;
    
    
    
    // 设置 头像
    // 根据消息类型, 判断应该使用哪张图片
    NSString *iconImg = message.type == CZMessageTypeMe ? @"NIMKitResource.bundle/avatar_team" : @"NIMKitResource.bundle/avatar_user";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    self.imgViewIcon.layer.cornerRadius = self.imgViewIcon.bounds.size.width / 2;
    self.imgViewIcon.layer.masksToBounds = YES;
    
    
    if (message.messageType == NIMMessageTypeText) {
        [self.btnText setTitle:message.text forState:UIControlStateNormal];
    }else if (message.messageType == NIMMessageTypeAudio) {
        [self.btnText setImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_receiver_voice_playing"] forState:UIControlStateNormal];
    }else if (message.messageType == NIMMessageTypeImage) {
        [self.btnText setTitle:@"图片" forState:UIControlStateNormal];
        self.btnText.imageEdgeInsets = UIEdgeInsetsMake(-12, -12, -13, -11);
        [self.btnText setTitle:@"" forState:UIControlStateNormal];
        self.btnText.imageView.layer.cornerRadius = 4.0;
        self.btnText.imageView.layer.masksToBounds = YES;
        self.btnText.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.btnText.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        NIMImageObject *fileObject = (NIMImageObject *)self.messageFrame.message.messageObject;
        NSString *path = fileObject.path;
        NSFileManager * fileMgr = [NSFileManager defaultManager];
        NSURL * url = [fileMgr fileExistsAtPath:path] ? [NSURL fileURLWithPath:path] : [NSURL URLWithString:fileObject.url];
        CGSize imageSize = fileObject.size;
        NSLog(@"宽度%f高度%f",imageSize.width,imageSize.height);
        [self.btnText.imageView setContentMode:UIViewContentModeScaleAspectFill];
        self.btnText.imageView.clipsToBounds = YES;
        
        
        [self.btnText sd_setImageWithURL:url forState:UIControlStateNormal];
        
        
    }else if (message.messageType == NIMMessageTypeVideo) {
        NIMVideoObject *fileObject = (NIMVideoObject *)message.messageObject;
        _videoView.coverPath = fileObject.coverUrl;
        [self.btnText setImage:[self UIViewToUIImageView:_videoView] forState:UIControlStateNormal];
        _videoView.videoDidPress = ^(UIView *view) {
            self.playerView = [[ZFPlayerView alloc] init];
            self.playerView.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            [self.contentView addSubview:self.playerView];
            ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
            // model
            ZFPlayerModel *playerModel = [[ZFPlayerModel alloc]init];
            playerModel.fatherView = view;
            playerModel.videoURL = [NSURL URLWithString:fileObject.url];
            playerModel.title = @"视频";
            [self.playerView playerControlView:controlView playerModel:playerModel];
            self.playerView.delegate = self;
            [self.playerView play];
            [self.playerView autoPlayTheVideo];
        };
        [_videoView setHidden:false];
        
        
        
    }
    self.btnText.frame = messageFrame.textFrame;
    self.videoView.frame = messageFrame.textFrame;
    
    // 设置正文的背景图
    NSString *imgNor, *imgHighlighted;
    if (message.type == CZMessageTypeMe) {
        // 自己发的消息
        NSLog(@"自己发的");
        
        imgNor = @"SenderTextNodeBkg";
        imgHighlighted = @"SenderTextNodeBkgHL";
        // 设置消息的正文文字颜色为 "白色"
        [self.btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        // 对方发的消息
        NSLog(@"对方发的");
        imgNor = @"ReceiverTextNodeBkg";
        imgHighlighted = @"ReceiverTextNodeBkgHL";
        
        // 设置消息的正文文字颜色为 "黑色"
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    // 加载图片
    UIImage *imageNormal = [UIImage imageNamed:imgNor];
    UIImage *imageHighlighted = [UIImage imageNamed:imgHighlighted];
    
    // 用平铺的方式拉伸图片
    imageNormal = [imageNormal stretchableImageWithLeftCapWidth:imageNormal.size.width * 0.5 topCapHeight:imageNormal.size.height * 0.5];
    imageHighlighted = [imageHighlighted stretchableImageWithLeftCapWidth:imageHighlighted.size.width * 0.5 topCapHeight:imageHighlighted.size.height * 0.5];
    
    // 设置背景图
    [self.btnText setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
}


#pragma mark -  创建自定义Cell的方法
+ (instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"message_cell";
    YLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YLMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(UIImage*)UIViewToUIImageView:(UIView*)view{
    CGSize size = view.bounds.size;
    // 下面的方法：第一个参数表示区域大小；第二个参数表示是否是非透明的如果需要显示半透明效果，需要传NO，否则传YES；第三个参数是屏幕密度
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
