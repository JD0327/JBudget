//
//  WalletHomeHeaderView.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "WalletHomeHeaderView.h"

@interface WalletHomeHeaderView ()
@property (strong, nonatomic) UILabel *value1;
@property (strong, nonatomic) UILabel *value2;
@property (strong, nonatomic) UILabel *value3;
@end

@implementation WalletHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view1 = [[UIView alloc] init];
        [self addSubview:view1];
        UIView *view2 = [[UIView alloc] init];
        [self addSubview:view2];
        UIView *view3 = [[UIView alloc] init];
        [self addSubview:view3];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(view2.mas_left);
            make.width.equalTo(view2.mas_width);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(view1.mas_right);
            make.right.equalTo(view3.mas_left);
            make.width.equalTo(view3.mas_width);
        }];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.left.equalTo(view2.mas_right);
            make.width.equalTo(view1.mas_width);
        }];
        
        UIView *contentView1 = [[UIView alloc] init];
        [view1 addSubview:contentView1];
        [contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view1);
            make.centerY.equalTo(view1.mas_centerY);
            make.top.mas_greaterThanOrEqualTo(view1.mas_top);
            make.bottom.mas_lessThanOrEqualTo(view1.mas_bottom);
        }];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = @"LEFT";
        label1.textColor = ColorMake(153, 153, 153);
        label1.font = AppFont(8);
        [contentView1 addSubview:label1];
        
        self.value1 = [[UILabel alloc] init];
        self.value1.text = @"0.00";
        self.value1.font = AppFont(16);
        self.value1.textColor = [UIColor whiteColor];
        [contentView1 addSubview:self.value1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView1.mas_top);
            make.left.equalTo(self.value1.mas_left);
            make.height.equalTo(@(15));
        }];
        
        [self.value1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_bottom).offset(3);
            make.centerX.equalTo(view1.mas_centerX);
            make.bottom.equalTo(contentView1.mas_bottom);
        }];
        
        UIView *contentView2 = [[UIView alloc] init];
        [view2 addSubview:contentView2];
        [contentView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view2);
            make.centerY.equalTo(view2.mas_centerY);
            make.top.mas_greaterThanOrEqualTo(view2.mas_top);
            make.bottom.mas_lessThanOrEqualTo(view2.mas_bottom);
        }];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @"USED";
        label2.textColor = ColorMake(153, 153, 153);
        label2.font = AppFont(12);
        [contentView2 addSubview:label2];
        
        self.value2 = [[UILabel alloc] init];
        self.value2.text = @"0.00";
        self.value2.font = AppFont(28);
        self.value2.textColor = [UIColor whiteColor];
        [contentView2 addSubview:self.value2];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView2.mas_top);
            make.left.equalTo(self.value2.mas_left).offset(2);
            make.height.equalTo(@(15));
        }];
        
        [self.value2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom).offset(3);
            make.centerX.equalTo(view2.mas_centerX);
            make.bottom.equalTo(contentView2.mas_bottom);
        }];
        
        UIView *contentView3 = [[UIView alloc] init];
        [view3 addSubview:contentView3];
        [contentView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(view3);
            make.centerY.equalTo(view3.mas_centerY);
            make.top.mas_greaterThanOrEqualTo(view3.mas_top);
            make.bottom.mas_lessThanOrEqualTo(view3.mas_bottom);
        }];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.text = @"BUDGET";
        label3.textColor = ColorMake(153, 153, 153);
        label3.font = AppFont(8);
        [contentView3 addSubview:label3];
        
        self.value3 = [[UILabel alloc] init];
        self.value3.text = @"0.00";
        self.value3.font = AppFont(16);
        self.value3.textColor = [UIColor whiteColor];
        [contentView3 addSubview:self.value3];
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView3.mas_top);
            make.left.equalTo(self.value3.mas_left);
            make.height.equalTo(@(15));
        }];
        
        [self.value3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3.mas_bottom).offset(3);
            make.centerX.equalTo(view3.mas_centerX);
            make.bottom.equalTo(contentView3.mas_bottom);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = ColorMake(80, 80, 80);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.equalTo(@(0.5));
        }];
    }
    return self;
}

- (void)setBudgetValue:(double)budgetValue {
    _budgetValue = budgetValue;
    NSInteger compare = budgetValue;
    if (budgetValue > compare) {
        self.value3.text = [NSString stringWithFormat:@"%.2f",budgetValue];
    }else {
        self.value3.text = [NSString stringWithFormat:@"%.0f",budgetValue];
    }
}

- (void)setYizhichu:(double)yizhichu {
    _yizhichu = yizhichu;
    NSInteger compare = yizhichu;
    if (yizhichu > compare) {
        self.value2.text = [NSString stringWithFormat:@"%.2f",yizhichu];
    }else {
        self.value2.text = [NSString stringWithFormat:@"%.0f",yizhichu];
    }
}

- (void)setShengyu:(double)shengyu {
    _shengyu = shengyu;
    NSInteger compare = shengyu;
    if (shengyu > compare) {
        self.value1.text = [NSString stringWithFormat:@"%.2f",shengyu];
    }else {
        self.value1.text = [NSString stringWithFormat:@"%.0f",shengyu];
    }
}
@end
