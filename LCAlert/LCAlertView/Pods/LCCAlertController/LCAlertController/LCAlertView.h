//
//  LCAlertView.h
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//
/* 手机屏幕宽高*/
#define LC_SCREEN_WIDTH     ([UIScreen mainScreen].bounds.size.width)
#define LC_SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)
#define kIOSVersion             [UIDevice currentDevice].systemVersion.doubleValue

//字体
#define pingfangUltralight   (kIOSVersion>=9.1)?@"PingFangSC-Ultralight":@"Helvetica"
#define pingfangRegular      (kIOSVersion>=9.1)?@"PingFangSC-Regular":@"Helvetica"
#define pingfangSemibold     (kIOSVersion>=9.1)?@"PingFangSC-Semibold":@"Helvetica-Bold"
#define pingfangThin         (kIOSVersion>=9.1)?@"PingFangSC-Thin":@"Helvetica-Light"
#define pingfangMedium       (kIOSVersion>=9.1)?@"PingFangSC-Medium":@"Helvetica-Bold"
#define pingfangLight        (kIOSVersion>=9.1)?@"PingFangSC-Light":@"Helvetica-Light"


#import <UIKit/UIKit.h>
#import "LCAlertAction.h"
@interface UIView (LYKit)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@end

typedef void(^clickActionBtnVCCallBack)(LCAlertAction *action);

@interface LCAlertView : UIView
+ (instancetype _Nullable )alertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

@property (nonatomic,strong) NSString * _Nullable alertTitle;
@property (nonatomic,strong) NSString * _Nullable alertMessage;

@property (nonatomic,strong) UIVisualEffectView * _Nonnull contentView;
@property (nonatomic,strong) UIView * _Nonnull titleView;
@property (nonatomic,strong) UILabel * _Nonnull titleLabel;
@property (nonatomic,strong) UIView * _Nonnull messageView;
@property (nonatomic,strong) UILabel * _Nonnull messageLabel;
@property (nonatomic,strong) UIView * _Nonnull btnView;
@property (nonatomic,strong) NSMutableArray * _Nonnull btnArray;

-(void)addAction:(LCAlertAction *_Nonnull)action;

@property (nonatomic, copy) clickActionBtnVCCallBack _Nullable vcCallBack;


+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha;
@end
