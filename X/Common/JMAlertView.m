//
//  JMAlertView.m
//  SmartMeadow
//
//  Created by JMiMac01 on 2017/7/14.
//  Copyright © 2017年 JMiMac01. All rights reserved.
//

#import "JMAlertView.h"
#import <ReactiveCocoa.h>
#import <MBProgressHUD.h>

//#import "UITextField+JMInutAccessoryView.h"

///alertView  宽
#define AlertW 280

#define AlertH 140
///各个栏目之间的距离
#define XLSpace 10.0

#define ButtonH 50

#define RGBA(a,b,c,d)  [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
@implementation JMAlertView
-(instancetype)initAgentAlertViewWithCount:(int)count{
    
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor clearColor];
        self.alertView.frame = CGRectMake(0, 0, 340, 226);
        self.alertView.layer.position = self.center;
        UIView*content = [[UINib nibWithNibName:@"FQAgentAlertView" bundle:nil]instantiateWithOwner:nil options:nil].firstObject;
        content.frame = self.alertView.bounds;
        UILabel*countLabel = [content viewWithTag:9];
        countLabel.text = [NSString stringWithFormat:@"邀请了%d人成功注册并",count];
        UIButton*cancel = [content viewWithTag:2];
        UIButton*config = [content viewWithTag:3];
        [config addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        config.tag = ButtonTypeConfig;
        [cancel addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        cancel.tag = ButtonTypeCancel;
        [self.alertView addSubview:content];
        
        [self addSubview:self.alertView];
        
    }
    
    return self;
}



-(instancetype)initWithTextFieldPlacehoder:(NSString *)palcehoder ConfigTitle:(NSString *)configTitle CancelTitle:(NSString *)cancleTitle{
    
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.layer.position = self.center;
        
        //添加textfield
        if (palcehoder) {
            _textField = [[UITextField alloc]initWithFrame:CGRectMake(4*XLSpace, 2*XLSpace, AlertW-8*XLSpace, ButtonH)];
            _textField.placeholder = palcehoder;
            _textField.borderStyle = UITextBorderStyleNone;
            _textField.textColor = RGBA(112, 112, 112, 1);
            _textField.font = [UIFont systemFontOfSize:15];
            _textField.delegate = self;
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            _textField.returnKeyType = UIReturnKeyDone;
//            [_textField addJMInputAccessoryView];
            [_textField becomeFirstResponder];
            [self.alertView addSubview:_textField];
            
            UIView*under_score = [[UIView alloc]initWithFrame:CGRectMake(2*XLSpace, CGRectGetMaxY(_textField.frame), AlertW-4*XLSpace, 0.5)];
            under_score.backgroundColor = RGBA(217, 217, 217, 1);
            [self.alertView addSubview:under_score];
        }
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame)+2*XLSpace, AlertW, 0.5);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && configTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-0.5)/2, ButtonH);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            //            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
            self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            self.cancleBtn.tag = ButtonTypeCancel;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && configTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 0.5, ButtonH);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(configTitle && cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, ButtonH);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            //            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:configTitle forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            self.sureBtn.tag = ButtonTypeConfig;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        self.alertView.frame = CGRectMake(0, 0, AlertW, CGRectGetMaxY(self.sureBtn.frame));
        
        [self addSubview:self.alertView];
        [self addTestFieldObserver];
    }
    
    
    return self;
}
-(void)addTestFieldObserver{
    
    /// 监听键盘
    //    takeUntil会接收一个signal,当signal触发后会把之前的信号释放掉
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification*notif) {
        @strongify(self)
        CGFloat contentViewH = self.alertView.frame.size.height;
        CGFloat keyboardH = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        if (keyboardH>(iPhone_Width-contentViewH-self.alertView.frame.origin.y)) {
            
            [UIView animateWithDuration:0.25 animations:^{
                CGRect rect = self.alertView.frame;
                rect.origin.y = iPhone_Width - keyboardH-contentViewH;
                self.alertView.frame = rect;
            }];
        }
    }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * notif) {
        @strongify(self)
        [UIView animateWithDuration:0.25 animations:^{
            self.alertView.center = self.center;
        }];
        
    }];
    
}
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message ConfigTitle:(NSString *)configTitle CancelTitle:(NSString *)cancleTitle
{
    if (self == [super init]) {
        self.notFlag = YES;
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        
        self.alertView.layer.position = self.center;
        
        if (title.length>0) {
            
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, XLSpace, AlertW-4*XLSpace, 25) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, XLSpace, titleW, titleH);
            
        }
        if (message.length>0) {
            
            self.msgLbl = [self GetAdaptiveLable:CGRectMake(XLSpace, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, AlertW-2*XLSpace, 25) AndText:message andIsTitle:NO];
            self.msgLbl.textAlignment = NSTextAlignmentCenter;
            self.msgLbl.textColor = RGBA(51, 51, 51, 1);
            [self.alertView addSubview:self.msgLbl];
            
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            
            self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*XLSpace, msgW, 50);
        }
       
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+2*XLSpace, AlertW, 0.5);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        //两个按钮
        if (cancleTitle && configTitle) {
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-0.5)/2, 50);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
//            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateNormal];
            self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            self.cancleBtn.tag = ButtonTypeCancel;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && configTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 0.5, 50);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(configTitle && cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-0.5)/2, 50);
            [self.sureBtn setBackgroundImage:[self imageWithColor:UIColorFromRGB(0xfb2020)] forState:UIControlStateNormal];
//            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:configTitle forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            self.sureBtn.tag = ButtonTypeConfig;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
//        self.alertView.frame = CGRectMake(0, 0, AlertW, CGRectGetMaxY(self.sureBtn.frame));
        self.alertView.frame = CGRectMake(0, 0, AlertW, AlertH);
        
        [self addSubview:self.alertView];
    }
    
    return self;
}
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message ConfigTitle:(NSString *)configTitle{
    
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        
        self.alertView.layer.position = self.center;
        
        if (title.length>0) {
            
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, XLSpace, AlertW-4*XLSpace, 25) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, XLSpace, titleW, titleH);
            
        }
        if (message.length>0) {
            
            self.msgLbl = [self GetAdaptiveLable:CGRectMake(XLSpace, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, AlertW-2*XLSpace, 50) AndText:message andIsTitle:NO];
            self.msgLbl.textAlignment = NSTextAlignmentCenter;
            self.msgLbl.textColor = RGBA(51, 51, 51, 1);
          
            [self.alertView addSubview:self.msgLbl];
            
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            
            self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*XLSpace, msgW, 50);
        }
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+2*XLSpace, AlertW, 0.5);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //确定按钮

        if(configTitle ){
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 50);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            //            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:configTitle forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:UIColorFromRGB(0x303030) forState:UIControlStateNormal];
            self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            self.sureBtn.tag = ButtonTypeConfig;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //        self.alertView.frame = CGRectMake(0, 0, AlertW, CGRectGetMaxY(self.sureBtn.frame));
        self.alertView.frame = CGRectMake(0, 0, AlertW, CGRectGetMaxY(self.sureBtn.frame));
        
        
        [self addSubview:self.alertView];
    }
    
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@" "]) {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark - 弹出 -
- (void)showJMAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint p1 = [self convertPoint:point toView:self.alertView];
    if ([self.alertView pointInside:p1 withEvent:event]) {
        return [self.alertView hitTest:p1 withEvent:event];
    }
    if (!self.notFlag) {
        [self removeFromSuperview];
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - 回调 -设置只有2  -- > 确定才回调
//左边1 右边2
- (void)buttonEvent:(UIButton *)sender
{
    if (self.textField) {
        //输入框回调
        if (sender.tag==ButtonTypeConfig) {
            if (_adjustImei) {
                ///先验证imei
             
                
            }else{
                if (_textField.text.length>0) {
                    if (self.complete) {
                        self.complete(_textField.text);
                    }
                }
                [self removeFromSuperview];
            }
        }else{
             [self removeFromSuperview];
        }
        
    }else{
        //提示框回调
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
        [self removeFromSuperview];
    }
    
    
    
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:17.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:15.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
//    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
