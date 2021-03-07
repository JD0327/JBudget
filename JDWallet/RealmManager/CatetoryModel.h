//
//  CatetoryModel.h
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import <Realm/Realm.h>

@interface CatetoryModel : RLMObject
 
@property NSInteger catetoryId;
@property NSString *catetoryName;
@property NSString *catetoryIcon;
@property double    catetoryBudget;

- (NSInteger)incrementaId;

@end

RLM_ARRAY_TYPE(CatetoryModel)
