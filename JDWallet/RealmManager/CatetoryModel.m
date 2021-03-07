//
//  CatetoryModel.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "CatetoryModel.h"

@implementation CatetoryModel

- (NSInteger)incrementaId {
    RLMResults *results = [CatetoryModel allObjectsInRealm:[RealmManager defaultRealm]];
    CatetoryModel *model = results.lastObject;
    if (!model) {
        return 1;
    }
    return model.catetoryId + 1;
}

+ (NSString *)primaryKey {
    return @"catetoryId";
}

@end
