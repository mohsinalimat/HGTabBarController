//
//  Demo1ViewController.m
//  HGTabBarController
//
//  Created by 查昊 on 16/6/18.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController
- (IBAction)post:(id)sender {
    NSLog(@"can response");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"第三个控制器";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
