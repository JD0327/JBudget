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
        label1.text = @"剩余";
        label1.textColor = ColorMake(153, 153, 153);
        label1.font = [UIFont systemFontOfSize:12];
        [contentView1 addSubview:label1];
        
        self.value1 = [[UILabel alloc] init];
        self.value1.text = @"0.00";
        self.value1.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        self.value1.textColor = ColorMake(15, 15, 15);
        [contentView1 addSubview:self.value1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView1.mas_top);
            make.centerX.equalTo(contentView1.mas_centerX);
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
        label2.text = @"已用";
        label2.textColor = ColorMake(153, 153, 153);
        label2.font = [UIFont systemFontOfSize:12];
        [contentView2 addSubview:label2];
        
        self.value2 = [[UILabel alloc] init];
        self.value2.text = @"0.00";
        self.value2.font = [UIFont systemFontOfSize:28 weight:UIFontWeightBold];
        self.value2.textColor = ColorMake(15, 15, 15);
        [contentView2 addSubview:self.value2];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView2.mas_top);
            make.centerX.equalTo(contentView2.mas_centerX);
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
        label3.text = @"总预算";
        label3.textColor = ColorMake(153, 153, 153);
        label3.font = [UIFont systemFontOfSize:12];
        [contentView3 addSubview:label3];
        
        self.value3 = [[UILabel alloc] init];
        self.value3.text = @"0.00";
        self.value3.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        self.value3.textColor = ColorMake(15, 15, 15);
        [contentView3 addSubview:self.value3];
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView3.mas_top);
            make.centerX.equalTo(contentView3.mas_centerX);
            make.height.equalTo(@(15));
        }];
        
        [self.value3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3.mas_bottom).offset(3);
            make.centerX.equalTo(view3.mas_centerX);
            make.bottom.equalTo(contentView3.mas_bottom);
        }];
    }
    return self;
}

@end
