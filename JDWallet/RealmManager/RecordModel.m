//
//  RecordModel.m
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel

- (NSInteger)incrementaId {
    RLMResults *results = [RecordModel allObjectsInRealm:[RealmManager defaultRealm]];
    RecordModel *model = results.lastObject;
    if (!model) {
        return 1;
    }
    return model.recordId + 1;
}

+ (NSString *)primaryKey {
    return @"recordId";
}

@end
