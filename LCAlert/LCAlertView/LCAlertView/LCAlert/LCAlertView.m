
//
//  LCAlertView.m
//  huazhu
//
//  Created by lynb180305 on 2018/8/16.
//  Copyright © 2018年 zhenhua.shen. All rights reserved.
//
#import "LCAlertView.h"


@implementation UIView (LYKit)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


@end


@interface LCAlertView ()

@property (nonatomic,strong) NSMutableArray *actionArray;
//标题和内容 与 上面下面的间隔
@property (nonatomic,assign) float titleTop;
//标题和内容 与 左面右面的间隔
@property (nonatomic,assign) float titleLeftRight;
//白色框的宽
@property (nonatomic,assign) float contentViewWidth;
//按钮的高度
@property (nonatomic,assign) float actionBtnHeight;

//按钮之间的竖线
@property (nonatomic,strong) UIView *btnLineView;
@end

@implementation LCAlertView

+ (instancetype)alertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
     LCAlertView *actionView = [[self alloc] init];
    actionView.alertTitle = title;
    actionView.alertMessage = message;
    
    return actionView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commitView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitView];
    }
    return self;
}
-(void)commitView
{
    self.titleLeftRight = 24;
    self.contentViewWidth = 270;
    self.titleTop = 20;
    self.actionBtnHeight = 45;

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:self.contentView];
    self.frame = CGRectMake(0, 0, LC_SCREEN_WIDTH, LC_SCREEN_HEIGHT);
}
-(void)setAlertTitle:(NSString *)alertTitle
{
    _alertTitle = alertTitle;
    self.titleLabel.text = alertTitle;
    if (alertTitle.length>0) {
//        //有标题message字体设置13号字
//        self.messageLabel.font = [UIFont fontWithName:pingfangRegular size:13];
        self.messageLabel.textColor = [LCAlertView colorWithHexString:@"#666666" andAlpha:1];

    }else{
//        //没有标题message字体设置16号字
//        self.messageLabel.font = [UIFont fontWithName:pingfangRegular size:16];
        self.messageLabel.textColor = [LCAlertView colorWithHexString:@"#333333" andAlpha:1];
    }
}
-(void)setAlertMessage:(NSString *)alertMessage
{
    _alertMessage = alertMessage;
    self.messageLabel.text = alertMessage;
}
-(void)addAction:(LCAlertAction *)action
{
    UIButton *actionbtn = [self getActionBtn:action];
    actionbtn.tag = self.actionArray.count;
    [self.actionArray addObject:action];
    [self.btnArray addObject:actionbtn];
    [self.btnView addSubview:actionbtn];
    [self.btnView sendSubviewToBack:actionbtn];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.titleLabel.text.length>0) {
        self.titleLabel.frame = CGRectMake(self.titleLeftRight, self.titleTop, self.contentView.frame.size.width-self.titleLeftRight*2, 0);
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.height = [self heightWithText:self.messageLabel.text Font:self.messageLabel.font constrainedToWidth:self.messageLabel.width lineSpacing:0];
        self.titleView.height = self.titleLabel.bottom;
    }else{
//        self.titleView.frame.size.height = self.titleTop;
        self.titleView.frame = CGRectMake(self.titleView.frame.origin.x, self.titleView.frame.origin.y, self.titleView.frame.size.width, self.titleTop);
        self.titleView.clipsToBounds = YES;
    }
    
    self.messageView.top = self.titleView.bottom;
    
    if (self.messageLabel.text.length>0) {
        self.messageLabel.frame = CGRectMake(self.titleLeftRight, 2, self.contentView.frame.size.width-self.titleLeftRight*2, 0);
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.height = [self heightWithText:self.messageLabel.text Font:self.messageLabel.font constrainedToWidth:self.messageLabel.width lineSpacing:0];
        self.messageView.height = self.messageLabel.bottom+self.titleTop;
    }else{
        self.messageView.top = self.titleView.bottom+self.titleTop;
        self.messageView.height = 0;
        self.messageView.clipsToBounds = YES;
    }
    
    self.btnView.top = self.messageView.bottom;
    
    self.btnView.clipsToBounds = YES;
    if (self.btnArray.count==2) {
        self.btnView.height = self.actionBtnHeight;
        if (self.btnArray.count>=1) {
            UIButton *btn = self.btnArray[0];
            btn.frame = CGRectMake(0, 0, self.btnView.width/2, self.btnView.height);
        }
        if (self.btnArray.count>=2) {
            UIButton *btn = self.btnArray[1];
            btn.frame = CGRectMake(self.btnView.width/2, 0, self.btnView.width/2, self.btnView.height);
        }
        self.btnLineView.hidden = NO;
    }else{
        self.btnLineView.hidden = YES;
        self.btnView.height = self.actionBtnHeight * self.btnArray.count;
        for (int i=0; i<self.btnArray.count; i++) {
            UIButton *btn = self.btnArray[i];
            btn.frame = CGRectMake(0, self.actionBtnHeight*i, self.btnView.width, self.actionBtnHeight);
        }
    }
    self.contentView.height = self.btnView.bottom;
    self.contentView.center = CGPointMake(self.width/2, self.height/2);
}
-(UIButton *)getActionBtn:(LCAlertAction *)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width/2, 50)];
    [btn setTitle:action.btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:action.titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = action.titleFont;
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView *blackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentViewWidth, 1/[UIScreen mainScreen].scale)];
    blackLineView.backgroundColor = [LCAlertView colorWithHexString:@"#cccccc" andAlpha:0.8];
    [btn addSubview:blackLineView];

    return btn;
}
-(void)clickAction:(UIButton *)actionBtn
{
    
    if (actionBtn.tag<self.actionArray.count) {

        LCAlertAction *action = self.actionArray[actionBtn.tag];
        if (self.vcCallBack) {
            self.vcCallBack(action);
        }
    }
}

-(UIVisualEffectView *)contentView
{
    if (!_contentView) {
        UIBlurEffect *brffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _contentView = [[UIVisualEffectView alloc] initWithEffect:brffect];
        _contentView.frame = CGRectMake(0, 0, self.contentViewWidth, 100);
        _contentView.layer.cornerRadius = 14;
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        [_contentView.contentView addSubview:self.titleView];
        [_contentView.contentView addSubview:self.messageView];
        [_contentView.contentView addSubview:self.btnView];
        
    
//        _contentView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 270, 100)];
//        _contentView.barStyle = UIBarStyleDefault;
//        _contentView.frame = CGRectMake(0, 0, self.contentViewWidth, 100);
//        _contentView.layer.cornerRadius = 14;
//        _contentView.clipsToBounds = YES;
//        [_contentView addSubview:self.titleView];
//        [_contentView addSubview:self.messageView];
//        [_contentView addSubview:self.btnView];

    }
    return _contentView;
}

-(UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 50)];
        [_titleView addSubview:self.titleLabel];
    }
    return _titleView;
}
-(UIView *)messageView
{
    if (!_messageView) {
        _messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 50)];
        [_messageView addSubview:self.messageLabel];
    }
    return _messageView;
}
-(UIView *)btnView
{
    if (!_btnView) {
        _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 45)];
//        UIView *blackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _btnView.width, 1/[UIScreen mainScreen].scale)];
//        blackLineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc" andAlpha:0.8];
//        [_btnView addSubview:blackLineView];
//
        UIView *btnLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1/[UIScreen mainScreen].scale,_btnView.height)];
        btnLineView.backgroundColor = [LCAlertView colorWithHexString:@"#cccccc" andAlpha:0.8];
        [_btnView addSubview:btnLineView];
        btnLineView.centerX = (_btnView.width)/2;
        self.btnLineView = btnLineView;
    }
    return _btnView;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:pingfangMedium size:17];
        _titleLabel.textColor = [LCAlertView colorWithHexString:@"#333333" andAlpha:1];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont fontWithName:pingfangRegular size:14];
        _messageLabel.textColor = [LCAlertView colorWithHexString:@"#333333" andAlpha:1];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
-(NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
-(NSMutableArray *)actionArray
{
    if (!_actionArray) {
        _actionArray = [[NSMutableArray alloc] init];
    }
    return _actionArray;
}

CGFloat colorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha{
    CGFloat  red, blue, green;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            red   = colorComponentFrom(colorString, 0, 1);
            green = colorComponentFrom(colorString, 1, 1);
            blue  = colorComponentFrom(colorString, 2, 1);
            break;
            
        case 4: // #ARGB
            alpha = colorComponentFrom(colorString, 0, 1);
            red   = colorComponentFrom(colorString, 1, 1);
            green = colorComponentFrom(colorString, 2, 1);
            blue  = colorComponentFrom(colorString, 3, 1);
            break;
            
        case 6: // #RRGGBB
            red   = colorComponentFrom(colorString, 0, 2);
            green = colorComponentFrom(colorString, 2, 2);
            blue  = colorComponentFrom(colorString, 4, 2);
            break;
            
        case 8: // #AARRGGBB
            alpha = colorComponentFrom(colorString, 0, 2);
            red   = colorComponentFrom(colorString, 2, 2);
            green = colorComponentFrom(colorString, 4, 2);
            blue  = colorComponentFrom(colorString, 6, 2);
            break;
            
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 *  @param lineSpacing 约束行距
 */
- (CGFloat)heightWithText:(NSString *)text
                     Font:(UIFont *)font
       constrainedToWidth:(CGFloat)width
              lineSpacing:(CGFloat)lineSpacing {
    UIFont *textFont =
    font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([text respondsToSelector:@selector(boundingRectWithSize:
                                           options:
                                           attributes:
                                           context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{
                                     NSFontAttributeName : textFont,
                                     NSParagraphStyleAttributeName : paragraph
                                     };
        textSize =
        [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                           options:(NSStringDrawingUsesLineFragmentOrigin |
                                    NSStringDrawingTruncatesLastVisibleLine)
                        attributes:attributes
                           context:nil]
        .size;
    } else {
        textSize = [text sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : textFont,
                                 NSParagraphStyleAttributeName : paragraph
                                 };
    textSize =
    [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                       options:(NSStringDrawingUsesLineFragmentOrigin |
                                NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading )
                    attributes:attributes
                       context:nil]
    .size;
#endif
    
    return ceil(textSize.height);
}
@end
