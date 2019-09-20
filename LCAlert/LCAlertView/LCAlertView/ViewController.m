//
//  ViewController.m
//  LCAlertView
//
//  Created by licc on 2019/9/20.
//  Copyright © 2019 licc. All rights reserved.
//

#import "ViewController.h"
#import "LCAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100,50)];
    btn.centerX = self.view.width/2;
    btn.centerY = self.view.height/2;
    [btn setTitle:@"alert" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)alert{
    LCAlertController *alertController = [LCAlertController alertViewControllerWithTitle:@"支付" message:@"您已有1笔待付款的会员订单是否去支付？"];
    LCAlertAction *sureAction = [LCAlertAction actionWithTitle:@"去支付" style:LCAlterActionDarkColorType handler:^(LCAlertAction * _Nonnull action) {
        
    }];
    
    LCAlertAction *cancelAction = [LCAlertAction actionWithTitle:@"放弃" style:LCAlterActionLightColorType handler:^(LCAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
