//
//  LoginAgeSelectVC.m
//  X
//
//  Created by zhou on 2020/6/15.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "LoginAgeSelectVC.h"
#import "BaseButton.h"
#import "LoginAgeSelectView.h"
#import "RegistInfoVC.h"

@interface LoginAgeSelectVC ()
@property (nonatomic,strong) LoginAgeSelectView*contentView;

@end

@implementation LoginAgeSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

-(void)initUI{
    _contentView = [[UINib nibWithNibName:@"LoginAgeSelectView" bundle:nil]instantiateWithOwner:nil options:nil].firstObject;
    _contentView.frame = self.view.bounds;
    [self.view addSubview:_contentView];
    
}

-(void)routerEventWithName:(NSString *)eventName dataInfo:(NSDictionary *)dataInfo{
    
    if ([eventName isEqualToString:user_config]) {
        //跳转到下一步
        RegistInfoVC*registInfo = [[RegistInfoVC alloc]init];
        [self.navigationController pushViewController:registInfo animated:YES];
        return;
    }
    
    if ([eventName isEqualToString:user_privacy]) {
        //跳转到用户协议
        return;
    }
    
    if ([eventName isEqualToString:user_protocol]) {
        //跳转到隐私政策
        return;
    }
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
