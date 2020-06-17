//
//  JMAlertView.h
//  SmartMeadow
//
//  Created by JMiMac01 on 2017/7/14.
//  Copyright © 2017年 JMiMac01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BtnType)
{
    ButtonTypeConfig,
    ButtonTypeCancel
};

typedef void(^AlertResult)(NSInteger BtnType);
typedef void(^completeBlock)(NSString*text);
@interface JMAlertView : UIView<UITextFieldDelegate>

//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;
//左边1 右边2
@property (nonatomic,copy) AlertResult resultIndex;
//回调textfiel的text
@property (nonatomic,copy) completeBlock complete;

@property(nonatomic,strong)UITextField*textField;
///开启验证 点击确定的时候验证
@property(nonatomic,assign)BOOL adjustImei;
///点击空白是否取消 默认为no取消
@property(nonatomic,assign)BOOL notFlag;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message ConfigTitle:(NSString *)configTitle CancelTitle:(NSString *)cancleTitle;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message ConfigTitle:(NSString *)configTitle;

-(instancetype)initWithTextFieldPlacehoder:(NSString*)palcehoder
                               ConfigTitle:(NSString *)configTitle
                               CancelTitle:(NSString *)cancleTitle;

-(instancetype)initAgentAlertViewWithCount:(int)count;
- (void)showJMAlertView;

@end
