//
//  DemoViewController.m
//  HGTabBarController
//
//  Created by 查昊 on 16/6/17.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import "DemoViewController.h"
#import "Demo1ViewController.h"
#import "HGTabBarController.h"
#import "HGTabBar.h"

@implementation DemoViewController
- (IBAction)push:(id)sender {
    // push到demo1
    Demo1ViewController *demo1=[[Demo1ViewController alloc]init];
    [self.navigationController pushViewController:demo1 animated:YES];
    self.hg_tabBarItem.badgeValue=@"1"; // 设置提醒小红点
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 随机背景色
    self.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(100)/100.0
                                              green:arc4random_uniform(100)/100.0
                                               blue:arc4random_uniform(100)/100.0
                                              alpha:1];
}

@end
