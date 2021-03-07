//
//  RealmManager.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "RealmManager.h"
#import <Realm/Realm.h>
#import "CatetoryModel.h"

#define CATETORY_DATABASE [NSURL URLWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"wallet.realm"]]

@implementation RealmManager

+ (RLMRealm *)defaultRealm {
    
    return [RLMRealm realmWithURL:CATETORY_DATABASE];
}

+ (void)insertObjectWithObjects:(NSArray <RLMObject *>*)objcs complete:(nonnull void (^)(NSError * _Nullable))complete {
    // 获取数据库
    RLMRealm *realm = [RealmManager defaultRealm];
    [realm transactionWithBlock:^{
        for (RLMObject *obj in objcs) {
            [realm addObject:obj];
        }
        [realm commitWriteTransaction];
        if (complete) {
            complete(nil);
        }
    }];
}

@end
