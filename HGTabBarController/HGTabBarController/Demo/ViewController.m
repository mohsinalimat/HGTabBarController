//
//  ViewController.m
//  HGTabBarController
//
//  Created by 查昊 on 16/6/18.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import "ViewController.h"
#import "HGTabBarController.h"
#import "HGTabBar.h"
#import "DemoViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (IBAction)hasNavPush:(id)sender {
    [self pushNeedNav:YES];
}

- (IBAction)noneNavPush:(id)sender {
    [self pushNeedNav:NO];
}


- (void )pushNeedNav:(BOOL)flag {

    
    HGTabBar *tabbar=[[HGTabBar alloc]init];
    [tabbar tabbarWithTitles:@[@"首页",@"消息",@"发现",@"我"]
               titleNorColor:[UIColor grayColor]
               titleSelColor:[UIColor orangeColor]
                normalImages:@[@"tabbar_home",
                               @"tabbar_message_center",
                               @"tabbar_discover",
                               @"tabbar_profile"]
     
                    selImges:@[@"tabbar_home_highlighted",
                               @"tabbar_message_center_highlighted",
                               @"tabbar_discover_highlighted",
                               @"tabbar_profile_highlighted"]];
    if(!flag) tabbar.buttonAlignment=HGTabBarButtonVertical;
    
    // 替换掉第三个按钮,测试
    HGTabbarButton *btn=[[HGTabbarButton alloc]init];
    btn.backgroundColor=[UIColor greenColor];
    [btn setTitle:@"替换" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tabbar_discover_highlighted"] forState:UIControlStateSelected];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame=CGRectMake(self.view.bounds.size.width/2, -6, self.view.bounds.size.width/4, 55);
    [tabbar replaceBarTabBarItemIndex:2 tabBarItem:btn];
    
    HGTabBarController *tb=[[HGTabBarController alloc]init];
    tb.tabBar=tabbar;
    
    NSMutableArray *controllers=[NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=0; i<4; i++) {
        DemoViewController *demo=[[DemoViewController alloc]init];
        if (flag) {
            UINavigationController *nav= [self getNavController:demo];
            [controllers addObject:nav];
        }else{
            [controllers addObject:demo];
        }
    }
    
    tb.viewControllers=controllers;
    tb.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:tb animated:YES];
}

- (UINavigationController *)getNavController:(UIViewController *)vc
{
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    return nav;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


@end
