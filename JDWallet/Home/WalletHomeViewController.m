//
//  WalletHomeViewController.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "WalletHomeViewController.h"
#import "WalletHomeHeaderView.h"

@interface WalletHomeViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) WalletHomeHeaderView *headerView;
@end

@implementation WalletHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:ColorMakeWith16Color(0xd7dfea)];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar addSubview:self.leftBtn];
    [self.navigationController.navigationBar addSubview:self.rightBtn];
    
    //添加渐变背景
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,kScreenW,kScreenH-88);
    gl.startPoint = CGPointMake(0.5,0);
    gl.endPoint = CGPointMake(0.5,1);
    gl.colors = @[(__bridge id)ColorMakeWith16Color(0xd7dfea).CGColor, (__bridge id)ColorMake(243, 245, 247).CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self.view.layer addSublayer:gl];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.mj_header = [YNRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        if (@available(iOS 11.0, *)) {
            if (kIPhoneX) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-5);
            }else {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
            }
        }else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        }
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"啥也没有~" attributes:@{NSForegroundColorAttributeName:ColorMake(153, 161, 168), NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]}];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - getter
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftBtn.frame = CGRectMake(15, 0, 85, 44);
        [_leftBtn setTitle:@"2022-03" forState:normal];
        [_leftBtn setImage:[UIImage imageNamed:@"date_select_btn"] forState:normal];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 68, 0, -68);
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightBtn.frame = CGRectMake(kScreenW-48, 0, 44, 44);
        [_rightBtn setImage:[UIImage imageNamed:@"catetory_add_btn"] forState:normal];
    }
    return _rightBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (WalletHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[WalletHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    }
    return _headerView;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addBtn setTitle:@"来一发" forState:normal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        [_addBtn setTitleColor:ColorMake(15, 15, 15) forState:normal];
        _addBtn.backgroundColor = ColorMakeWith16Color(0xd7dfea);
        _addBtn.layer.cornerRadius = 20;
        _addBtn.layer.shadowColor = ColorMakeWith16Color(0, 0.4).CGColor;
        _addBtn.layer.shadowOffset = CGSizeZero;
        _addBtn.layer.shadowRadius = 2;
        _addBtn.layer.shadowOpacity = 0.6;
    }
    return _addBtn;
}

@end
