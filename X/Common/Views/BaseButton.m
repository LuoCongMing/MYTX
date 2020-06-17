//
//  BaseButton.m
//  XXX
//
//  Created by zhou on 2020/6/12.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)buttonWithType:(UIButtonType)buttonType{
    BaseButton*button;
    button = [super buttonWithType:buttonType];
    button.layer.cornerRadius = 22;
    button.layer.masksToBounds = YES;
    button.backgroundColor = BlueButtonColor;
    button.frame = CGRectMake(0, 0, 152, 44);
    button.titleLabel.font =  PingFangSC(18);
    
    return button;
}
@end
