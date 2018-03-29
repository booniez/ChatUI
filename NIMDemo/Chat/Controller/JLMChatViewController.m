//
//  JLMChatViewController.m
//  NIMDemo
//
//  Created by 袁量 on 2018/3/27.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import "JLMChatViewController.h"
#import "ChatBottomInputView.h"

#import "YLMessage.h"
#import "YLMessageFrame.h"
#import "YLMessageCell.h"

@interface JLMChatViewController ()<UITableViewDelegate, UITableViewDataSource, NIMChatManagerDelegate, ChatBottomInputViewDelegate, NIMConversationManagerDelegate>
/** tableView */
@property(nonatomic, strong) UITableView  *chatTableView;
/** 数据源数组 */
@property(nonatomic, strong) NSMutableArray  *dataArr;
@property(nonatomic, strong) ChatBottomInputView *inputView;
@property (nonatomic, strong) NSMutableArray *messageFrames;
@end

@implementation JLMChatViewController

- (instancetype)initWithSession:(NIMSession *)session{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _session = session;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
    [self setupUI];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    // Do any additional setup after loading the view.
}
- (void)initial {
    _inputView.delegate = self;
    _dataArr = [NSMutableArray array];
    _messageFrames = [NSMutableArray array];
}
- (void)loadMore {
//    [NIMSDK sharedSDK].conversationManager mess
}
- (void)setupUI {
    _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height - 50) style:UITableViewStylePlain];
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
    [self.view addSubview:_chatTableView];
    /// 输入框
    _inputView = [[ChatBottomInputView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height - 50, [UIApplication sharedApplication].keyWindow.frame.size.width, 50)];
    _inputView.delegate = self;
    [self.view addSubview:_inputView];
}
/// 发送语音消息
- (void)sendVoiceMessage:(NSString *)recordPath aDuration:(NSInteger)aDuration {
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    // 构造出具体会话
    NIMSession *session = [NIMSession session:[_model.sessionID isEqualToString:@"123"] ? @"456" : @"123" type:NIMSessionTypeP2P];
    // 获得语音附件对象
    NIMAudioObject *object = [[NIMAudioObject alloc] initWithSourcePath:recordPath];
    // 构造出具体消息并注入附件
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = object;
    message.from = _model.sessionID;
    // 错误反馈对象
    NSError *error = nil;
    
    YLMessage *model = [YLMessage messageWithDict:@{@"text":@"语音",@"time":@(message.timestamp),@"type":@([message.from isEqualToString:_model.sessionID] ? CZMessageTypeMe : CZMessageTypeOther),@"messageObject":message.messageObject,@"messageType":@(NIMMessageTypeAudio)}];
    YLMessageFrame *modelFrame = [[YLMessageFrame alloc] init];
    modelFrame.message = model;
    [self.messageFrames addObject:modelFrame];
    [self.chatTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    if (indexPath.row == -1) {
        
    }else {
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    // 发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:&error];
    
}
/// 发送视频
- (void)sendVideoMessage:(NSString *)path {
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    // 构造出具体会话
    NIMSession *session = [NIMSession session:[_model.sessionID isEqualToString:@"123"] ? @"456" : @"123" type:NIMSessionTypeP2P];
    // 获得视频附件对象
    NIMVideoObject *object = [[NIMVideoObject alloc] initWithSourcePath:path];
    // 构造出具体消息并注入附件
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = object;
    message.from = _model.sessionID;
    // 错误反馈对象
    NSError *error = nil;
    
    YLMessage *model = [YLMessage messageWithDict:@{@"text":@"语音",@"time":@(message.timestamp),@"type":@([message.from isEqualToString:_model.sessionID] ? CZMessageTypeMe : CZMessageTypeOther),@"messageObject":message.messageObject,@"messageType":@(NIMMessageTypeVideo)}];
    YLMessageFrame *modelFrame = [[YLMessageFrame alloc] init];
    modelFrame.message = model;
    [self.messageFrames addObject:modelFrame];
    [self.chatTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    if (indexPath.row == -1) {
        
    }else {
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    // 发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:&error];
}
/// 发送图片
- (void)sendImageMessage:(UIImage *)image {
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    // 构造出具体会话
    NIMSession *session = [NIMSession session:[_model.sessionID isEqualToString:@"123"] ? @"456" : @"123" type:NIMSessionTypeP2P];
    // 获得语音附件对象
    NIMImageObject *object = [[NIMImageObject alloc] initWithImage:image];
    // 构造出具体消息并注入附件
    NIMMessage *message = [[NIMMessage alloc] init];
    message.messageObject = object;
    message.from = _model.sessionID;
    // 错误反馈对象
    NSError *error = nil;
    
    YLMessage *model = [YLMessage messageWithDict:@{@"text":@"语音",@"time":@(message.timestamp),@"type":@([message.from isEqualToString:_model.sessionID] ? CZMessageTypeMe : CZMessageTypeOther),@"messageObject":message.messageObject,@"messageType":@(NIMMessageTypeImage)}];
    YLMessageFrame *modelFrame = [[YLMessageFrame alloc] init];
    modelFrame.message = model;
    [self.messageFrames addObject:modelFrame];
    [self.chatTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    if (indexPath.row == -1) {
        
    }else {
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    // 发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:&error];
}
- (void)sendMessage:(NIMMessage *)message progress:(float)progress {
    NSLog(@"%f",progress);
}
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(nullable NSError *)error {
    NSLog(@"发送完成");
}
- (void)chatInputViewDidEndEdit:(NSString *)message {
    NIMMessage *sendMessage = [[NIMMessage alloc] init];
    
    sendMessage.text = message;
    sendMessage.from = _model.sessionID;
    NSError *error = nil;
    NSLog(@"发送消息");
    YLMessage *model = [YLMessage messageWithDict:@{@"text":sendMessage.text,@"time":@(sendMessage.timestamp),@"type":@([sendMessage.from isEqualToString:_model.sessionID] ? CZMessageTypeMe : CZMessageTypeOther),@"messageType":@(NIMMessageTypeText)}];
    YLMessageFrame *modelFrame = [[YLMessageFrame alloc] init];
    modelFrame.message = model;
    [self.messageFrames addObject:modelFrame];
    [[NIMSDK sharedSDK].chatManager sendMessage:sendMessage toSession:_session error:&error];
    [self.chatTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    if (indexPath.row == -1) {
        
    }else {
       [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages {
//    [self.dataArr addObjectsFromArray:messages];
    NSLog(@"收到消息");
    NIMMessage *message = messages.lastObject;
    YLMessage *model = message.messageObject ?  [YLMessage messageWithDict:@{@"text":message.text ? message.text : @"语音文件",@"time":@(message.timestamp),@"type":@([message.from isEqualToString:_model.sessionID] ? CZMessageTypeMe : CZMessageTypeOther),@"messageType":@(!message.messageType ? NIMMessageTypeText : message.messageType),@"messageObject": message.messageObject}] : [YLMessage messageWithDict:@{@"text":message.text ? message.text : @"语音文件",@"time":@(message.timestamp),@"type":@([message.from isEqualToString:_model.sessionID] ? CZMessageTypeMe : CZMessageTypeOther),@"messageType":@(!message.messageType ? NIMMessageTypeText : message.messageType)}];
    YLMessageFrame *modelFrame = [[YLMessageFrame alloc] init];
    modelFrame.message = model;
    [self.messageFrames addObject:modelFrame];
    [self.chatTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    if (indexPath.row == -1) {
        
    }else {
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 获取模型数据
    YLMessageFrame *modelFrame = self.messageFrames[indexPath.row];
    
    // 2. 创建单元格
    
    YLMessageCell *cell = [YLMessageCell messageCellWithTableView:tableView];
    
    // 3. 把模型设置给单元格对象
    cell.messageFrame = modelFrame;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 4.返回单元格
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
