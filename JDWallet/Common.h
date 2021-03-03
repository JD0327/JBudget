//
//  Common.h
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kIPhoneX ({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define VALID_STRING(obj)           ([obj isKindOfClass:[NSString class]] ? obj : @"")








#define VC_BACKGROUND_COLOR         ColorMake(ColorMake(243, 245, 247), ColorMake(20, 18, 19))

#endif /* Common_h */
