//
//  RegistInfoCell.m
//  X
//
//  Created by zhou on 2020/6/15.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "RegistInfoCell.h"

@implementation RegistInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initUI];
    
    return self;
}
-(void)initUI{
    _customContentView = [[UIView alloc]init];
    _customContentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    _customContentView.layer.cornerRadius = 22;
    _customContentView.layer.masksToBounds = YES;
    [self.contentView addSubview:_customContentView];
    @weakify(self)
    [_customContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@15);
        make.left.mas_equalTo(@16);
        make.right.mas_equalTo(@-16);
        make.height.mas_equalTo(@44);
    }];
    
    _leftIconImage = [[UIImageView alloc]init];
    _leftIconImage.image = [UIImage imageNamed:@"shouji"];
    [_customContentView addSubview:_leftIconImage];
    [_leftIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.mas_equalTo(@22);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.top.mas_equalTo(@13);
    }];
    
    _projectLabel = [[UILabel alloc]init];
    _projectLabel.textColor = [UIColor whiteColor];
    _projectLabel.font = PingFangSC(18);
    [_customContentView addSubview:_projectLabel];
    [_projectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.leftIconImage.mas_right).with.offset(7);
        make.centerY.mas_equalTo(self.customContentView.mas_centerY);
        make.right.mas_equalTo(@-40);
    }];
    
    
    _trigon = [[UILabel alloc]init];
    _trigon.text = @"▼";
    _trigon.textColor = [UIColor whiteColor];
    _trigon.font = PingFangSC(10);
    [_customContentView addSubview:_trigon];
    [_trigon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.customContentView).with.offset(-22);
        make.centerY.mas_equalTo(self.customContentView.mas_centerY);
        
    }];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
