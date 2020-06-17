//
//  RegistIconVC.m
//  X
//
//  Created by zhou on 2020/6/15.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "RegistIconVC.h"
#import "BaseButton.h"
#import <QBImagePickerController.h>

@interface RegistIconVC ()<QBImagePickerControllerDelegate>
@property (nonatomic,strong)UIImageView*iconImageView;
@end

@implementation RegistIconVC

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
       
    self.title = @"设置头像";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:PingFangSCB(26),
    NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)}];
    
    UILabel* tipsLabel = [[UILabel alloc]init];
    tipsLabel.font = PingFangSC(16);
    [self.view addSubview:tipsLabel];
    NSString* tips = @"请使用本人真实照片";
    NSMutableAttributedString*att = [[NSMutableAttributedString alloc]initWithString:tips attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]}];
    [att addAttributes:@{NSForegroundColorAttributeName:BlueButtonColor} range:[tips rangeOfString:@"真实照片"]];
    tipsLabel.attributedText = att;
    @weakify(self)
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(@16);
    }];
    
    UIImageView* iconImageView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangji"]];
    iconImageView.backgroundColor = UIColorFromRGB(0xE0EBFC);
    iconImageView.layer.cornerRadius = 66;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.userInteractionEnabled = YES;
    [iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPhoto)]];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.size.mas_equalTo(CGSizeMake(132, 132));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(tipsLabel.mas_bottom).with.offset(55);
    }];
    self.iconImageView = iconImageView;
    
    UILabel* addIcon = [[UILabel alloc]init];
    addIcon.text = @"点击添加头像";
    addIcon.font = PingFangSCB(18);
    addIcon.textColor = [UIColor whiteColor];
    [self.view addSubview:addIcon];
    [addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).with.offset(17);
    }];
    
    UILabel* iconexplain = [[UILabel alloc]init];
    iconexplain.font = PingFangSC(14);
    iconexplain.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    iconexplain.text = @"(上传清晰的五官头像，让更多用户发现你）";
    [self.view addSubview:iconexplain];
    [iconexplain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addIcon.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    //三个头像
    
    UIView*centerIcon =  [ self imageViewWith:[UIImage imageNamed:@"woman2"] Title:@"1人喜欢" labeImage:[UIImage imageNamed:@"cuo"]];
    [self.view addSubview:centerIcon];
    [centerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.mas_equalTo(iconexplain.mas_bottom).with.offset(29);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(88, 120));
    }];
    
    UIView*lefticon =  [ self imageViewWith:[UIImage imageNamed:@"woman1"] Title:@"99+人喜欢" labeImage:[UIImage imageNamed:@"dui"]];
    [self.view addSubview:lefticon];
    [lefticon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerIcon.mas_top);
        make.right.mas_equalTo(centerIcon.mas_left).with.offset(-35);
        make.size.mas_equalTo(CGSizeMake(88, 120));
    }];
    
    UIView*rightIcon =  [ self imageViewWith:[UIImage imageNamed:@"snow mountain"] Title:@"0人喜欢" labeImage:[UIImage imageNamed:@"cuo"]];
    [self.view addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerIcon.mas_top);
        make.left.mas_equalTo(centerIcon.mas_right).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(88, 120));
    }];
    
    
    BaseButton*next = [BaseButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake((iPhone_Width-32-152)/2, 28, 152, 44);
    next.titleLabel.font = PingFangSCB(18);
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerIcon.mas_bottom).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(152, 44));
        make.centerX.mas_equalTo(centerIcon.mas_centerX);
    }];
    
}

-(UIView*)imageViewWith:(UIImage*)image Title:(NSString*)title labeImage:(UIImage*)labelImage{
    
    UIView*view  = [[UIView alloc]init];
    
    UIImageView*imageV = [[UIImageView alloc]initWithImage:image];
    [view addSubview:imageV];
    imageV.layer.cornerRadius = 44;
    imageV.layer.masksToBounds = YES;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.width.mas_equalTo(view.mas_width);
        make.height.mas_equalTo(@88);
        make.left.mas_equalTo(@0);
    }];
    
    UIImageView*labelImageView =  [[UIImageView alloc]initWithImage:labelImage];
    [view addSubview:labelImageView];
    [labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@69);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(@-12);
    }];
    
    UILabel*like = [[UILabel alloc]init];
    like.textAlignment = NSTextAlignmentCenter;
    like.font = PingFangSC(14);
    like.textColor = UIColorFromRGB(0xFFFFFF);
    [view addSubview:like];
    like.text = title;
    [like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).with.offset(10);
        make.width.mas_equalTo(view.mas_width);
        make.left.mas_equalTo(@0);
    }];
    
    return view;
}

#pragma mark - qb_imagePicker

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    if (imagePickerController.mediaType == QBImagePickerMediaTypeImage) {
        for (PHAsset *asset in assets) {
            // Do something with the asset
            PHImageManager * imageManager = [PHImageManager defaultManager];
            @weakify(self)
            [imageManager requestImageDataAndOrientationForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, CGImagePropertyOrientation orientation, NSDictionary * _Nullable info) {
                @strongify(self)
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage * image = [UIImage imageWithData:imageData];
                    self.iconImageView.image = image;
                });
            }];
            
        }
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Action

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next{
    
    
}
-(void)selectPhoto{
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 1;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    imagePickerController.mediaType = QBImagePickerMediaTypeImage;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}
@end
