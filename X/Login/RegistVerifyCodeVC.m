//
//  RegistVerifyCodeVC.m
//  X
//
//  Created by zhou on 2020/6/16.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "RegistVerifyCodeVC.h"
#import <SWOAuthCodeView.h>
#import "BaseButton.h"

@interface RegistVerifyCodeVC ()<SWOAuthCodeViewDelegate>

@end

@implementation RegistVerifyCodeVC

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

    self.title = @"忘记密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:PingFangSCB(26),
    NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)}];
    
    UILabel* tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = PingFangSC(16);
    [self.view addSubview:tipsLabel];
    NSString* tips = @"请输入您收到的4位验证码";
    tipsLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    tipsLabel.text = tips;
    @weakify(self)
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@16);
    }];
    
    UILabel* verifyCodeLabel = [[UILabel alloc]init];
    verifyCodeLabel.font = PingFangSC(16);
    [self.view addSubview:verifyCodeLabel];
    verifyCodeLabel.text = @"短信验证码";
    verifyCodeLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [verifyCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(tipsLabel.mas_bottom).with.offset(40);
    }];
    //验证码输入框
    //创建view时，需要指定验证码的长度
    SWOAuthCodeView *oacView = [[SWOAuthCodeView alloc] initWithMaxLength:4];
    [self.view addSubview:oacView];
    /* -----设置可选的属性 start----- */
    oacView.delegate = self; //设置代理
    
    oacView.boxNormalBorderColor = BlueButtonColor; //方框的边框正常状态时的边框颜色
    oacView.boxHighlightBorderColor = BlueButtonColor; //方框的边框输入状态时的边框颜色
    oacView.boxBorderWidth = 1.5; //方框的边框宽度
    oacView.boxCornerRadius = 10; //方框的圆角半径
    oacView.boxBGColor = [UIColor clearColor];  //方框的背景色
     //方框内文字的颜色
    /* -----设置可选的属性 end----- */

    [oacView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(verifyCodeLabel.mas_bottom).with.offset(15);
        make.centerX.mas_equalTo(verifyCodeLabel.mas_centerX);
        make.width.mas_equalTo(@234);
        make.height.mas_equalTo(44);
    }];
    
    
    BaseButton*next = [BaseButton buttonWithType:UIButtonTypeCustom];
       [self.view addSubview:next];
    next.titleLabel.font = PingFangSCB(18);
       [next setTitle:@"下一步" forState:UIControlStateNormal];
       [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
       
       [next mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.top.mas_equalTo(oacView.mas_bottom).with.offset(100);
           make.size.mas_equalTo(CGSizeMake(152, 44));
           make.centerX.mas_equalTo(verifyCodeLabel.mas_centerX);
       }];
}

#pragma mark - SWOAuthCodeViewDelegate

- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
    NSLog(@"%@",finalText);
}

#pragma mark - Action

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)next{
    
}

@end
