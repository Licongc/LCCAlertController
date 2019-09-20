//
//  LCAlertController.m
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//
#define Weak(obj) __weak typeof(obj) weak##obj = obj;
#define Block(obj) __block typeof(obj) block##obj = obj;

#import "LCAlertController.h"
#import "LCAlertAnimate.h"
@interface LCAlertController () <UIViewControllerTransitioningDelegate>

@end

@implementation LCAlertController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.transitioningDelegate = self;
    }
    return self;
}
+ (instancetype)alertControllerWithView:(LCAlertView *)alertView
{
    LCAlertController *vc = [[LCAlertController alloc] init];
    vc.alertView = alertView;
    return vc;
}
+ (instancetype _Nullable )alertViewControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
    LCAlertController *vc = [[LCAlertController alloc] init];
    vc.alertView = [LCAlertView alertViewWithTitle:title message:message];
    return vc;
}

-(void)setAlertView:(LCAlertView *)alertView
{
    _alertView = alertView;
    Weak(self)
    _alertView.vcCallBack = ^(LCAlertAction *action) {
        [weakself dismissViewControllerAnimated:YES completion:^{
            if (action.handler) {
                action.handler(action);
            }
        }];
    };
    [self.view addSubview:_alertView];
}
-(void)addAction:(LCAlertAction *)action
{
    [self.alertView addAction:action];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}
#pragma Mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[LCAlertAnimate alloc] init];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[LCAlertAnimate alloc] init];
}
-(void)dealloc
{
    
}
@end
