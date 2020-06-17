//
//  LoginContentView.m
//  XXX
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "LoginContentView.h"

@implementation LoginContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initUI];
    return self;
}

-(void)initUI{
    _iconImageV = [[UIImageView alloc]init];
    _iconImageV.layer.cornerRadius = 43;
    _iconImageV.layer.masksToBounds = YES;
    _iconImageV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_iconImageV];
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@7);
        make.size.mas_equalTo(CGSizeMake(86, 86));
        make.centerX.equalTo(self);
    }];
    
    
    _name = [[UILabel alloc]init];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = PingFangSC(20);
    _name.textColor = [UIColor whiteColor];
    _name.text = @"slogan";
    [self addSubview:_name];
    @weakify(self)
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.iconImageV.mas_bottom).with.offset(13);
        make.size.mas_equalTo(CGSizeMake(iPhone_Width, 27));
    }];
    
    UILabel*loginLabel = [[UILabel alloc]init];
    loginLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:32];
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.text = @"登录/注册";
    [self addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.mas_equalTo(@40);
        make.top.equalTo(self.name.mas_bottom).with.offset(33);
        make.size.mas_equalTo(CGSizeMake(160, 45));
    }];
    
    UIImageView*phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouji"]];
    [self addSubview:phoneImage];
    [phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(loginLabel.mas_bottom).with.offset(37);
    }];
    
    UILabel*phoneNumLabel = [[UILabel alloc]init];
    phoneNumLabel.text = @"手机号码";
    phoneNumLabel.font = PingFangSC(18);
    phoneNumLabel.textColor = [UIColor whiteColor];
    [self addSubview:phoneNumLabel];
    [phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImage.mas_right).with.offset(5);
        make.centerY.equalTo(phoneImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    
    UILabel*phonePre = [[UILabel alloc]init];
    phonePre.text = @"+86";
    phonePre.font = PingFangSC(18);
    phonePre.textColor = [UIColor whiteColor];
    [self addSubview:phonePre];
    [phonePre mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImage);
        make.top.equalTo(phoneImage.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(35, 25));
    }];
    
    UILabel*trigon = [[UILabel alloc]init];
    trigon.text = @"▼";
    trigon.textColor = [UIColor whiteColor];
    trigon.font = PingFangSC(10);
    [self addSubview:trigon];
    [trigon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phonePre.mas_right).with.offset(5);
        make.centerY.equalTo(phonePre.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    
    _phoneTextField = [[UITextField alloc]init];
    _phoneTextField.placeholder = @"在这里输入手机号码";
    _phoneTextField.font = PingFangSC(18);
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@25);
        make.left.equalTo(trigon.mas_right).with.offset(5);
        make.centerY.mas_equalTo(phonePre.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-40);
    }];
    
    UIView*line = [[UIView alloc]init];
    line.backgroundColor = BlueButtonColor;
    line.alpha = 0.5;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@40);
        make.right.mas_equalTo(@-40);
        make.top.equalTo(phonePre.mas_bottom).with.offset(8);
        make.height.mas_equalTo(@1);
    }];
    
    
}
@end
