//
//  LoginVC.m
//  XXX
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "LoginVC.h"
#import "LoginContentView.h"
#import "BaseButton.h"
#import "LoginDutyVC.h"
#import "RegistIconVC.h"
#import "RegistAge&sexVC.h"
#import "RegistResetPassWordsVC.h"

@interface LoginVC ()
@property (nonatomic,strong)LoginContentView *contentView;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:BlackColor];
    
    [self initUI];
}
-(void)initUI{
    _contentView =[[LoginContentView alloc]initWithFrame:CGRectMake(0, 0, iPhone_Width, 340)];
    [self.view addSubview:_contentView];
    
    
    BaseButton*continueBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    
    [continueBtn setTitle:@"继续" forState:UIControlStateNormal];
    [self.view addSubview:continueBtn];
    
    @weakify(self)
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_bottom).with.offset(60);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(152, 44));
    }];
    
    [[continueBtn  rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
//            LoginDutyVC*duty  = [[LoginDutyVC alloc]init];
//            [self.navigationController pushViewController:duty animated:YES];
            RegistResetPassWordsVC*iconVC  = [[RegistResetPassWordsVC alloc]init];
            [self.navigationController pushViewController:iconVC animated:YES];
        });
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

@end
