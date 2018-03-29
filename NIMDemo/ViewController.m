//
//  ViewController.m
//  NIMDemo
//
//  Created by 袁量 on 2018/3/26.
//  Copyright © 2018年 JLM. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
#import "JLMChatViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (IBAction)logoin:(id)sender {
    [[[NIMSDK sharedSDK] loginManager] login:_nameTextField.text token:_passwordTextField.text completion:^(NSError * _Nullable error) {
        SessionModel *model = [SessionModel provinceWithDictionary:@{@"sessionID":_nameTextField.text}];
        NIMSessionListViewController *vc = [[NIMSessionListViewController alloc] init];
        JLMChatViewController *chatVC = [[JLMChatViewController alloc] init];
        chatVC.session = [NIMSession session:[_nameTextField.text isEqualToString:@"123"] ? @"456" : @"123" type:NIMSessionTypeP2P];
        chatVC.model = model;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
        
        [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
