//
//  WalletHomeListModel.h
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletHomeListModel : NSObject

@property (assign, nonatomic) NSInteger catetoryId;
@property (copy, nonatomic) NSString *catetoryName;
@property (copy, nonatomic) NSString *catetoryIcon;
@property (assign, nonatomic) double yusuan;
@property (assign, nonatomic) double yizhichi;


@end

NS_ASSUME_NONNULL_END
