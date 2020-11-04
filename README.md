# LCCAlertController

# pod 'LCCAlertController'
高仿UIAlertController写的，方便修改字体和颜色

    LCAlertController *alertController = [LCAlertController alertViewControllerWithTitle:@"支付" message:@"您已有1笔待付款的会员订单是否去支付？"];
    LCAlertAction *sureAction = [LCAlertAction actionWithTitle:@"去支付" style:LCAlterActionDarkColorType handler:^(LCAlertAction * _Nonnull action) {
        
    }];
    
    LCAlertAction *cancelAction = [LCAlertAction actionWithTitle:@"放弃" style:LCAlterActionLightColorType handler:^(LCAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
