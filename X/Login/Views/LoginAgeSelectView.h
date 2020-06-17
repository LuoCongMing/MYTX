//
//  LoginAgeSelectView.h
//  X
//
//  Created by zhou on 2020/6/15.
//  Copyright © 2020 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString*user_protocol = @"user_protocol";
static NSString*user_privacy = @"user_privacy";
static NSString*user_config = @"user_config";
@interface LoginAgeSelectView : UIView
@property (weak, nonatomic) IBOutlet UIView *eighteenYearBoardView;
@property (weak, nonatomic) IBOutlet UIButton *eighteenYearButton;
@property (weak, nonatomic) IBOutlet UIView *twentyFiveYearBoardView;
@property (weak, nonatomic) IBOutlet UIButton *twentyFiveYearBoardButton;
@property (weak, nonatomic) IBOutlet UIButton *selectCircle;
@property (nonatomic,strong)UIButton*selectedButton;
 
@end

NS_ASSUME_NONNULL_END
