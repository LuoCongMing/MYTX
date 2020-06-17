//
//  LoginAgeSelectView.m
//  X
//
//  Created by zhou on 2020/6/15.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "LoginAgeSelectView.h"
#import "JMAlertView.h"

@implementation LoginAgeSelectView
-(void)awakeFromNib{
    [super awakeFromNib];
    _selectedButton = _eighteenYearButton;
    [_eighteenYearButton setSelected:YES];
    
}

- (IBAction)ageClick:(UIButton*)sender {
    if (sender==_eighteenYearButton) {
        [_selectedButton setSelected:NO];
        [_eighteenYearButton setSelected:YES];
        _selectedButton = _eighteenYearButton;
        _eighteenYearBoardView.backgroundColor = BlueButtonColor;
        _twentyFiveYearBoardView.backgroundColor = BlackColor;
    }else{
        [_selectedButton setSelected:NO];
        [_twentyFiveYearBoardButton setSelected:YES];
        _selectedButton = _twentyFiveYearBoardButton;
        _eighteenYearBoardView.backgroundColor = BlackColor;
        _twentyFiveYearBoardView.backgroundColor = BlueButtonColor;
    }
    
}


- (IBAction)selectCircleClick:(id)sender {
    _selectCircle.selected = !_selectCircle.selected;
}

- (IBAction)userProtocolClick:(id)sender {
    [self routerEventWithName:user_protocol dataInfo:nil];
}

- (IBAction)privacyClick:(id)sender {
    [self routerEventWithName:user_privacy dataInfo:nil];
}


- (IBAction)configClick:(id)sender {
    if (_selectCircle.selected) {
        
        [self routerEventWithName:user_config dataInfo:nil];
    }else{
        JMAlertView*alert = [[JMAlertView alloc]initWithTitle:@"" message:@"请先阅读用户协议和隐私政策并同意其中的条款" ConfigTitle:@"确定"];
        [alert showJMAlertView];
        return;
    }
    
}

@end
