//
//  BaseViewController.m
//  JDWallet
//
//  Created by ext.jiayaning3 on 2021/3/3.
//  Copyright © 2021 ext.jiayaning3. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (strong, nonatomic) UIButton *backBtn;
@end

@implementation BaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
    self.view.backgroundColor = VC_BACKGROUND_COLOR;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:AppFont(16)}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //添加渐变背景
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (@available(iOS 13.0, *)) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterialDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.alpha = 0.99;
        [imageView addSubview:effectView];
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imageView);
        }];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (!_backBtn && self.rt_navigationController.viewControllers.count > 1) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_backBtn setTitle:@"BACK" forState:normal];
        _backBtn.frame = CGRectMake(10, 0, 44, 44);
        _backBtn.titleLabel.font = AppFont(14);
        [_backBtn addTarget:self action:@selector(backPage:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:_backBtn];
    }
}

- (void)backPage:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
