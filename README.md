HGTabBarController
==============
如何使用
==============
###导入头文件
	#import "HGTabBar.h"
	#import "HGTabBarController.h"

###初始化
```
// 初始化tabbar
HGTabBar *tabbar=[[HGTabBar alloc]init];
    [tabbar tabbarWithTitles:@[@"首页",@"消息",@"发现",@"我"]// 标题
               titleNorColor:[UIColor grayColor]// 普通颜色
               titleSelColor:[UIColor orangeColor]// 选中颜色
                normalImages:@[@"tabbar_home",//普通图片
                               @"tabbar_message_center",
                               @"tabbar_discover",
                               @"tabbar_profile"]
                         selImges:@[@"tabbar_home_highlighted",// 选中图片
                               @"tabbar_message_center_highlighted",
                               @"tabbar_discover_highlighted",
                               @"tabbar_profile_highlighted"]];
    tabbar.buttonAlignment=HGTabBarButtonVertical;// 样式
    HGTabBarController *tb=[[HGTabBarController alloc]init];
    tb.tabBar=tabbar;
// 添加子控制器    
    NSMutableArray *controllers=[NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=0; i<4; i++) {
        DemoViewController *demo=[[DemoViewController alloc]init];
        [controllers addObject:demo];
    }
// 设置子控制器   
    tb.viewControllers=controllers;
    tb.hidesBottomBarWhenPushed=YES;
// push    
    [self.navigationController pushViewController:tb animated:YES];	
```

#项目演示
`查看并运行 	HGTabBarController/demo`

```
	原生
```
![(图1)](http://images.cnblogs.com/cnblogs_com/zhahao/843050/o_HGTabBarController-1.png)

```
	被导航控制器包装过的控制器并且水平居中样式
```

![(图2)](http://images.cnblogs.com/cnblogs_com/zhahao/843050/o_HGTabBarController-2.png)

```
	没有被导航控制器包装过的控制器并且垂直居中样式
```

![(图3)](http://images.cnblogs.com/cnblogs_com/zhahao/843050/o_HGTabBarController-3.png)

系统要求
==============
该项目最低支持 `iOS 7.0` 和 `Xcode 7.0`。


注意
==============


许可证
==============
HGTabBarController 使用 MIT 许可证，详情见 LICENSE 文件。