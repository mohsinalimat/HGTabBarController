//
//  HGTabBar.h
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//  GitHub:https://github.com/zhahao/HGTabBarController

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* 按钮排列方式 */
typedef NS_ENUM(NSInteger,HGTabBarButtonAlignment)
{
    HGTabBarButtonHorizontal =0,// 水平
    HGTabBarButtonVertical  // 垂直
};

@protocol HGTabBarDelegate;

@interface HGTabBar : UIView

@property(nullable,nonatomic,assign) id<HGTabBarDelegate> delegate;     // weak reference. default is nil

/*!
 *  赋值方法
 *
 *  @param titles        标题数组
 *  @param normalColor   普通状态按钮文字颜色
 *  @param selectedColor 选择状态下按钮文字颜色
 *  @param normalImges   普通状态下的按钮图片数组
 *  @param selImges      选中状态下的按钮图片数组
 */
-(void)tabbarWithTitles:(nullable NSArray <NSString *> *)titles
          titleNorColor:(UIColor *)normalColor
          titleSelColor:(UIColor *)selectedColor
           normalImages:(nonnull NSArray <NSString *> *)normalImges
               selImges:(nonnull NSArray <NSString *> *)selImges;

/// 所有控制器的标题
@property (nonatomic, strong,readonly) NSArray *titles;
/// 字体, default is 12
@property (nonatomic, strong) UIFont *font;
/// 选择按钮索引
@property (nonatomic, assign,readwrite) NSUInteger  selectedIndex;
/// 按钮对齐方式,默认水平
@property (nonatomic)HGTabBarButtonAlignment  buttonAlignment;

@end

//___________________________________________________________________________________________________

@protocol HGTabBarDelegate<NSObject>
@optional

- (void)tabBar:(HGTabBar *)tabBar didSelectItem:(NSUInteger )tag; // called when a new view is selected by the user (but not programatically)

@end

//自定义按钮
@interface HGTabbarButton : UIButton

@property(nullable, nonatomic, copy) NSString *badgeValue;    // default is nil

@end

NS_ASSUME_NONNULL_END
