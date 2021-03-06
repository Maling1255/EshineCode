//
//  MMTrainOfflineCreateController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOfflineCreateController.h"
#import "MMTrainOfflineCreateHead.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MMTrainCreateContentCell.h"
#import "MMTrainOfflineCreateTaskCell.h"
#import "MMTaskEditViewController.h"
#import "MMTrainIOfflineTaskEditController.h"
#import "PSCompanyAddressViewController.h"
@interface MMTrainOfflineCreateController ()<UITableViewDelegate,UITableViewDataSource,PSCompanyAddressViewControllerDelegate>
@property(nonatomic,strong)MMTrainOfflineCreateHead *headView;
@property(nonatomic,strong)UIButton *btnAddTrain;
@end

@implementation MMTrainOfflineCreateController

-(UIButton *)btnAddTrain{
    if(_btnAddTrain == nil){
        _btnAddTrain = [UIButton new];
        [_btnAddTrain setImage:[UIImage imageNamed:@"bth_icon_tianjia"] forState:UIControlStateNormal];
        [_btnAddTrain setTitle:@"添加内容模块" forState:UIControlStateNormal];
        [_btnAddTrain setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnAddTrain.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_btnAddTrain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnAddTrain addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddTrain;
}

-(MMTrainOfflineCreateHead *)headView{
    if(_headView == nil){
        _headView = [[MMTrainOfflineCreateHead alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 177.0f)];
    }
    return _headView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"发布培训";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self OCSetUpNavItem];
    [self OCSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)OCSetUpNavItem{
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    completeBtn.frame = CGRectMake(0, 0, 40, 20);
    [completeBtn setTitle:@"提交" forState:UIControlStateNormal];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [completeBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(OCcompleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;
}

-(void)OCSetUpSubviews{
    WeakSelf();
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MMTrainCreateContentCell class] forCellReuseIdentifier:@"MMTrainCreateContentCell"];
    [self.tableView registerClass:[MMTrainOfflineCreateTaskCell class] forCellReuseIdentifier:@"MMTrainOfflineCreateTaskCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.headView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0,0, 44.0f, 0));
    }];
    
    [self.view addSubview:self.btnAddTrain];
    [_btnAddTrain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_headView setBtnLocationClickBlock:^{
        PSCompanyAddressViewController *vc = [PSCompanyAddressViewController new];
        vc.delegate = self;
        [weakself.navigationController pushViewController:vc animated:YES];
    } PeopleClickBlock:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1.0f;
        }
            break;
        case 1:{
            return 2.0f;
        }
            break;
            
        default:{
            return  0.0f;
        }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            return [tableView fd_heightForCellWithIdentifier:@"MMTrainCreateContentCell"configuration:^(MMTrainCreateContentCell * cell) {
                
            }];
        }
            break;
        case 1:{
            
            return [tableView fd_heightForCellWithIdentifier:@"MMTrainOfflineCreateTaskCell"configuration:^(MMTrainOfflineCreateTaskCell * cell) {
                
            }];
        }
            break;
        default:{
            return 0.0f;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MMTrainCreateContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainCreateContentCell"];
            if(cell == nil){
                cell = [[MMTrainCreateContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainCreateContentCell"];
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            
        }
            break;
        case 1:{
            MMTrainOfflineCreateTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTrainOfflineCreateTaskCell"];
            if(cell == nil){
                cell = [[MMTrainOfflineCreateTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMTrainOfflineCreateTaskCell"];
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
            break;
            
        default:{
            return nil;
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:{
            MMTaskEditViewController *tsVC = [MMTaskEditViewController new];
            [tsVC setNavTitle:@"培训描述"];
            [tsVC setTextViewTextBlock:^(NSString *input) {
                
            }];
            [self.navigationController pushViewController:tsVC animated:YES];
        }
            break;
        case 1:{
            MMTrainIOfflineTaskEditController *vc = [MMTrainIOfflineTaskEditController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 添加按钮点击
-(void)btnAddClick{
    MMTrainIOfflineTaskEditController *vc = [MMTrainIOfflineTaskEditController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 提交按钮点击
-(void)OCcompleteBtnClick{
 
}
#pragma mark - 定位选择
-(void)didSelectCompanyAddress:(NSString *)addr coordinate:(CLLocationCoordinate2D)locationCoordinate{
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
