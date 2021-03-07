//
//  AddCatetoryViewController.m
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "AddCatetoryViewController.h"
#import "SelectCatetoryViewController.h"
#import "CatetoryModel.h"

@interface AddCatetoryViewController ()
@property (strong, nonatomic) UIButton *saveBtn;
@property (strong, nonatomic) TWTextInputView *catetoryNameInput;
@property (strong, nonatomic) TWTextInputView *yusuanInput;
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIButton *showIcon;
@property (strong, nonatomic) NSString *catetoryIconName;
@end

@implementation AddCatetoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ADD CATETORY";
    [self.navigationController.navigationBar addSubview:self.saveBtn];
    
    [self.view addSubview:self.catetoryNameInput];
    [self.catetoryNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset((kIPhoneX?108:84));
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(40));
    }];
    
    
    [self.view addSubview:self.yusuanInput];
    [self.yusuanInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.catetoryNameInput.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(40));
    }];
    
    [self.view addSubview:self.showIcon];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yusuanInput.mas_bottom).offset(20);
        make.height.equalTo(@(40));
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.showIcon.mas_left);
    }];
    [self.showIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBtn.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(20));
        make.width.equalTo(@(0));
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = ColorMake(80, 80, 80);
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.catetoryNameInput);
        make.top.equalTo(self.catetoryNameInput.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = ColorMake(80, 80, 80);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.yusuanInput);
        make.top.equalTo(self.yusuanInput.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = ColorMake(80, 80, 80);
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_left);
        make.right.equalTo(self.showIcon.mas_right);
        make.top.equalTo(self.selectBtn.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - action
- (void)saveBtnTap:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (!self.catetoryIconName || self.catetoryIconName.length <= 0 || [self.catetoryNameInput.text isEqualToString:@""] || [self.yusuanInput.text isEqualToString:@""]) {
        return;
    }
    
    CatetoryModel *model = [[CatetoryModel alloc] init];
    model.catetoryId = model.incrementaId;
    model.catetoryIcon = self.catetoryIconName;
    model.catetoryName = self.catetoryNameInput.text;
    model.catetoryBudget = [self.yusuanInput.text doubleValue];
    [RealmManager insertObjectWithObjects:@[model] complete:^(NSError * _Nonnull error) {
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)selectTap:(UIButton *)sender {
    SelectCatetoryViewController *vc = [[SelectCatetoryViewController alloc] init];
    __weak typeof(self)weakSelf = self;
    vc.selectCompleteBlock = ^(NSString * _Nonnull catetoryName, NSString * _Nonnull catetoryIconName) {
        weakSelf.catetoryIconName = catetoryIconName;
        [weakSelf.showIcon setImage:[UIImage imageNamed:catetoryIconName] forState:normal];
        [weakSelf.showIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(20));
        }];
        weakSelf.selectBtn.titleLabel.text = catetoryName;
        [weakSelf.selectBtn setTitle:catetoryName forState:normal];
        [weakSelf.selectBtn setTitleColor:[UIColor whiteColor] forState:normal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UIButton *)saveBtn {
    if (!_saveBtn) {
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [saveBtn setTitle:@"SAVE" forState:normal];
        saveBtn.titleLabel.font = AppFont(14);
        saveBtn.frame = CGRectMake(kScreenW-54, 0, 44, 44);
        [saveBtn addTarget:self action:@selector(saveBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn = saveBtn;
    }
    return _saveBtn;
}

- (TWTextInputView *)catetoryNameInput {
    if (!_catetoryNameInput) {
        _catetoryNameInput = [[TWTextInputView alloc] initWithStyle:TWTextInputViewStyleTextFiled config:^(TWTextInputViewConfig * _Nonnull config) {
            config.maxCount = 10;
        }];
        [_catetoryNameInput setPlaceHolderColor:ColorMake(183, 183, 183) font:AppFont(14)];
        _catetoryNameInput.font = AppFont(14);
        _catetoryNameInput.textColor = [UIColor whiteColor];
        _catetoryNameInput.placeHolder = @"Please enter catetory name ~";
        [_catetoryNameInput setTintColor:[UIColor whiteColor]];
    }
    return _catetoryNameInput;
}

- (TWTextInputView *)yusuanInput {
    if (!_yusuanInput) {
        _yusuanInput = [[TWTextInputView alloc] initWithStyle:TWTextInputViewStyleTextFiled config:^(TWTextInputViewConfig * _Nonnull config) {
            config.maxCount = 10;
            config.regular = TWRegularMoney;
        }];
        [_yusuanInput setPlaceHolderColor:ColorMake(183, 183, 183) font:AppFont(14)];
        _yusuanInput.font = AppFont(14);
        _yusuanInput.textColor = [UIColor whiteColor];
        [_yusuanInput setKeyboardType:UIKeyboardTypeDecimalPad];
        _yusuanInput.placeHolder = @"Please enter catetory budget ~";
        [_yusuanInput setTintColor:[UIColor whiteColor]];
    }
    return _yusuanInput;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_selectBtn setTitle:@"Please select a catetory icon ~" forState:normal];
        _selectBtn.titleLabel.font = AppFont(14);
        [_selectBtn setTitleColor:ColorMake(183, 183, 183) forState:normal];
        [_selectBtn addTarget:self action:@selector(selectTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UIButton *)showIcon {
    if (!_showIcon) {
        _showIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _showIcon.userInteractionEnabled = NO;
    }
    return _showIcon;
}
@end
