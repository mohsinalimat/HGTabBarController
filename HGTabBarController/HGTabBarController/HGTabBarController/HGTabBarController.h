//
//  HGTabBarController.h
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//  GitHub:https://github.com/zhahao/HGTabBarController

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HGTabBar,HGTabbarButton;
@protocol HGTabBarControllerDelegate;

@interface HGTabBarController : UIViewController

/// 控制器数组,可以是导航控制器包装过的控制器,也可以不是.
@property(nullable, nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;

/// 当前选中的控制器
@property(nullable, nonatomic, assign) __kindof UIViewController *selectedViewController;

/// 当前选中的控制器的索引
@property(nonatomic, assign) NSUInteger selectedIndex;

/// tabBar高度,默认49,和原生的一样
@property(nonatomic, assign) CGFloat  tabBarHeight;

/// tabBar,可以自定义
@property(nonatomic, readwrite) HGTabBar *tabBar;

/// 代理
@property(nonatomic, assign) id<HGTabBarControllerDelegate> delegate;

/// 返回按钮,需要自己根据项目需求实现,.m文件内需要修改
@property(nullable, nonatomic,strong) UIBarButtonItem *leftBarButtonItem;

@end

@protocol HGTabBarControllerDelegate <NSObject>
@optional
/// 选中控制器之后
- (void)tabBarController:(HGTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end


@interface UIViewController (HGTabBarController)

@property(null_resettable, nonatomic, strong) HGTabbarButton *hg_tabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.

@property(nullable, nonatomic, readonly, strong) HGTabBarController *hg_tabBarController; // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.

@end


NS_ASSUME_NONNULL_END

