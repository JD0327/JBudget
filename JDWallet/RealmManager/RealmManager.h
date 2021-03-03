//
//  RealmManager.h
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RLMRealm;
@class RLMObject;

typedef NS_ENUM(NSInteger, ObjectType) {
    ObjectTypeCatetory = 0,
    ObjectTypeRecord,
};

@interface RealmManager : NSObject

+ (RLMRealm *)defaultRealm;

+ (BOOL)insertObjectWithObjects:(NSArray <RLMObject *>*)objcs withType:(ObjectType)type;

@end

NS_ASSUME_NONNULL_END
