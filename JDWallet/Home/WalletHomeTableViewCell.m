//
//  WalletHomeTableViewCell.m
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "WalletHomeTableViewCell.h"

@interface WalletHomeTableViewCell ()
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *yusuan;
@property (strong, nonatomic) UILabel *yiyong;
@property (strong, nonatomic) UILabel *sehngyu;
@end

@implementation WalletHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconImg = [[UIImageView alloc] init];
        self.iconImg.image = [UIImage imageNamed:@"fangzu"];
        [self.contentView addSubview:self.iconImg];
        [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.height.equalTo(@(25));
        }];
        
        self.yusuan = [[UILabel alloc] init];
        self.yusuan.text = @"0.00";
        self.yusuan.font = [UIFont systemFontOfSize:16 weight:UIFontWeightThin];
        self.yusuan.textColor = ColorMake(100, 100, 100);
        [self.contentView addSubview:self.yusuan];
        [self.yusuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(1);
            make.left.equalTo(self.iconImg.mas_right).offset(10);
        }];
        
        self.yiyong = [[UILabel alloc] init];
        self.yiyong.text = @"0.00";
        self.yiyong.font = AppFont(18);
        self.yiyong.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.yiyong];
        [self.yiyong mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_centerY).offset(1);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
        self.sehngyu = [[UILabel alloc] init];
        self.sehngyu.text = @"0.00";
        self.sehngyu.font = AppFont(13);
        self.sehngyu.textColor = ColorMake(100, 100, 100);
        [self.contentView addSubview:self.sehngyu];
        [self.sehngyu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY).offset(4);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
    }
    return self;
}

- (void)setModel:(WalletHomeListModel *)model {
    _model = model;
    self.iconImg.image = [UIImage imageNamed:model.catetoryIcon];
    
    NSInteger compare1 = model.yizhichi;
    if (model.yizhichi > compare1) {
        self.yiyong.text = [NSString stringWithFormat:@"%.2f",model.yizhichi];
    }else {
        self.yiyong.text = [NSString stringWithFormat:@"%.0f",model.yizhichi];
    }
    
    NSInteger compare2 = model.yusuan;
    if (model.yusuan > compare2) {
        self.yusuan.text = [NSString stringWithFormat:@"%@-%.2f",model.catetoryName,model.yusuan];
    }else {
        self.yusuan.text = [NSString stringWithFormat:@"%@-%.0f",model.catetoryName,model.yusuan];
    }
    double shengyu = model.yusuan-model.yizhichi;
    NSInteger compare3 = shengyu;
    if (shengyu > compare3) {
        self.sehngyu.text = [NSString stringWithFormat:@"%.2f",shengyu];
    }else {
        self.sehngyu.text = [NSString stringWithFormat:@"%.0f",shengyu];
    }
    if (shengyu < 0) {
        self.sehngyu.textColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    }else {
        self.sehngyu.textColor = ColorMake(100, 100, 100);
    }
}

@end
