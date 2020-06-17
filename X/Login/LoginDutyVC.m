//
//  LoginDutyVC.m
//  X
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "LoginDutyVC.h"
#import "LoginAgeSelectVC.h"

@interface LoginDutyVC ()<UITextViewDelegate>

@end

@implementation LoginDutyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.alpha = 0;
    
    [self initUI];
}

-(void)initUI{
    UIImageView*bgImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImage.image = [UIImage imageNamed:@"dutybg"];
    [self.view addSubview:bgImage];
    
    UIView*bgview = [[UIView alloc]initWithFrame:self.view.bounds];
    bgview.alpha = 0.8;
    bgview.backgroundColor = BlackColor;
    [self.view addSubview:bgview];
    
    
    UIView*alertView = [[UIView alloc]init];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 20;
    alertView.layer.masksToBounds = YES;
    [self.view addSubview:alertView];
    @weakify(self)
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.size.mas_equalTo(CGSizeMake(310, 340));
        make.center.equalTo(self.view);
    }];
    
    
    UILabel*title = [[UILabel alloc]init];
    title.text = @"温馨提示";
    title.textColor = BlackColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = PingFangSCB(18);
    [alertView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@27);
        make.left.mas_equalTo(@30);
        make.right.mas_equalTo(@-30);
        make.height.mas_equalTo(@25);
    }];
    
    UILabel*welcome = [[UILabel alloc]init];
    welcome.text = @"欢迎加入XX！";
    welcome.textColor = UIColorFromRGB(0x666666);
    welcome.textAlignment = NSTextAlignmentLeft;
    welcome.font = PingFangSCB(14);
    [alertView addSubview:welcome];
    [welcome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@64);
        make.left.mas_equalTo(@30);
        make.right.mas_equalTo(@-30);
//        make.height.mas_equalTo(@20);
    }];
    
    UITextView*content = [[UITextView alloc]init];
    NSString*contentTxt = @"我们重视与保障您的个人隐私，我们依据最新的监管要求更新了XX《用户协议》和《隐私协议》，建议您仔细阅读，我们将严格按照征程内容使用和保护您的个人资料。为您提供更好的服务，感谢您的信任。";
    NSMutableParagraphStyle*para = [[NSMutableParagraphStyle alloc]init];
    para.lineSpacing = 4;
    NSMutableAttributedString*attr = [[NSMutableAttributedString alloc]initWithString:contentTxt attributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x666666),NSFontAttributeName:PingFangSC(14),NSParagraphStyleAttributeName:para}];
    [attr addAttributes:@{NSForegroundColorAttributeName:BlueButtonColor} range:[contentTxt rangeOfString:@"《用户协议》"]];
    [attr addAttribute:NSLinkAttributeName value:@"USER://" range:[contentTxt rangeOfString:@"《用户协议》"]];
    [attr addAttributes:@{NSForegroundColorAttributeName:BlueButtonColor} range:[contentTxt rangeOfString:@"《隐私协议》"]];
    [attr addAttribute:NSLinkAttributeName value:@"YS://" range:[contentTxt rangeOfString:@"《隐私协议》"]];
    content.attributedText = attr;
    content.delegate  = self;
    content.editable = NO;
    content.scrollEnabled = NO;
    [alertView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcome.mas_bottom).with.offset(15);
        make.left.mas_equalTo(@25);
        make.right.mas_equalTo(@-30);
        make.height.mas_equalTo(@170);
    }];
    
    
    
    UIButton*able = [UIButton buttonWithType:UIButtonTypeCustom];
    [able setBackgroundColor:BlueButtonColor];
    [able setTitle:@"同意" forState:UIControlStateNormal];
    [able setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    able.titleLabel.font = PingFangSC(16);
    able.layer.cornerRadius = 21;
    able.layer.masksToBounds = YES;
    [alertView addSubview:able];
    [[able rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginAgeSelectVC*ageVC = [[LoginAgeSelectVC alloc]init];
            [self.navigationController pushViewController:ageVC animated:YES];
        });
        
    }];
    [able mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@-18);
        make.size.mas_equalTo(CGSizeMake(122, 42));
        make.top.equalTo(content.mas_bottom).with.offset(10);
    }];
    
    UIButton*disable = [UIButton buttonWithType:UIButtonTypeCustom];
    [disable setBackgroundColor:UIColorFromRGB(0xEDEDED)];
    [disable setTitle:@"不同意" forState:UIControlStateNormal];
    [disable setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    disable.titleLabel.font = PingFangSC(16);
    [disable.titleLabel setTextColor:[UIColor whiteColor]];
    disable.layer.cornerRadius = 21;
    disable.layer.masksToBounds = YES;
    [alertView addSubview:disable];
    [[disable rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            exit(1);
        });
    }];
    [disable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@18);
        make.size.mas_equalTo(CGSizeMake(122, 42));
        make.top.equalTo(content.mas_bottom).with.offset(10);
    }];
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
   if ([[URL scheme] isEqualToString:@"USER"]) {
       //

       return NO;
   }else if ([[URL scheme] isEqualToString:@"YS"]) {
       //

       return NO;
   }
   return YES;

}

@end
