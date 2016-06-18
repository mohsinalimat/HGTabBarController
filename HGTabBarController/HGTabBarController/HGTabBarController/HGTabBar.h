//
//  HGTabBar.h
//  HGTabBarController
//
//  Created by 查昊 on 16/6/11.
//  Copyright © 2016年 Zohar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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
/// 字体
@property (nonatomic, strong) UIFont *font;// default is 12
/// 选择按钮索引
@property (nonatomic, assign,readwrite) NSUInteger  selectedIndex;

/// 内部按钮的一些间距
@property (nonatomic) UIEdgeInsets  titleEdgeInsets;// default is UIEdgeInsetsZero
@property (nonatomic) UIEdgeInsets  imageEdgeInsets;// default is UIEdgeInsetsZero
@property (nonatomic) UIEdgeInsets  contentEdgeInsets;// default is UIEdgeInsetsZero
@property (nonatomic) NSTextAlignment textAlignment;// default is NSTextAlignmentLeft

@end

//___________________________________________________________________________________________________

@protocol HGTabBarDelegate<NSObject>
@optional

- (void)tabBar:(HGTabBar *)tabBar didSelectItem:(NSUInteger )tag; // called when a new view is selected by the user (but not programatically)

@end


NS_ASSUME_NONNULL_END
