//
//  RealmManager.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "RealmManager.h"
#import <Realm/Realm.h>

@implementation RealmManager

+ (RLMRealm *)defaultRealm {
    return [RLMRealm realmWithURL:CATETORY_DATABASE];
}

+ (BOOL)insertObjectWithObjects:(NSArray <RLMObject *>*)objcs withType:(ObjectType)type {
    RLMRealm *realm;
    if (type == ObjectTypeCatetory) {
        realm = [RLMRealm realmWithURL:CATETORY_DATABASE];
    }else if (type == ObjectTypeRecord) {
        
    }
    [realm transactionWithBlock:^{
        for (RLMObject *obj in objcs) {
            [realm addObject:obj];
        }
        [realm commitWriteTransaction];
    }];
    return NO;
}

@end
