//
//  WalletHomeTableViewCell.h
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalletHomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WalletHomeTableViewCell : UITableViewCell
@property (strong, nonatomic) WalletHomeListModel *model;
@end

NS_ASSUME_NONNULL_END
