//
//  HGTabBarController.h
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HGTabBar;
@protocol HGTabBarControllerDelegate;

@interface HGTabBarController : UIViewController

/// 控制器数组,可以是导航控制器包装过的控制器,也可以不是.
@property(nullable, nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;

/// 当前选中的控制器
@property(nullable, nonatomic, assign) __kindof UIViewController *selectedViewController;

/// 当前选中的控制器的索引
@property(nonatomic,readonly) NSUInteger selectedIndex;

/// tabBar高度,默认49,和原生的一样
@property (nonatomic, assign) CGFloat  tabBarHeight;

/// tabBar,可以自定义
@property(nonatomic, readwrite) HGTabBar *tabBar;

/// 代理
@property (nonatomic, assign) id<HGTabBarControllerDelegate> delegate;

/// 返回按钮
@property(nullable, nonatomic,strong) UIBarButtonItem *leftBarButtonItem;

@end


@protocol HGTabBarControllerDelegate <NSObject>
@optional
/// 选中控制器之后
- (void)tabBarController:(HGTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end
NS_ASSUME_NONNULL_END

