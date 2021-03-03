//
//  AppDelegate.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/2.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "AppDelegate.h"
#import "WalletHomeViewController.h"
#import "CatetoryModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = VC_BACKGROUND_COLOR;
    self.window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewController:[[WalletHomeViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
