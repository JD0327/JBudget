//
//  SelectCatetoryViewController.m
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "SelectCatetoryViewController.h"

@interface CatetoryListModel : NSObject
@property (copy, nonatomic) NSString *catetoryName;
@property (copy, nonatomic) NSString *catetoryIcon;
@end

@implementation CatetoryListModel
@end

@interface CatetoryListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imageIcon;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation CatetoryListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imageIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageIcon];
        [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(18));
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.imageIcon.mas_right).offset(15);
        }];
    }
    return self;
}

@end

@interface SelectCatetoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation SelectCatetoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CATETORY LIST";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset((kIPhoneX?88:64));
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatetoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CatetoryListModel *model = (CatetoryListModel *)self.dataList[indexPath.row];
    cell.imageIcon.image = [UIImage imageNamed:model.catetoryIcon];
    cell.titleLabel.text = model.catetoryName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CatetoryListModel *model = (CatetoryListModel *)self.dataList[indexPath.row];
    if (self.selectCompleteBlock) {
        self.selectCompleteBlock(model.catetoryName, model.catetoryIcon);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = ColorMake(80, 80, 80);
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        [_tableView registerClass:[CatetoryListCell class] forCellReuseIdentifier:@"Cell"];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (NSArray *)dataList {
    if (!_dataList) {
        NSArray *icons = @[
            @{@"catetoryName":@"HOUSE RENT", @"catetoryIcon":@"fangzu"},
            @{@"catetoryName":@"TRANSPORTATION", @"catetoryIcon":@"jiaotong"},
            @{@"catetoryName":@"CATERING", @"catetoryIcon":@"canyin"},
            @{@"catetoryName":@"PHONE", @"catetoryIcon":@"phone"},
            @{@"catetoryName":@"CIGARETTE", @"catetoryIcon":@"yan"},
            @{@"catetoryName":@"CREDIT CARD", @"catetoryIcon":@"card"},
            @{@"catetoryName":@"OTHER", @"catetoryIcon":@"other"},
        ];
        _dataList = [CatetoryListModel mj_objectArrayWithKeyValuesArray:icons];
    }
    return _dataList;
}
@end
