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
@interface DemoViewController ()

@end

@implementation DemoViewController
- (IBAction)push:(id)sender {
//    Demo1ViewController *demo1=[[Demo1ViewController alloc]init];
//    
//    [self.navigationController pushViewController:demo1 animated:YES];
    self.hg_tabBarItem.badgeValue=@"2222";
//    self.hg_tabBarController.selectedIndex=2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(100)/100.0
                                              green:arc4random_uniform(100)/100.0
                                               blue:arc4random_uniform(100)/100.0
                                              alpha:1];
    self.hg_tabBarItem.badgeValue=@"3333";
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
