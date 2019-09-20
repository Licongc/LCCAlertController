//
//  LCAlertAction.h
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LCAlterActionType) {
    LCAlterActionLightColorType  = 1,   //浅色
    LCAlterActionDarkColorType = 2,    //深色加粗
};

@class LCAlertAction;

typedef void(^clickAction)(LCAlertAction * _Nullable action);

@interface LCAlertAction : NSObject
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(LCAlterActionType)style handler:(clickAction _Nullable )handler;
@property (nonatomic,strong) NSString * _Nullable btnTitle;
@property (nonatomic,strong) UIFont * _Nullable titleFont;
@property (nonatomic,strong) UIColor * _Nullable titleColor;
@property (nonatomic, copy) clickAction _Nullable handler;

@end
