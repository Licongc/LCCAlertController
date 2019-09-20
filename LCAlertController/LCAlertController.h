//
//  LCAlertController.h
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCAlertView.h"
@interface LCAlertController : UIViewController 
+ (instancetype _Nonnull )alertControllerWithView:(LCAlertView *)alertView;
+ (instancetype _Nullable )alertViewControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
@property (nonatomic,strong) LCAlertView * _Nonnull alertView;
-(void)addAction:(LCAlertAction *_Nonnull)action;
@end
