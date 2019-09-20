
//
//  LCAlertAction.m
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//

#import "LCAlertAction.h"
#import "LCAlertView.h"
@implementation LCAlertAction
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(LCAlterActionType)style handler:(clickAction)handler
{
    LCAlertAction *action = [[self alloc] init];
    action.btnTitle = title;
    action.handler = handler;
    switch (style) {
        case LCAlterActionLightColorType:
            action.titleColor = [LCAlertView colorWithHexString:@"#999999" andAlpha:1];
            action.titleFont = [UIFont fontWithName:pingfangMedium size:16];
            break;
        case LCAlterActionDarkColorType:
            action.titleColor = [LCAlertView colorWithHexString:@"#FFA303" andAlpha:1];
            action.titleFont = [UIFont fontWithName:pingfangMedium size:16];
            break;
        default:
            break;
    }
    return action;
}
-(void)dealloc
{
    
}
@end
