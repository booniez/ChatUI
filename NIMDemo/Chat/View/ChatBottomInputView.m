//
//  ChatBottomInputView.m
//  NIMDemo
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import "ChatBottomInputView.h"
#import "JLMChatMoreView.h"
#import <Foundation/Foundation.h>


#define kBORDERSIZE 5
#define kVOIVESIZE 40
@interface ChatBottomInputView()<UITextViewDelegate, NIMMediaManagerDelegate, NIMChatManagerDelegate, JLMChatMoreViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 是否选择了表情或者其他 */
@property(nonatomic, assign) BOOL isKeyBoard;
/** <#描述#> */
@property(nonatomic, assign) BOOL isVoice;
/** <#描述#> */
@property(nonatomic, copy) NSString *filePath;
/** <#描述#> */
@property(nonatomic, strong) JLMChatMoreView *moreView;
@end

@implementation ChatBottomInputView

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
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 0, self.frame.size.width, 0.8);
    [self addSubview:lineView];
    /// 左边按钮
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kBORDERSIZE, kBORDERSIZE + 0.8, kVOIVESIZE, kVOIVESIZE)];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_voice_normal"] forState:UIControlStateNormal];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_voice_pressed"] forState:UIControlStateHighlighted];
    [_leftBtn addTarget:self action:@selector(turnEmotionAndVoice) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    /// 输入框
    _inputText = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftBtn.frame) + kBORDERSIZE, kBORDERSIZE + 2.8, self.frame.size.width - 5 * kBORDERSIZE - 120, 35)];
    _inputText.delegate = self;
    _inputText.layer.cornerRadius = 8.0;
    _inputText.layer.masksToBounds = YES;
    _inputText.layer.borderColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1].CGColor;
    _inputText.layer.borderWidth = 0.8;
    _inputText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inputText.returnKeyType = UIReturnKeySend;
    _inputText.font = [UIFont systemFontOfSize:16];
    [self addSubview:_inputText];
    
    /// 笑脸
    _faceBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_inputText.frame), kBORDERSIZE + 0.8, kVOIVESIZE, kVOIVESIZE)];
    [_faceBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_emotion_normal"] forState:UIControlStateNormal];
    [_faceBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_emotion_pressed"] forState:UIControlStateHighlighted];
    [self addSubview:_faceBtn];
    
    /// 加号
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - kBORDERSIZE - kVOIVESIZE, kBORDERSIZE + 0.8, kVOIVESIZE, kVOIVESIZE)];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_add_normal"] forState:UIControlStateNormal];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_add_pressed"] forState:UIControlStateHighlighted];
    [_rightBtn addTarget:self action:@selector(rightBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    
    /*录制语音按钮*/
    _voiceBtn = [[UIButton alloc]initWithFrame:_inputText.frame];
    _voiceBtn.layer.cornerRadius = 8.0;
    _voiceBtn.layer.masksToBounds = YES;
    _voiceBtn.layer.borderWidth = 0.8;
    [_voiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _voiceBtn.layer.borderColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1].CGColor;
    [_voiceBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [_voiceBtn setTitle:@"松开 结束" forState:UIControlStateHighlighted];
    [_voiceBtn addTarget:self action:@selector(voiceBtnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    _voiceBtn.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
    [_voiceBtn addTarget:self action:@selector(voiceBtnDidPress:) forControlEvents:UIControlEventTouchDown];
    _voiceBtn.hidden = true;
    [self addSubview:_voiceBtn];
    
    _moreView = [[JLMChatMoreView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height - 250, [UIApplication sharedApplication].keyWindow.frame.size.width, 250)];
    _moreView.delegate = self;
    
    
}
/*右侧按钮点击*/
- (void)rightBtnDidPress:(UIButton*)button{
    if (_inputText.inputView == nil) {
        _inputText.inputView = _moreView;
        //左侧按钮修改
        _voiceBtn.hidden = YES;
    }else{
        _inputText.inputView = nil;
    }
    _isKeyBoard = YES;
    [self.inputText endEditing:YES];
    _isKeyBoard = NO;
    [self.inputText becomeFirstResponder];
}
- (void)didSelected:(NSInteger)tag {
    switch (tag) {
        case 0:{ // 图片
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController* imagePicker;
                imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate =self;
                imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
                if (self.delegate) {
                    UIViewController * vc = (UIViewController*)self.delegate;
                    imagePicker.navigationBar.barTintColor = vc.navigationController.navigationBar.barTintColor;
                    [vc presentViewController:imagePicker animated:YES completion:nil];
                }
            }
            break;
        }
            
        default:
            break;
    }
}
/*录制语音按钮按下去*/
- (void)voiceBtnDidPress:(UIButton*)button{
    NIMAudioType type = NIMAudioTypeAAC;
    NSTimeInterval duration = [NIMKit sharedKit].config.recordMaxDuration;
    
    [[NIMSDK sharedSDK].mediaManager addDelegate:self];
    
    [[NIMSDK sharedSDK].mediaManager record:type
                                   duration:duration];
}

- (void)recordAudio:(NSString *)filePath didCompletedWithError:(NSError *)error {
    NSLog(@"停止录音%@",filePath);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendVoiceMessage:aDuration:)]) {
        [self.delegate sendVoiceMessage:filePath aDuration:0];
    }
}

/*录音按钮松开*/
- (void)voiceBtnTouchUp:(UIButton*)button{
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    
}

- (void)turnEmotionAndVoice {
    NSLog(@"%@",_leftBtn.currentBackgroundImage);
    if (_isVoice) {
        _voiceBtn.hidden = true;
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_voice_normal"] forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_voice_pressed"] forState:UIControlStateHighlighted];
    }else {
        _voiceBtn.hidden = NO;
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_keyboard_normal"] forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"NIMKitResource.bundle/icon_toolview_keyboard_pressed"] forState:UIControlStateHighlighted];
    }
    _isVoice = !_isVoice;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) return;
    
    // 点击了完成按钮
    if ([textView.text hasSuffix:@"\n"]) {
        if ([textView.text isEqualToString:@"\n"]) {
            return;
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatInputViewDidEndEdit:)]) {
                
                NSString * outPutStr = [self fullText];
                
                [self.delegate chatInputViewDidEndEdit:[outPutStr substringToIndex:outPutStr.length-1]];
                
            }
        }
        textView.text = @"";
        [textView resignFirstResponder];
    }
}
/** 获取输入框的文字 */
- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self.inputText.attributedText enumerateAttributesInRange:NSMakeRange(0, self.inputText.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        NSAttributedString *str = [self.inputText.attributedText attributedSubstringFromRange:range];
        [fullText appendString:str.string];
    }];
    
    return fullText;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image !=nil) {
        //处理图片
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendImageMessage:)]) {
            [self.delegate sendImageMessage:image];
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    NSString *video = [[info objectForKey:UIImagePickerControllerMediaURL] absoluteString];
    if (video) {
        NSMutableArray *array = [NSMutableArray arrayWithObject:[info objectForKey:UIImagePickerControllerPHAsset]];
        [self requestAssets:array];
//
//        NSString *str = [video substringFromIndex:[video rangeOfString:@"private"].location + [video rangeOfString:@"private"].length];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(sendVideoMessage:)]) {
//            [self.delegate sendVideoMessage:str];
//            NSLog(@"发送的视频地址%@",str);
//        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:@[asset]];
    [self requestAssets:items];
}
 */

- (void)requestAssets:(NSMutableArray *)assets
{
    if (!assets.count) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self requestAsset:assets.firstObject handler:^(NSString *path, PHAssetMediaType type) {
//        if (weakSelf.libraryResultHandler)
//        {
//            weakSelf.libraryResultHandler(nil,path,type);
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendVideoMessage:)]) {
            [self.delegate sendVideoMessage:path];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [assets removeObjectAtIndex:0];
            [weakSelf requestAssets:assets];
        });
        
    }];
}

- (void)requestAsset:(PHAsset *)asset handler:(void(^)(NSString *,PHAssetMediaType)) handler
{
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        [[PHImageManager defaultManager] requestExportSessionForVideo:asset options:options exportPreset:AVAssetExportPresetMediumQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
            
            NSString *outputFileName = [NIMKitFileLocationHelper genFilenameWithExt:@"mp4"];
            NSString *outputPath = [NIMKitFileLocationHelper filepathForVideo:outputFileName];
            
            exportSession.outputURL = [NSURL fileURLWithPath:outputPath];
            exportSession.outputFileType = AVFileTypeMPEG4;
            exportSession.shouldOptimizeForNetworkUse = YES;
            [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (exportSession.status == AVAssetExportSessionStatusCompleted)
                     {
                         handler(outputPath, PHAssetMediaTypeVideo);
                     }
                     else
                     {
                         handler(nil,PHAssetMediaTypeVideo);
                     }
                 });
             }];
        }];
    }
    
    if (asset.mediaType == PHAssetMediaTypeImage)
    {
        [asset requestContentEditingInputWithOptions:nil completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
            NSString *path = contentEditingInput.fullSizeImageURL.relativePath;
            handler(path,contentEditingInput.mediaType);
        }];
    }
    
 }
/*释放第一响应者*/
- (void)resignResponder{
    [_inputText resignFirstResponder];
    _inputText.inputView = nil;
}

/*成为第一响应者*/
- (void)becomeResponder{
    if (_inputText) {
        [_inputText becomeFirstResponder];
    }
}


@end
