//
//  RegistInfoVC.m
//  X
//
//  Created by zhou on 2020/6/15.
//  Copyright © 2020 zhou. All rights reserved.
//

#import "RegistInfoVC.h"
#import "RegistInfoCell.h"
#import "BaseButton.h"


@interface RegistInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView*    tableView;
@property (nonatomic, strong)NSMutableArray* dataSource;
@end

@implementation RegistInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.alpha = 1.0;
    
    [self initData];
    [self initUI];
}

-(void)initUI{
    UIButton*backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backwhite"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 30, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.title = @"个人资料";
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:PingFangSCB(26),
      NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)}];
    
    UILabel*tipsLabel = [[UILabel alloc]init];
    tipsLabel.text = @"完善资料，为你匹配兴趣相同的人";
    tipsLabel.font = PingFangSC(16);
    tipsLabel.textColor = UIColorFromRGB(0xFFFFFF);
    tipsLabel.alpha = 0.5;
    [self.view addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@16);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel*nickName = [[UILabel alloc]init];
    nickName.text = @"取个好听的昵称吧！";
    nickName.font = PingFangSC(18);
    nickName.textColor = UIColorFromRGB(0xFFFFFF);
    [self.view addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLabel.mas_bottom).with.offset(16);
        make.left.mas_equalTo(@16);
    }];
    
    UITextField*nickNameTextField = [[UITextField alloc]init];
    nickNameTextField.font = PingFangSC(18);
    nickNameTextField.textColor = UIColorFromRGB(0xFFFFFF);
    nickNameTextField.placeholder = @"设置昵称（10个字以内）";
    [self.view addSubview:nickNameTextField];
    [nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nickName.mas_bottom).with.offset(12);
        make.left.mas_equalTo(@16);
        make.right.mas_equalTo(@-16);
    }];
    
    
    UIView*line = [[UIView alloc]init];
    line.backgroundColor = BlueButtonColor;
    line.alpha = 0.5;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickNameTextField.mas_left);
        make.right.equalTo(nickNameTextField.mas_right);
        make.top.equalTo(nickNameTextField.mas_bottom).with.offset(8);
        make.height.mas_equalTo(@1);
    }];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 74;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[RegistInfoCell class] forCellReuseIdentifier:@"RegistInfoCell"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(23);
        make.left.equalTo(line.mas_left);
        make.right.equalTo(line.mas_right);
        make.bottom.mas_offset(@0);
    }];
    
    UIView*tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhone_Width-32, 100)];
    _tableView.tableFooterView = tableFootView;
  
    BaseButton*next = [BaseButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake((iPhone_Width-32-152)/2, 28, 152, 44);
    next.titleLabel.font = PingFangSCB(18);
    [tableFootView addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];

}

-(void)initData{
    NSArray*data = @[
    @{@"image":@"",@"project":@"您的联系方式"},
    @{@"image":@"",@"project":@"您的联系方式"},
    @{@"image":@"",@"project":@"您的联系方式"},
    @{@"image":@"",@"project":@"您的联系方式"},
    @{@"image":@"",@"project":@"您的联系方式"},
    @{@"image":@"",@"project":@"您的联系方式"}
    ];
    self.dataSource = [[NSMutableArray alloc]initWithArray:data];
    
    [self.tableView reloadData];
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegistInfoCell*cell = [tableView dequeueReusableCellWithIdentifier:@"RegistInfoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary*dict = self.dataSource[indexPath.row];
    cell.projectLabel.text = dict[@"project"];
    return cell;
}

#pragma mark - Action

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.alpha = 0;
}

-(void)next{
    
}


@end
