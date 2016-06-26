//
//  HGTabBarController.m
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import "HGTabBarController.h"
#import "HGTabBar.h"
#import <objc/runtime.h>

NSString * const HGViewControllerHidesBottomBarNotification = @"HGViewControllerHidesBottomBarNotification";

@interface HGTabBarController () <HGTabBarDelegate>

@property (nonatomic, strong) UIView            *currentView; // <-当前的视图view
@property (nonatomic, assign) BOOL  isNavigationController;// <- 子控制器都是导航控制器

@end

@implementation HGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    [self setupControllers];
    [self setupTabBar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isNavigationController)   _tabBar.hidden = NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_isNavigationController)   _tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupControllers
{
    for (NSInteger i=0; i<_viewControllers.count; i++) {
        UINavigationController *controller=(UINavigationController *)_viewControllers[i];
        if([controller isKindOfClass:[UINavigationController class]]){
            self.isNavigationController=YES;
            self.navigationController.navigationBar.hidden=YES;
            controller.topViewController.title=_tabBar.titles[i];
        }
        UIView *view=controller.view;
        view.frame=self.view.bounds;
        [self addChildViewController:controller];
    }
    
    // 默认选中第一个控制器
    _selectedViewController=_viewControllers.firstObject;
    _currentView=_viewControllers.firstObject.view;
    _selectedIndex=0;
    if(!_isNavigationController) self.title=_tabBar.titles[_selectedIndex];
    [self.view addSubview:_currentView];
    
}

- (void)setupTabBar
{
    CGFloat height=_tabBarHeight >0 ? _tabBarHeight : 49;
    _tabBar.backgroundColor=[UIColor whiteColor];
    _tabBar.frame=CGRectMake(0, self.view.frame.size.height-height, self.view.frame.size.width, height);
    [self.view addSubview:_tabBar];
    _tabBar.delegate=self;
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _tabBar.selectedIndex=selectedIndex;
    _selectedIndex=selectedIndex;
}

// 这里需要自己根据项目需求实现
- (void)back
{
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HGTabBarDelegate
-(void)tabBar:(HGTabBar *)tabBar didSelectItem:(NSUInteger)tag
{
    [self moveToController:tag];
}

- (void)moveToController:(NSUInteger )index
{
    // 1.如果点击的是同一个控制器,直接返回
    if (_selectedIndex==index) return;
    
    // 2.将之前的视图移除,并将选中的视图添加到self.view
    [_currentView removeFromSuperview];

    _currentView=self.viewControllers[index].view;
    [self.view addSubview:_currentView];
    [self.view addSubview:_tabBar];
    
    if(!_isNavigationController) self.title=_tabBar.titles[index];
    
    // 3.返回状态和更新代理方法
    _selectedViewController=_viewControllers[index];
    _selectedIndex=index;
    if (_delegate&&[_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [self.delegate tabBarController:self didSelectViewController:_viewControllers[_selectedIndex]];
    }
    
}

@end

#pragma mark - UIViewController分类
@implementation UIViewController (HGTabBarController)

- (void)setHg_tabBarItem:(HGTabbarButton *)hg_tabBarItem
{
    self.hg_tabBarItem=hg_tabBarItem;
}

- (HGTabbarButton *)hg_tabBarItem
{
    return getTabBarItem(self);
}


- (HGTabBarController *)hg_tabBarController
{
    return getTabBarController(self);
}

UIKIT_STATIC_INLINE HGTabbarButton *getTabBarItem(UIViewController *viewController) {
    
    HGTabBarController *tabBarController=getTabBarController(viewController);
    
    for (UIViewController *parentViewController = viewController; ;parentViewController = parentViewController.parentViewController)
    {
        if ([tabBarController.viewControllers containsObject:parentViewController]) {
            NSInteger index=[tabBarController.viewControllers indexOfObject:parentViewController];
            return tabBarController.tabBar.subviews[1].subviews[index];
        }
    }
}

UIKIT_STATIC_INLINE HGTabBarController *getTabBarController(UIViewController *viewController){
    
    for (UIViewController *parentViewController = viewController; ;parentViewController = parentViewController.parentViewController)
    {
        if (parentViewController == nil) NSCAssert1(NO, @"%@ 不是HGTabBarController的直接或者间接的子控制器", viewController);
        if ([parentViewController isKindOfClass:[HGTabBarController class]])
        return (HGTabBarController *)parentViewController;
    }
}


@end


