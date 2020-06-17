//
//  RegistResetPassWordsVC.m
//  X
//
//  Created by zhou on 2020/6/16.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "RegistResetPassWordsVC.h"
#import <SWOAuthCodeView.h>
#import "BaseButton.h"


@interface RegistResetPassWordsView : UIView
@property (nonatomic, strong) UITextField* textField;

+(RegistResetPassWordsView*)initWithTitle:(NSString*)title PlaceHolder:(NSString*)placeHolder;
@end

@implementation RegistResetPassWordsView

+(RegistResetPassWordsView*)initWithTitle:(NSString *)title PlaceHolder:(NSString *)placeHolder{
    
    RegistResetPassWordsView*view = [[RegistResetPassWordsView alloc]init];
    UILabel*titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    titleLabel.text = title;
    titleLabel.font  = PingFangSC(16);
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
    }];
    
    UITextField*textField = [[UITextField alloc]init];
    textField.placeholder = placeHolder;
    textField.font = PingFangSC(18);
    textField.secureTextEntry = YES;
    textField.returnKeyType = UIReturnKeyDone;
    view.textField = textField;
    [view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@25);
    }];
    
    UIView*line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithDisplayP3Red:1 green:1 blue:1 alpha:0.5];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@1);
        make.top.mas_equalTo(textField.mas_bottom).with.offset(5);
    }];
    
    return view;
}

@end

@interface RegistResetPassWordsVC ()
@property (nonatomic, strong) UITextField* pswTextField;
@property (nonatomic, strong) UITextField* repeatPswTextField;
@end

@implementation RegistResetPassWordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 30, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    self.title = @"重设密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:PingFangSCB(26),
    NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)}];
    
    UILabel* tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = PingFangSC(16);
    [self.view addSubview:tipsLabel];
    NSString* tips = @"创建密码确保您的账号安全";
    tipsLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    tipsLabel.text = tips;
    @weakify(self)
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@16);
    }];
    
   
    RegistResetPassWordsView*pswView = [RegistResetPassWordsView initWithTitle:@"密码（6~18位）" PlaceHolder:@"设置密码（数字、字母或符号）"];
    _pswTextField = pswView.textField;
    [self.view addSubview:pswView];
    [pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsLabel.mas_bottom).with.offset(40);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(65);
        make.centerX.mas_equalTo(tipsLabel.mas_centerX);
    }];
    
    RegistResetPassWordsView*repeatPswView = [RegistResetPassWordsView initWithTitle:@"再次输入密码" PlaceHolder:@"两次输入密码一致"];
    _repeatPswTextField = repeatPswView.textField;
    [self.view addSubview:repeatPswView];
    [repeatPswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pswView.mas_bottom).with.offset(30);
        make.width.mas_equalTo(@300);
        make.centerX.mas_equalTo(tipsLabel.mas_centerX);
        make.height.mas_equalTo(65);
    }];
    
    
    BaseButton*next = [BaseButton buttonWithType:UIButtonTypeCustom];
    next.titleLabel.font = PingFangSCB(18);
       [self.view addSubview:next];
       [next setTitle:@"确定" forState:UIControlStateNormal];
       [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
       
       [next mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.top.mas_equalTo(repeatPswView.mas_bottom).with.offset(30);
           make.size.mas_equalTo(CGSizeMake(152, 44));
           make.centerX.mas_equalTo(tipsLabel.mas_centerX);
       }];
}



#pragma mark - Action

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)next{
    
}

@end
