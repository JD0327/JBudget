//
//  WalletHomeViewController.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "WalletHomeViewController.h"
#import "WalletHomeTableViewCell.h"
#import "WalletHomeHeaderView.h"
#import "AddCatetoryViewController.h"
#import "AddRecordViewController.h"
#import "CatetoryModel.h"
#import "RecordModel.h"
#import "WalletHomeListModel.h"

@interface WalletHomeViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) WalletHomeHeaderView *headerView;
@end

#define HEADER_VIEW_HEIGHT 100.f

@implementation WalletHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *date = [[NSUserDefaults standardUserDefaults] valueForKey:@"walletDate"];
    if (!date || date.length <= 0) {
        date = [[NSDate date] yn_stringWithFormat:@"yyyy-MM"];
    }
    
    // 查总账
    RLMResults *result1 = [CatetoryModel allObjectsInRealm:[RealmManager defaultRealm]];
    double num = 0;
    for (CatetoryModel *model in result1) {
        num = num + model.catetoryBudget;
    }
    self.headerView.budgetValue = num;
    
    // 查那个
    RLMResults *result2 = [RecordModel objectsInRealm:[RealmManager defaultRealm] where:[NSString stringWithFormat:@"month='%@'",date]];
    double zhichu = 0;
    for (RecordModel *model in result2) {
        zhichu = zhichu + model.yizhichu;
    }
    self.headerView.yizhichu = zhichu;
    self.headerView.shengyu = num - zhichu;
    
    // 查这个
    NSMutableArray *marray = @[].mutableCopy;
    for (CatetoryModel *cmodel in result1) {
        RLMResults *results = [RecordModel objectsInRealm:[RealmManager defaultRealm] where:[NSString stringWithFormat:@"catetoryId=%ld AND month='%@'",cmodel.catetoryId,date]];
        if (results.count > 0) {
            WalletHomeListModel *model = [[WalletHomeListModel alloc] init];
            model.catetoryIcon = cmodel.catetoryIcon;
            model.catetoryName = cmodel.catetoryName;
            model.catetoryId = cmodel.catetoryId;
            model.yusuan = cmodel.catetoryBudget;
            double yizhichu = 0;
            for (RecordModel *rmodel in results) {
                yizhichu += rmodel.yizhichu;
            }
            model.yizhichi = yizhichu;
            [marray addObject:model];
        }
    }
    
    self.dataList = marray;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.leftBtn];
    [self.navigationController.navigationBar addSubview:self.rightBtn];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset((kIPhoneX?88:64));
        make.left.right.bottom.equalTo(self.view);
    }];
    
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

#pragma mark - action
- (void)addCatetory:(UIButton *)sender {
    AddCatetoryViewController *vc = [[AddCatetoryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addRecord:(UIButton *)sender {
    RLMResults *results = [CatetoryModel allObjectsInRealm:[RealmManager defaultRealm]];
    if (results.count > 0) {
        AddRecordViewController *vc = [[AddRecordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        AddCatetoryViewController *vc = [[AddCatetoryViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)selectTime:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    WSDatePickerView *picker = [[WSDatePickerView alloc] initWithDateStyle:WSDateStyleShowYearMonth CompleteBlock:^(NSDate * _Nonnull date) {
        NSString *dateString = [date yn_stringWithFormat:@"yyyy-MM"];
        [[NSUserDefaults standardUserDefaults] setValue:dateString forKey:@"walletDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [weakSelf viewWillAppear:NO];
        weakSelf.leftBtn.titleLabel.text = dateString;
        [weakSelf.leftBtn setTitle:dateString forState:normal];
    }];
    picker.maxLimitDate = [NSDate date];
    picker.minLimitDate = [NSDate yn_dateWithString:@"2021-01-01 00:00:00" format:@"yyyy-MM-dd HH:mm:ss"];
    [picker show];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat hideCellHeight = scrollView.contentOffset.y + HEADER_VIEW_HEIGHT - cell.frame.origin.y;
        CGRect maksFrame = cell.bounds;
        if (hideCellHeight > 0 && hideCellHeight <= cell.frame.size.height) {
            maksFrame =  CGRectMake(0, hideCellHeight, cell.frame.size.width, cell.frame.size.height - hideCellHeight);
          } else if (hideCellHeight > cell.frame.size.height) {
            maksFrame = CGRectZero;
        }
        [self clipOutSideCellWhenUnderTransparencySectionSetMaskFrame:maksFrame cell:cell];
    }];
}

- (void)clipOutSideCellWhenUnderTransparencySectionSetMaskFrame:(CGRect)frame cell:(UITableViewCell *)cell {
    CALayer *maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    maskLayer.frame = frame;
    cell.layer.mask = maskLayer;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"THERE IS NOTHING~" attributes:@{NSForegroundColorAttributeName:ColorMake(153, 161, 168), NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]}];
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
        NSString *date = [[NSUserDefaults standardUserDefaults] valueForKey:@"walletDate"];
        if (!date || date.length <= 0) {
            date = [[NSDate date] yn_stringWithFormat:@"yyyy-MM"];
        }
        [_leftBtn setTitle:date forState:normal];
        [_leftBtn setImage:[UIImage imageNamed:@"date_select_btn"] forState:normal];
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftBtn.titleLabel.font = AppFont(15);
        [_leftBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, 68, 1, -68);
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightBtn.frame = CGRectMake(kScreenW-48, 0, 44, 44);
        [_rightBtn setImage:[UIImage imageNamed:@"catetory_add_btn"] forState:normal];
        [_rightBtn addTarget:self action:@selector(addCatetory:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (WalletHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[WalletHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, HEADER_VIEW_HEIGHT)];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = ColorMake(80, 80, 80);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[WalletHomeTableViewCell class] forCellReuseIdentifier:@"Cell"];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addBtn setTitle:@"ADD" forState:normal];
        _addBtn.titleLabel.font = AppFont(15);
        [_addBtn setTitleColor:ColorMake(15, 15, 15) forState:normal];
        _addBtn.backgroundColor = ColorMakeWith16Color(0xd7dfea);
        _addBtn.layer.cornerRadius = 20;
        _addBtn.layer.shadowColor = ColorMakeWith16Color(0, 0.4).CGColor;
        _addBtn.layer.shadowOffset = CGSizeZero;
        _addBtn.layer.shadowRadius = 2;
        _addBtn.layer.shadowOpacity = 0.6;
        [_addBtn addTarget:self action:@selector(addRecord:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
