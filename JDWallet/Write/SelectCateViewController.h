//
//  SelectCateViewController.h
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectCateViewController : BaseViewController
@property (copy, nonatomic) void(^selectCompleteBlock)(NSInteger catetoryId,NSString *catetoryName, NSString *catetoryIconName);

@end

NS_ASSUME_NONNULL_END
