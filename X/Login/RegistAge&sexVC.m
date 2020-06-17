//
//  RegistAge&sexVC.m
//  X
//
//  Created by zhou on 2020/6/16.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "RegistAge&sexVC.h"
#import "RegistSexBirthdaySelectView.h"
#import "BaseButton.h"
#import "PickerView.h"
#import <IQKeyboardManager.h>

typedef NS_ENUM(NSInteger, RegistSex) {
    RegistSexFemale = 0,
    RegistSexMale = 1,
};
@interface RegistSexSelectView : UIView
@property (nonatomic, strong) UIImageView* selectImage;
@property (nonatomic, strong) UIImageView* iconImage;
@property (nonatomic, assign) RegistSex gender;
+(RegistSexSelectView*)imageViewWith:(UIImage*)image Title:(NSString*)title Gender:(RegistSex)gender;
@end

@implementation RegistSexSelectView

+(RegistSexSelectView*)imageViewWith:(UIImage*)image Title:(NSString*)title Gender:(RegistSex)gender{
    
    RegistSexSelectView*view  = [[RegistSexSelectView alloc]init];
    view.gender = gender;
    
    UIImageView*imageV = [[UIImageView alloc]initWithImage:image];
    [view addSubview:imageV];
    imageV.layer.cornerRadius = 76;
    imageV.layer.masksToBounds = YES;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(132, 132));
        make.left.mas_equalTo(@0);
    }];
    view.iconImage = imageV;
    
    UIImageView*labelImageView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dui"]];
    
    [view addSubview:labelImageView];
    [labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@116);
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.centerX.mas_equalTo(view.mas_centerX);
    }];
    view.selectImage = labelImageView;
    
    UILabel*sexLabel = [[UILabel alloc]init];
    sexLabel.textAlignment = NSTextAlignmentCenter;
    sexLabel.font = PingFangSCB(18);
    sexLabel.textColor = UIColorFromRGB(0xFFFFFF);
    [view addSubview:sexLabel];
    sexLabel.text = title;
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).with.offset(19);
        make.width.mas_equalTo(view.mas_width);
        make.left.mas_equalTo(@0);
    }];
    
    
    
    return view;
}

@end

@interface RegistAge_sexVC ()<PickerViewResultDelegate>

@property (nonatomic, strong) RegistSexSelectView* selectView;
@property (nonatomic, strong) RegistSexBirthdaySelectView* birthdaySelectView;
@property (nonatomic,strong)PickerView*pickerView;
@end

@implementation RegistAge_sexVC


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //关闭IQKeyboard
    
    [self initUI];
}

-(void)initUI{
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 30, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    self.title = @"性别&年龄";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:PingFangSCB(26),
    NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)}];
    
    UILabel* tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = PingFangSC(16);
    [self.view addSubview:tipsLabel];
    NSString* tips = @"注册完成，您的性别将无法修改";
    NSMutableAttributedString*att = [[NSMutableAttributedString alloc]initWithString:tips attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]}];
    tipsLabel.attributedText = att;
    @weakify(self)
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@16);
    }];
    
    RegistSexSelectView*maleView = [RegistSexSelectView imageViewWith:[UIImage imageNamed:@"male"] Title:@"我是男生" Gender:RegistSexMale];
    [self.view addSubview:maleView];
    [maleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsLabel.mas_bottom).with.offset(36);
        make.size.mas_equalTo(CGSizeMake(132, 176));
        make.left.mas_equalTo(self.view.mas_centerX).with.offset(10);
    }];
    [maleView.selectImage setHidden:YES];
    
    RegistSexSelectView*femaleView = [RegistSexSelectView imageViewWith:[UIImage imageNamed:@"female"] Title:@"我是女生" Gender:RegistSexMale];
    [self.view addSubview:femaleView];
    [femaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsLabel.mas_bottom).with.offset(36);
        make.size.mas_equalTo(CGSizeMake(132, 176));
        make.right.mas_equalTo(self.view.mas_centerX).with.offset(-10);
    }];
    
    _selectView = femaleView;
    
    [maleView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectGender:)]];
    [femaleView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectGender:)]];
    
    
    UILabel*birthdayLabel = [[UILabel alloc]init];
    birthdayLabel.font = PingFangSC(18);
    birthdayLabel.textColor = [UIColor whiteColor];
    birthdayLabel.text = @"选择您的生日";
    [self.view addSubview:birthdayLabel];
    [birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@16);
        make.top.mas_equalTo(femaleView.mas_bottom).with.offset(40);
    }];
    
    
    UILabel*ageConditionLabel = [[UILabel alloc]init];
    ageConditionLabel.text = @"（年龄大于18岁）";
    ageConditionLabel.font = PingFangSC(14);
    ageConditionLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    [self.view addSubview:ageConditionLabel];
    [ageConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(birthdayLabel.mas_right);
        make.centerY.mas_equalTo(birthdayLabel.mas_centerY);
    }];
    
    
    _birthdaySelectView = [[UINib nibWithNibName:@"RegistSexBirthdaySelectView" bundle:nil]instantiateWithOwner:nil options:nil].firstObject;
    [self.view addSubview:_birthdaySelectView];
    [_birthdaySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(birthdayLabel.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(300, 50));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
   BaseButton*next = [BaseButton buttonWithType:UIButtonTypeCustom];
    next.titleLabel.font = PingFangSCB(18);
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.mas_equalTo(self.birthdaySelectView.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(152, 44));
        make.centerX.mas_equalTo(self.birthdaySelectView.mas_centerX);
    }];
    
    //init PickerView
    
    PickerView*picker = [[PickerView alloc]init];
    picker.type = PickerViewTypeBirthday;
    picker.tag = 1;
    picker.delegate = self;
    [picker inputPickerViewSetting];
    
    _birthdaySelectView.yearTextField.inputView = picker;
    _birthdaySelectView.monthTextField.inputView = picker;
    _birthdaySelectView.dayTextField.inputView = picker;
    _birthdaySelectView.yearTextField.inputAccessoryView = [UIView new];
    _birthdaySelectView.monthTextField.inputAccessoryView = [UIView new];
    _birthdaySelectView.dayTextField.inputAccessoryView = [UIView new];
    

}

#pragma mark - PickerView

-(void)pickerView:(UIView *)pickerView result:(NSString *)string{
    
    NSLog(@"%@",string);
    
    NSString*year = [string substringToIndex:4];
    NSString*month = [string substringWithRange:NSMakeRange(5, 2)];
    NSString*day = [string substringWithRange:NSMakeRange(8, 2)];
    self.birthdaySelectView.yearTextField.text = year;
    self.birthdaySelectView.monthTextField.text = month;
    self.birthdaySelectView.dayTextField.text = day;
    
    [self.birthdaySelectView.yearTextField resignFirstResponder];
    [self.birthdaySelectView.monthTextField resignFirstResponder];
    [self.birthdaySelectView.dayTextField resignFirstResponder];
   
}

#pragma mark - Action

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectGender:(UITapGestureRecognizer*)gesture{
    RegistSexSelectView*view = (RegistSexSelectView*)gesture.view;
    [_selectView.selectImage setHidden:YES];
    [view.selectImage setHidden:NO];
    _selectView = view;
}

-(void)next{
    
}
@end
