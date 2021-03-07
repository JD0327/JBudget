//
//  RecordModel.h
//  JDWallet
//
//  Created by 贾亚宁 on 2021/3/7.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import <Realm/Realm.h>

@interface RecordModel : RLMObject

@property NSInteger recordId;
@property NSInteger catetoryId;
@property NSString *remark;
@property double yizhichu;
@property NSString *month;
@property NSInteger timestamp;

- (NSInteger)incrementaId;

@end

RLM_ARRAY_TYPE(CatetoryModel)
