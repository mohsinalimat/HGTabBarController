//
//  HGTabBarController.m
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import "HGTabBarController.h"
#import "HGTabBar.h"

@interface HGTabBarController ()<HGTabBarDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIView            *currentView; // <-当前的视图view
@property (nonatomic, assign) BOOL  isNavigationController;// <- 子控制器都是导航控制器

@end

@implementation HGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControllers];
    [self setupTabBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_isNavigationController) {
        _tabBar.hidden=NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!_isNavigationController) {
        _tabBar.hidden=NO;
    }
    
}

- (void)setupTabBar
{
    CGFloat height=_tabBarHeight >0 ? _tabBarHeight : 49;
    _tabBar.backgroundColor=[UIColor whiteColor];
    _tabBar.frame=CGRectMake(0, self.view.frame.size.height-height, self.view.frame.size.width, height);
    [self.view addSubview:_tabBar];
    _tabBar.delegate=self;
    
}

- (void)setupControllers
{
    for (NSInteger i=0; i<_viewControllers.count; i++) {
        UINavigationController *controller=(UINavigationController *)_viewControllers[i];
        if([controller isKindOfClass:[UINavigationController class]]){
            controller.delegate=self;
            self.isNavigationController=YES;
            self.navigationController.navigationBar.hidden=YES;
            controller.topViewController.title=_tabBar.titles[i];
            
            UIView *view=controller.view;
            view.frame=self.view.bounds;
            [self addChildViewController:controller];
            
            // 这里可以自己修改返回
            if (_leftBarButtonItem) {
                controller.topViewController.navigationItem.leftBarButtonItem=_leftBarButtonItem;
            }else{
                controller.topViewController.navigationItem.leftBarButtonItem =
                [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(back)];
            }
            
        }
    }
    
    // 默认选中第一个控制器
    _selectedViewController=_viewControllers.firstObject;
    _currentView=_viewControllers.firstObject.view;
    _selectedIndex=0;
    if(!_isNavigationController) self.title=_tabBar.titles[_selectedIndex];
    [self.view addSubview:_currentView];

}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _tabBar.selectedIndex=selectedIndex;
    _selectedIndex=selectedIndex;
}

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
#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count > 1) {
        [_tabBar removeFromSuperview];
    }else{
        [self.view addSubview:_tabBar];
    }

}

@end



